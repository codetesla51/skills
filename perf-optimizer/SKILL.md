---
name: perf-optimizer
description: Systematic performance optimization for Go backends, Postgres/SQL, Redis, and HTTP APIs. Use when asked to make code faster, reduce latency or allocations, raise throughput, fix slow queries, or find and remove a bottleneck. Measurement of load, latency and capacity is done with the barrage skill, not here.
---

# Perf Optimizer

## FIRST STEP: load the barrage skill

Before doing anything else, load the barrage skill and read its SKILL.md. Do this before reading code, before profiling, before suggesting any change. All load testing, latency measurement, bottleneck detection, capacity sweeps, and before/after comparison go through barrage. If the barrage skill is not available, stop and tell the user instead of improvising your own load tests.

## Core rules

1. Never optimize without a measurement first. No number, no change.
2. Change ONE thing at a time. Re-measure after every change.
3. Keep a log: change, before number, after number, kept or reverted. Revert anything that does not move the number.
4. Find the real bottleneck layer first (app, database, cache, network), then optimize only that layer.
5. Correctness before speed. Run the tests after every change.
6. Optimize the hot path only. Code that is not on the profile is not touched.
7. Do not add complexity for gains under the noise floor. If benchstat says "~", the change did nothing.

## Measuring: use the barrage skill

Load, latency percentiles (p50/p95/p99), correlated app/DB/Redis spikes, capacity sweeps, and before/after comparison (`barrage compare`, `--fail-on`) all come from the barrage skill. Read it and use it. Do not write ad-hoc load scripts and do not duplicate its instructions here.

Workflow:
1. Use barrage to run a baseline and save the JSON (`--json baseline.json`).
2. Read the verdict: which layer is the bottleneck (app-only, db, redis, masked storage spike).
3. Pick techniques from the matching section below.
4. Make one change.
5. Re-run the same barrage config, save `current.json`, run `barrage compare`.
6. Keep or revert. Log it. Repeat.

Use the micro-level Go tools below only to find WHERE inside the app the time goes, after barrage says the app is the bottleneck.

## Go: micro-level measurement

- `testing.B` benchmarks with `b.ReportAllocs()`
- `go test -bench . -benchmem -count=10` then `benchstat old.txt new.txt`
- `b.RunParallel` for contention behavior
- `b.ResetTimer()` after setup, `b.StopTimer()` around untimed work
- sub-benchmarks with different input sizes to see complexity growth
- pprof CPU profile: `-cpuprofile`, or `net/http/pprof` on a live server
- pprof heap: `inuse_space`, `inuse_objects`, `alloc_space`, `alloc_objects`
- pprof allocs, goroutine, block, mutex profiles (`runtime.SetBlockProfileRate`, `runtime.SetMutexProfileFraction`)
- `go tool pprof -http=:0` flamegraph and `-diff_base` to compare two profiles
- `-top`, `-list FuncName`, `-peek` to drill into a function line by line
- execution tracer: `go test -trace` / `runtime/trace`, then `go tool trace` (scheduler latency, GC pauses, goroutine blocking, syscalls)
- escape analysis: `go build -gcflags='-m -m'`
- inlining decisions: `-gcflags='-m'` (look for "can inline" / "cannot inline: cost exceeds budget")
- bounds-check report: `-gcflags='-d=ssa/check_bce/debug=1'`
- assembly inspection: `go tool objdump`, `go build -gcflags=-S`
- `runtime/metrics` and `runtime.ReadMemStats` for GC count, pause, heap size
- `GODEBUG=gctrace=1` for per-GC-cycle output
- `GODEBUG=schedtrace=1000` for scheduler state
- race detector (`-race`) to confirm a lock-removal change did not break safety
- `perf`, `perf record`/`perf stat` and flamegraphs for system-level view (cache misses, branch misses, syscalls)
- `strace -c` / `bpftrace` / `ltrace` for syscall counts and latency
- `go tool nm -size` and `go tool nm -sort size` for binary size hotspots

## Go: CPU and algorithmic

- Fix the algorithm and big-O before anything micro. O(n^2) to O(n log n) beats every trick below.
- Replace linear scans with maps or sets; replace repeated lookups with a precomputed index
- Sort once, binary search after (`sort.Search`, `slices.BinarySearch`)
- Hoist loop-invariant work out of loops
- Early returns and short-circuit evaluation for the common case
- Fast path for the common case, slow path for the rare case, kept separate so the fast path inlines
- Avoid repeated computation: memoize, precompute tables, compile regexes once at init
- Replace regexp with hand-written parsing, `strings.Index`, `bytes.Cut`, or `strings.Cut` on hot paths
- Avoid `reflect` on hot paths; use generics or codegen instead
- Avoid `fmt.Sprintf` on hot paths; use `strconv.AppendInt`, `strconv.AppendQuote`, and friends
- Avoid `time.Now()` in tight loops (it is a syscall-ish vDSO call); sample it once per batch
- Avoid `defer` in the hottest loops (cheaper since Go 1.14 but still non-zero); call cleanup directly
- Avoid `interface{}` / `any` boxing in hot paths; use concrete types or generics
- Avoid dynamic dispatch in hot loops; prefer concrete types so calls can be inlined
- Keep hot functions small enough to inline (check `-gcflags=-m`); split big functions into fast and slow halves
- Bounds-check elimination: hint the compiler with `_ = s[n-1]` before indexed loops, or range loops instead of indexing, reslice to a known length
- Loop unrolling by hand for tiny fixed-size loops (only if profile proves it)
- Use `math/bits` (`bits.OnesCount`, `bits.LeadingZeros`, `bits.TrailingZeros`) instead of loops
- Bit tricks: power-of-two sizes with `& (n-1)` instead of `%`, shifts instead of multiply/divide by powers of two
- Branch reduction: lookup tables instead of long switch/if chains in hot loops
- Branchless code for unpredictable branches (verify with `perf stat` branch-misses)
- Use `switch` on small integers (compiles to jump table) instead of map lookups
- Perfect hashing / generated lookup for fixed keyword sets (e.g. lexers)
- SIMD / assembly via Go assembly or `golang.org/x/sys/cpu` feature detection, as an absolute last resort
- `unsafe` for zero-cost conversions, only when benchmarked and tested, and isolated behind a small function
- Use `strings.Builder` / `bytes.Buffer` with `Grow` instead of `+=` concatenation in loops
- Use `slices` and `maps` package generic functions (`slices.SortFunc`, `slices.Index`) to avoid interface-based `sort.Slice` overhead
- `sort.Slice` uses reflection-based swapper; `slices.SortFunc` is faster
- Batch work: process N items per call instead of one to amortize call and lock overhead
- Lazy evaluation: do not compute what is never read
- Caching of derived values inside structs (compute once, store)
- Precompute at startup instead of per request
- Pre-size everything you can (see memory section)

## Go: memory and allocations

- Goal: fewer allocations per operation (read `allocs/op` and `B/op`)
- Preallocate slices: `make([]T, 0, n)` when n is known or estimable
- Preallocate maps: `make(map[K]V, n)`
- Reuse slices across iterations with `s = s[:0]`
- `sync.Pool` for short-lived, same-shaped, frequently allocated objects (buffers, encoders, scratch structs); always reset on Get/Put; never pool things with unbounded size without a cap check
- Object free lists / arenas for per-request allocations released together
- Go arenas (`arena` package, experimental) or manual bump allocators for batch-lifetime data
- Pass pointers to big structs, values for small ones (under ~3 words); avoid copying large structs in hot paths
- Avoid pointers where not needed: pointer-free structs are not scanned by GC
- Prefer slices of values (`[]T`) over slices of pointers (`[]*T`): fewer allocations, better locality, less GC scan work
- Use indexes (int32) instead of pointers in big graphs/trees/linked structures (pointer-free arrays are invisible to GC)
- Avoid returning pointers to locals when not needed (forces heap escape); return values
- Avoid closures capturing variables in hot paths (captured vars may escape)
- Avoid `append` growth by preallocating; know that growth doubles then ~1.25x
- Avoid `[]byte`<->`string` conversions (each copies). Use `unsafe.String` / `unsafe.Slice` (Go 1.20+) only when the bytes are never mutated afterward
- Compiler optimizes `m[string(b)]` lookups and `string(b) == "x"` comparisons without allocating; use that pattern
- Substrings share memory with the parent string: a tiny substring can pin a huge string. Clone (`strings.Clone`) if you keep it long
- Avoid `fmt.Sprint`/`Sprintf` for key building in hot paths; use `strconv` + `append`
- Struct field ordering: sort fields largest alignment first to remove padding (`fieldalignment` analyzer)
- Cache-line padding (64 bytes) between independently written fields to avoid false sharing
- Struct of arrays (SoA) instead of array of structs (AoS) when loops touch only one or two fields
- Hot/cold field splitting: keep rarely used fields in a separate struct behind a pointer
- Smaller integer types (int32, uint16) in big arrays to fit more per cache line
- Avoid maps for tiny fixed key sets; use arrays/switch/struct fields
- Replace `map[string]struct{}` / `map[int]bool` with bitsets where keys are dense integers
- Open-addressing or swiss-table style hash maps for hot, large maps (Go 1.24+ built-in map is already swiss-table based)
- Intern repeated strings (`unique` package, Go 1.23+) to cut memory and speed comparisons
- Stream instead of loading whole files/bodies into memory (`io.Reader`, `bufio.Scanner` with sized buffer, `json.Decoder`)
- `bufio.Reader`/`bufio.Writer` with a sized buffer (e.g. 32 to 64 KB) to cut syscalls
- `io.Copy` / `io.CopyBuffer` with a reused buffer; `sendfile`/`splice` fast paths via `io.Copy` between `*os.File` and `net.Conn`
- Do not hold references to big slices after use (set to nil) so GC can free them
- Shrink: copy a small slice out of a large backing array if you keep it long
- `mmap` for large read-only files (`golang.org/x/exp/mmap` or `syscall.Mmap`)
- Compact encodings: varints, delta encoding, bit-packing for big in-memory datasets

## Go: garbage collector and runtime

- `GOGC` tuning: higher = fewer GCs, more memory
- `GOMEMLIMIT` (Go 1.19+): soft memory cap; with `GOGC=off` or high GOGC gives "use all memory up to the limit, then collect" behavior; set about 70 to 90 percent of the container limit
- Heap ballast (old trick) is superseded by GOMEMLIMIT
- Reduce GC work: fewer pointers, fewer live objects, fewer allocations (the best GC tuning is not allocating)
- `GOMAXPROCS`: match to container CPU quota (use `automaxprocs`, or Go 1.25+ container-aware default); wrong value causes throttling and latency spikes
- Pin goroutines to OS threads (`runtime.LockOSThread`) only when needed (e.g. thread-affine C libs)
- Profile-guided optimization (PGO): collect a representative CPU profile from production, save as `default.pgo` in main package dir, build; typically 2 to 14 percent gain; refresh periodically
- Build flags: `-ldflags='-s -w'` for smaller binary (does not change speed much), `-trimpath`
- Keep Go version current; many perf wins come free (swiss maps, better inlining, PGO improvements, GC improvements, `slices` speedups)
- `GOAMD64=v3` on modern x86 to allow AVX2/BMI instructions in compiler output (only if all deploy targets support it)
- `GOEXPERIMENT` features (e.g. green tea GC in newer Go) only after benchmarking
- cgo: avoid on hot paths; each call has overhead (~tens of ns) and breaks inlining

## Go: concurrency

- Concurrency is not parallelism: measure with and without; goroutines add scheduling and sync cost
- Bounded worker pools instead of goroutine-per-item for large fan-outs (`errgroup.SetLimit`, `ants`, `pond`)
- Size the pool to the bottleneck resource (CPU cores for CPU-bound; downstream capacity for IO-bound)
- Pipeline stages connected by buffered channels, sized to absorb jitter
- Batch channel sends (send slices, not single items) to cut channel overhead
- Channels are slower than atomics/mutexes for simple shared state; use the simplest primitive that works
- Reduce lock contention:
  - shorten critical sections (do work outside the lock)
  - shard the lock (N shards by hash of key)
  - `sync.RWMutex` only when reads vastly outnumber writes and critical sections are long enough (RWMutex has overhead; plain Mutex is often faster)
  - `sync.Map` only for append-mostly or disjoint-key workloads
  - `atomic` types (`atomic.Int64`, `atomic.Pointer[T]`) for counters and config swaps
  - copy-on-write with `atomic.Pointer` for read-mostly config/routing tables
  - per-goroutine/per-P local state merged later (e.g. per-worker counters)
- Avoid false sharing: pad hot atomics/counters to separate cache lines
- Lock-free structures (SPSC/MPSC ring buffers, lock-free queues) for proven hot paths; verify with race detector and stress tests
- `singleflight` to collapse duplicate concurrent work (cache stampedes, repeated expensive lookups)
- `context` cancellation and timeouts everywhere so abandoned work stops consuming resources
- Avoid goroutine leaks (check with goroutine profile); leaked goroutines hold memory and slow GC
- Avoid unbounded channel/queue growth; apply backpressure (blocking send, drop, or reject with 429/503)
- Avoid `time.After` in loops (leaks timers pre-1.23); reuse `time.Timer` with `Reset`
- Use `sync.Once`/`sync.OnceValue` for lazy init instead of locking every call
- Avoid `runtime.Gosched()` spin loops; use proper blocking primitives
- Work stealing is built into the scheduler; do not fight it with manual thread pinning
- NUMA awareness on big multi-socket boxes (pin processes per socket)

## Go: I/O and networking

- Reduce syscalls: `bufio`, batching writes, `writev` (`net.Buffers` uses it automatically), larger reads
- `TCP_NODELAY` (Go sets it by default) vs. corking for batched small writes
- Keep-alive connections; reuse `http.Client` and `http.Transport` (never create one per request)
- Tune `http.Transport`: `MaxIdleConns`, `MaxIdleConnsPerHost` (default 2 is far too low for service-to-service), `IdleConnTimeout`, `MaxConnsPerHost`
- Always drain and close response bodies (`io.Copy(io.Discard, resp.Body)` then `Close`) so connections get reused
- Set timeouts on everything: dial, TLS handshake, response header, idle, overall request (`http.Server`: `ReadHeaderTimeout`, `ReadTimeout`, `WriteTimeout`, `IdleTimeout`)
- HTTP/2 for multiplexing many requests over fewer connections; HTTP/3/QUIC for lossy networks
- `SO_REUSEPORT` with multiple listeners/processes to spread accept load across cores
- epoll/io_uring based servers (`gnet`, `evio`, `netpoll`) for extreme connection counts; only after standard `net/http` is proven the limit
- Raw TCP/hand-parsed HTTP/1.1 for ultra-low-overhead servers (your raw-http project): reuse read buffers per connection, parse in place, avoid allocating per request, pipeline-friendly parsing
- Tune socket buffers (`SO_RCVBUF`, `SO_SNDBUF`) for high-bandwidth/high-latency links
- Linux kernel tuning: `somaxconn`, `tcp_max_syn_backlog`, `ulimit -n` (file descriptors), `ip_local_port_range`, `tcp_tw_reuse`, `net.core.netdev_max_backlog`
- Disk: sequential over random IO, `O_DIRECT`/`fsync` batching (group commit), `fdatasync` instead of `fsync` where safe, append-only logs, page cache awareness
- Avoid small file reads in loops; read once and cache, or mmap
- Compress only when it pays: gzip/brotli/zstd for text over slow links, skip for already-compressed data, skip on fast internal links; precompress static assets
- Use `zstd` over gzip for internal service traffic (faster at similar ratio)
- Connection pooling for every downstream (DB, Redis, other services)
- Avoid DNS lookups on hot paths (cache, or resolve once; set `GODEBUG=netdns=go` or `cgo` deliberately)
- TLS: session resumption, keep-alive, modern ciphers with hardware acceleration (AES-GCM, ChaCha20 on ARM without AES), OCSP stapling, terminate TLS at a proxy if appropriate
- Zero-copy file serving with `http.ServeContent`/`io.Copy` to socket (sendfile)

## Serialization and parsing

- `encoding/json` is slow and allocation heavy. Options in increasing effort:
  - `json.NewEncoder` with reused buffer; `json.Decoder` streaming instead of `Unmarshal` of whole body
  - struct types instead of `map[string]any`
  - `json.RawMessage` to defer parsing of parts you do not need
  - faster drop-in libraries (`sonic`, `go-json`, `jsoniter`), or `encoding/json/v2` when stable
  - code generation (`easyjson`, `ffjson`) for zero-reflection marshal/unmarshal
  - partial parsing with `gjson` / `jsonparser` when you need only a few fields
  - hand-written append-style marshalers (`AppendJSON`)
- Binary formats where you control both ends: protobuf, flatbuffers, capnproto, msgpack, gob (gob only Go-to-Go)
- Zero-copy parsing: parse into slices of the input buffer instead of copying strings
- Avoid `strings.Split` allocations in hot loops; use `strings.Cut`, `strings.IndexByte`, or iterators (`strings.SplitSeq`, Go 1.24+)
- Avoid `strings.ToLower`/`ToUpper` allocations when not needed; use `strings.EqualFold` for comparisons
- Byte-level state machines for lexers/parsers (no regexp, no per-token allocation, tokens as offsets into the source)
- Reuse `json.Encoder`, `bytes.Buffer`, and decoder instances through `sync.Pool`
- Pagination and field selection so you serialize less data in the first place

## SQL and Postgres

Find:
- `EXPLAIN (ANALYZE, BUFFERS, VERBOSE, SETTINGS)`; read actual vs estimated rows, loops, buffers hit/read, sort spills ("external merge Disk"), seq scan vs index scan, nested loop vs hash vs merge join
- `pg_stat_statements`: order by `total_exec_time`, `mean_exec_time`, `calls`, `rows`, shared blks read
- `auto_explain` to capture slow plans in production (`log_min_duration_statement` too)
- `pg_stat_user_tables` (seq_scan vs idx_scan, n_dead_tup), `pg_stat_user_indexes` (unused indexes), `pg_statio_*` (cache hit ratio)
- `pg_stat_activity` and `pg_locks` for blocking and long transactions
- `pg_stat_io`, `pg_stat_bgwriter`, `pg_stat_wal` for IO and checkpoint pressure
- Tools: `pgbadger`, `pev2`/explain.dalibo.com, `pgbench`, `pg_stat_monitor`

Queries:
- No `SELECT *`; select only needed columns
- Add `LIMIT`; use keyset (seek) pagination (`WHERE (created_at, id) < ($1, $2) ORDER BY created_at DESC, id DESC LIMIT n`) instead of `OFFSET`
- Kill N+1 queries: use joins, `WHERE id = ANY($1)`, `IN` lists, or batch fetch then stitch in app
- Replace correlated subqueries with joins or lateral joins where the plan is bad
- `EXISTS` instead of `COUNT(*) > 0`; `COUNT(*)` over huge tables is a full scan; use approximate counts (`reltuples`, `pg_class`), cached counters, or `HyperLogLog` where exactness is not required
- Avoid functions on indexed columns in `WHERE` (`WHERE lower(email) = ...` needs an expression index; `WHERE date(created_at) = ...` should be a range on `created_at`)
- Avoid implicit casts that defeat indexes (type mismatch between column and parameter)
- Avoid leading-wildcard `LIKE '%x'`; use `pg_trgm` GIN/GiST index or full-text search (`tsvector` + GIN)
- `OR` across different columns: rewrite as `UNION ALL` or use `bitmap` friendly indexes
- `DISTINCT`/`GROUP BY` on huge sets: index to provide order, or pre-aggregate
- CTEs: since PG12 non-recursive CTEs inline by default; use `MATERIALIZED` / `NOT MATERIALIZED` deliberately
- Use `UNION ALL` instead of `UNION` when duplicates are impossible or acceptable
- Batch writes: multi-row `INSERT ... VALUES (...), (...)`, `COPY` for bulk loads (fastest), `unnest()` arrays for batch upserts, pgx `CopyFrom` and `SendBatch`
- `INSERT ... ON CONFLICT` for upserts instead of select-then-insert
- Avoid per-row round trips: pipeline queries (pgx batch / pipeline mode)
- Prepared statements / statement caching (pgx caches by default; with pgbouncer transaction mode use protocol-level support or disable prepared statements)
- Keep transactions short; never hold a transaction open across network calls or user think-time
- Pick the lowest sufficient isolation level
- `SELECT ... FOR UPDATE SKIP LOCKED` for job-queue style workloads (and reduces lock contention)
- Advisory locks instead of row-lock hot spots for coordination
- Avoid hot-row updates (a single counter row updated by everyone); shard counters or aggregate asynchronously
- Return only what you need from writes (`RETURNING` specific columns), or skip it

Indexes:
- B-tree on columns used in `WHERE`, `JOIN`, `ORDER BY`
- Composite indexes: equality columns first, then range/sort column; order matters
- Covering indexes with `INCLUDE (...)` enabling index-only scans (keep visibility map fresh via vacuum)
- Partial indexes (`WHERE status = 'pending'`) for small hot subsets
- Expression indexes for computed lookups
- GIN for `jsonb`, arrays, full text; GiST/SP-GiST for geometric and range types; BRIN for huge append-only time-ordered tables (tiny index); hash for equality-only (rarely better than btree)
- Index foreign key columns (Postgres does not do it automatically) to speed joins and cascading deletes
- Drop unused and duplicate indexes: every index slows writes and bloats storage
- Build indexes with `CREATE INDEX CONCURRENTLY` in production
- Reindex bloated indexes (`REINDEX CONCURRENTLY`)
- Use `fillfactor` below 100 on update-heavy tables to enable HOT updates
- Do not over-index write-heavy tables

Schema:
- Right data types: `int`/`bigint` over `numeric` when possible, `timestamptz`, `uuid` (prefer time-ordered UUIDv7 over random UUIDv4 for index locality), `text` fine over varchar(n)
- Column ordering to reduce padding (large fixed types first)
- Normalize for integrity, denormalize deliberately for read hot paths
- Partitioning (range by time, list, hash) for huge tables: prunes scans, makes retention drops instant (`DROP PARTITION` instead of `DELETE`)
- Archive/delete old data; smaller tables are faster tables
- `jsonb` for flexible data but extract hot fields into real columns with indexes
- Materialized views for expensive aggregations, refreshed `CONCURRENTLY` on a schedule
- Summary/rollup tables maintained incrementally for dashboards
- `UNLOGGED` tables for disposable high-write data (lost on crash)
- Foreign keys cost writes; keep them for integrity, drop only with a deliberate reason

Maintenance and config:
- `VACUUM`/`autovacuum` tuning (lower scale factors on big hot tables); watch dead tuples and bloat (`pgstattuple`); long transactions block vacuum
- `ANALYZE` after bulk loads; raise `default_statistics_target` or per-column statistics for skewed columns; extended statistics (`CREATE STATISTICS`) for correlated columns
- `shared_buffers` (about 25 percent of RAM), `effective_cache_size` (about 50 to 75 percent of RAM), `work_mem` (per sort/hash node per query: raise carefully), `maintenance_work_mem`, `random_page_cost` (about 1.1 on SSD), `effective_io_concurrency`
- WAL: `wal_buffers`, `max_wal_size`, `checkpoint_timeout`, `checkpoint_completion_target`; `synchronous_commit = off` only for data you can afford to lose a few ms of
- Parallel query settings (`max_parallel_workers_per_gather`) for analytics workloads
- JIT: disable (`jit = off`) for OLTP if it adds latency on short queries
- `huge_pages` on big-memory servers
- Connection management: PgBouncer (transaction pooling) or built-in pool (`pgxpool`) with `MaxConns` sized to a few times CPU cores, not hundreds; too many connections hurts throughput
- Set `statement_timeout`, `idle_in_transaction_session_timeout`, `lock_timeout`
- Read replicas for read-heavy load (mind replication lag; route lag-sensitive reads to primary)
- Move to a bigger instance / faster disks (NVMe) only after query and index fixes
- Sharding (Citus, app-level) only when a single primary truly cannot hold the write load
- MySQL equivalents: `EXPLAIN ANALYZE`, slow query log, `performance_schema`, InnoDB buffer pool size, covering indexes
- SQLite: WAL mode, `synchronous=NORMAL`, `busy_timeout`, prepared statements, batch in transactions, single writer connection

## Redis and caching

- Cache what is expensive and read-heavy; do not cache what is cheap or write-heavy
- Cache-aside pattern with TTL; add jitter to TTLs so keys do not all expire together
- Prevent stampedes: `singleflight`, per-key locks, probabilistic early refresh, serve-stale-while-revalidate
- Negative caching (cache "not found") with short TTL
- Invalidate precisely on writes (delete key) rather than long TTL guessing; or write-through
- In-process cache (ristretto, otter, bigcache, freecache, or a sharded map) in front of Redis for hottest keys: no network hop at all
- Pipelining (`Pipeline`/`TxPipeline`) and `MGET`/`MSET` to cut round trips; Lua scripts or functions for atomic multi-step ops
- Avoid O(n) commands on big keys in production (`KEYS`, `SMEMBERS`, `HGETALL` on huge hashes, `LRANGE 0 -1`); use `SCAN`/`SSCAN`/`HSCAN` and bounded ranges
- Find big keys and hot keys (`redis-cli --bigkeys`, `--hotkeys`, `MEMORY USAGE`), `SLOWLOG`, `LATENCY DOCTOR`, `INFO commandstats`
- Use the right data structure: hash for objects, sorted set for leaderboards/time indexes, bitmap/HyperLogLog for counting uniques, streams for queues
- Compact values: short keys, msgpack/protobuf instead of verbose JSON, compression for large values
- Memory: set `maxmemory` and an eviction policy (`allkeys-lru` / `allkeys-lfu` for caches), avoid swapping
- Persistence tradeoffs: disable RDB/AOF for pure cache; `appendfsync everysec` for balance
- Connection pool sized correctly; reuse clients; set read/write/dial timeouts
- Redis 6+ I/O threads for high-throughput network-bound instances
- Cluster/sharding for datasets or throughput beyond one node; use hash tags only when multi-key ops need co-location
- Client-side caching with server-assisted invalidation (`CLIENT TRACKING`)
- HTTP-level caching: `Cache-Control`, `ETag`/`If-None-Match` with 304, `Last-Modified`, `Vary` set correctly; CDN for static and cacheable API responses

## API and HTTP design

- Cut payload size: field selection, sparse fieldsets, pagination (cursor over offset), compress responses, omit nulls/defaults
- Limit and cap page sizes server-side
- Avoid chatty APIs: batch endpoints, GraphQL/`include` parameters, bulk operations
- Avoid N+1 at the API layer (the DataLoader pattern for batching and per-request caching)
- Do slow work asynchronously: accept the request, enqueue a job (your Kyu), return 202 with a status URL; respond fast, process later
- Parallelize independent downstream calls with `errgroup` (and bound them)
- Timeouts, retries with exponential backoff and jitter, circuit breakers, bulkheads; budgeted deadlines propagated via `context`
- Hedged requests for tail latency on idempotent reads (send a second request after p95 delay)
- Rate limiting and load shedding (your Limitz) to protect the system under overload: reject early with 429/503 instead of queueing until everything is slow
- Backpressure: bounded queues and concurrency limits per endpoint
- Idempotency keys so retries are safe
- Connection reuse: HTTP/2 or keep-alive; avoid per-request TLS handshakes
- Move auth cost off the hot path: cache verified JWT claims for their lifetime, validate signature cheaply (HMAC/Ed25519 are fast; RSA verify is cheaper than RSA sign), avoid bcrypt on every request (verify once per session), and tune bcrypt/argon2 cost to target a deliberate latency
- Middleware order: cheap rejections first (rate limit, auth check, size limit) before expensive work
- Avoid per-request allocation in middleware chains; avoid `context.WithValue` chains that grow deep
- Router choice matters at the margin: radix-tree routers (`httprouter`, `chi`, `gin`, Go 1.22+ `ServeMux`) over linear regex routers
- Logging: structured, leveled, asynchronous/batched, sampled on hot paths; `log/slog` with a cheap handler; avoid logging in tight loops
- Metrics: use cheap counters/histograms (pre-created label sets, no high-cardinality labels, no per-request label formatting)
- Tracing: sample (head or tail based), not 100 percent in production
- Static assets: CDN, long cache lifetimes with content-hashed filenames, precompressed
- Serve large downloads with range requests and zero-copy file serving
- Pagination plus a precomputed "next cursor" instead of counting totals on every request
- Edge caching / reverse proxy (nginx, Caddy, Varnish, Cloudflare) for cacheable GETs; micro-caching (1 to 5 s) of hot endpoints
- Warm caches and connection pools at startup; avoid cold-start spikes (pre-open DB conns, preload hot keys, `GOMAXPROCS` correct from start)
- Graceful shutdown and readiness checks so deploys do not cause latency spikes

## Architecture-level

- Remove work: the fastest request is the one you do not make (cache, dedupe, drop)
- Move work off the request path (queues, workers, scheduled precomputation, materialized views)
- Move computation closer to data (do the aggregation in SQL, not in app loops over fetched rows)
- Move data closer to users (CDN, regional replicas)
- Scale up before out (bigger box, more cores, faster disk) when simpler; scale out stateless services behind a load balancer
- Separate read and write paths (CQRS) when read and write profiles differ greatly
- Event-driven change propagation (CDC, outbox) instead of polling
- Batching and coalescing writes (group commit, write-behind buffers)
- Choose the right store for the access pattern (KV, relational, columnar for analytics, search engine for text, time-series DB for metrics)
- Autoscale on the right signal (queue depth, p95 latency), not just CPU
- Capacity plan from measured knees (use the barrage capacity sweep), keep headroom, re-measure after each change

## Common anti-patterns to flag and fix

- Creating a new `http.Client`, DB connection, Redis client, or regexp per request
- Not closing or draining response bodies
- Unbounded goroutines, channels, caches, or queues
- `SELECT *`, `OFFSET` pagination on large tables, missing index on a foreign key
- N+1 queries
- Holding locks while doing IO
- Logging or metrics with heavy formatting on the hot path
- JSON via `map[string]any`
- `fmt.Sprintf` for hot-path string building
- Premature micro-optimization with no profile
- Benchmarks that the compiler optimizes away (assign results to a package-level sink variable)
- Benchmarks run once with no `-count` and no benchstat (noise mistaken for signal)
- Optimizing on a laptop with other load, thermal throttling, or a different CPU than production
- Load-testing from the same box as the target without saying so (see barrage same-machine caveat)
- Comparing runs with different configs, data sizes, or warm/cold cache states
- Cache with no invalidation story or no TTL
- Retries without backoff or jitter (retry storms)
- Raising `work_mem`/pool sizes/worker counts blindly (memory blowups, connection exhaustion)

## Order of attack (default)

1. Baseline with barrage; identify the culprit layer.
2. Remove obviously wasted work (N+1, `SELECT *`, missing index, no cache, per-request client creation).
3. Fix algorithms and data structures on the profiled hot path.
4. Cut allocations on the profiled hot path.
5. Reduce contention and syscalls.
6. Tune runtime, GC, pools, and database/Redis configuration.
7. Enable PGO.
8. Only then: unsafe, lock-free structures, custom allocators, assembly/SIMD.
9. After each step: tests pass, re-measure with barrage, compare against baseline, log result.

## Reporting format

For every change report:
- What changed (one line)
- Layer and technique
- Before and after numbers (p50/p95/p99, throughput, allocs/op, B/op, whichever applies)
- Barrage compare verdict
- Kept or reverted
- Next candidate from the profile
