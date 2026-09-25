---
name: "go-preship-check"
description: "Run this before shipping, merging, or tagging a release on any Go codebase. Catches the bug classes that compile clean, pass tests, and still break in production — goroutine leaks, panics that skip deferred cleanup, non-atomic shared state, swallowed errors, unpropagated context, uninitialized maps, unclosed resources, and other correctness issues Go's compiler and go vet don't catch. Use whenever the user asks to review code before shipping, check for bugs, do a pre-release audit, review a PR, or asks "is this safe to ship" — even if they don't name a specific bug class. Also use proactively after writing any new goroutine, defer block, global variable, or long-lived worker/pool code."
version: 1
created: "2026-09-25"
updated: "2026-09-25"
---

# Go Pre-Ship Check

A systematic pass over a Go codebase for bug classes that are easy to write, hard to notice in review, and don't show up until production load. Every item below `go vet` and the standard linters miss, or only partially catch.

## How to run this

1. Identify the surface: which files/packages changed, or which package the user pointed at. Don't try to check an entire large codebase in one pass if a diff or specific package is available — scope to what's relevant.
2. Run the automated tools first (section below) — they're cheap and catch a chunk of this for free.
3. Walk each checklist section against the code, in order. Each item lists what to grep for, what it looks like when broken, and the fix.
4. Report findings grouped by severity, not by category: **will break in production** first, **will leak resources over time** second, **latent/edge-case** third. Don't just dump every category's findings in file order — the reader needs to know what to fix first.
5. For each finding: cite the exact line, explain the failure scenario in one sentence (not just "this is a leak"), and show the fix. Don't just flag — fix or propose the fix inline.

## Automated tools to run first

These catch a meaningful chunk of this checklist without manual review. Run them and fold results into the report before doing the manual pass.

```bash
go vet ./...                          # catches a baseline of suspicious constructs
go build -gcflags="-m" ./... 2>&1 | grep "escapes"   # escape analysis, not usually needed but useful for hot paths
staticcheck ./...                     # if available — catches many of the below automatically
go test -race ./...                   # THE single most important one for concurrency bugs — run this, not just go test
golangci-lint run                     # if configured — bundles staticcheck, govet, errcheck, unused, etc.
```

If `go test -race` isn't already part of the project's CI, flag that as a finding on its own — it's the highest-leverage single addition for catching concurrency bugs before they ship, and most of section 1 below is what it exists to catch.

If `errcheck` (via golangci-lint or standalone) isn't configured, flag that too — it directly automates section 2's "unhandled errors" check.

---

## 1. Concurrency

### Goroutine leaks
**Grep for:** `go func` and trace whether each one has a guaranteed exit path.
**Broken pattern:** a goroutine blocked forever on an unbuffered channel send/receive with no corresponding reader/writer, or no `context.Context` wired in to let it be cancelled.
```go
// leak: if nobody ever reads from ch, this goroutine lives forever
go func() {
    ch <- computeResult()
}()
```
**Fix:** every long-lived or blocking goroutine needs either a `context.Context` it selects on, a buffered channel sized to avoid blocking, or a documented reason it's expected to run for the process lifetime.

### Goroutines with no way to stop them
**Grep for:** `for {` inside a `go func` block, or infinite loops spawned as goroutines.
**Broken pattern:** a worker loop started once at init with no cancellation mechanism — fine until the caller needs to shut down cleanly (tests, graceful shutdown, hot-reload) and the process hangs or leaks per-test-run.
**Fix:** loop should `select` on a `ctx.Done()` or stop channel, not just `for { ... }`.

### Data races on shared state
**Grep for:** package-level `var` declarations that aren't `sync.Once`, channels, or explicitly documented as read-only after init; struct fields written from more than one goroutine.
**Broken pattern:**
```go
var requestCount int  // written from multiple goroutines, no atomic, no mutex

func handler() {
    requestCount++  // read-modify-write race
}
```
**Fix:** `atomic.Int64` (Go 1.19+) for simple counters, `sync.Mutex`/`sync.RWMutex` for compound state, or `sync.Map` for concurrent map access. `go test -race` will catch most of these if the racing code paths are actually exercised by a test — note where test coverage doesn't reach a suspected race.

### Concurrent map access
**Grep for:** any `map[...]...` that's both read and written from goroutines started with `go`.
**Broken pattern:** plain `map` shared across goroutines — this doesn't just race, it panics at runtime (`fatal error: concurrent map read and map write`), and it's nondeterministic so it often passes CI and breaks in production under real concurrency.
**Fix:** `sync.Map` for high-read/low-write patterns, or a plain map behind a `sync.RWMutex` when you need atomicity across multiple map operations (`sync.Map` doesn't give you compound atomicity).

### Lock ordering / deadlocks
**Grep for:** any function that acquires more than one mutex.
**Broken pattern:** goroutine A locks `mu1` then `mu2`; goroutine B locks `mu2` then `mu1` — classic deadlock, timing-dependent so it may not show up until specific interleavings occur in production.
**Fix:** enforce a single global lock ordering convention (e.g. always lock in field-declaration order), or restructure to avoid holding two locks at once.

### WaitGroup misuse
**Grep for:** `wg.Add(` calls — check whether they're inside or outside the goroutine they correspond to.
**Broken pattern:**
```go
for _, item := range items {
    go func() {
        wg.Add(1)      // WRONG: race between Add and the Wait() below
        defer wg.Done()
        process(item)
    }()
}
wg.Wait()
```
**Fix:** `wg.Add(1)` must happen in the parent goroutine, before `go func()` is called — not inside the spawned goroutine.

### Fan-out goroutines without errgroup
**Grep for:** multiple `go func()` calls spawned in a loop or in sequence, each doing work that can fail, coordinated with a raw `sync.WaitGroup` and a manually shared error variable (or no error handling at all).
**Broken pattern:**
```go
var wg sync.WaitGroup
var firstErr error
for _, item := range items {
    wg.Add(1)
    go func(it Item) {
        defer wg.Done()
        if err := process(it); err != nil {
            firstErr = err   // race: unsynchronized write from multiple goroutines
        }
    }(item)
}
wg.Wait()
```
This has two bugs at once: a data race on `firstErr`, and no cancellation — the other goroutines keep running (and can panic the process, or waste work) after the first one fails.
**Fix:** use `golang.org/x/sync/errgroup` any time more than one goroutine is spawned to do work that can return an error. It replaces the WaitGroup, gives you a properly synchronized first-error, and — using `errgroup.WithContext` — cancels the shared context the moment any goroutine returns an error, so sibling goroutines can observe `ctx.Err()` and stop early instead of continuing to do wasted or dangerous work.
```go
g, ctx := errgroup.WithContext(parentCtx)
for _, item := range items {
    item := item
    g.Go(func() error {
        return process(ctx, item)   // process should select on ctx.Done()
    })
}
if err := g.Wait(); err != nil {
    return err   // first error across all goroutines, race-free
}
```
Flag this specifically wherever the checklist finds the "WaitGroup misuse" or "unhandled errors in goroutines" patterns above and more than one goroutine is involved — those are usually the same underlying bug that errgroup solves outright, not two separate things to fix by hand.
**Caveat:** don't reach for errgroup when goroutines don't need to report an error back (pure fire-and-forget work) or when they need individually distinguishable errors rather than "first error wins" — plain `sync.WaitGroup` plus a `[]error` collected under a mutex is more appropriate there.

### Timers and tickers not stopped
**Grep for:** `time.NewTicker(`, `time.NewTimer(` — check for a matching `.Stop()`.
**Broken pattern:** a ticker created in a function that returns without stopping it — the underlying goroutine and channel resources leak for the ticker's lifetime, which in a hot path (created per-request rather than once) adds up fast.
**Fix:** `defer ticker.Stop()` immediately after creation, or store it on a long-lived struct with an explicit `Close()`/`Shutdown()` that stops it.

---

## 2. Error handling and panics

### Unhandled / discarded errors
**Grep for:** function calls that return `error` where the return value isn't checked — especially `_ = someFunc()` or a bare call with no assignment at all.
**Broken pattern:**
```go
json.Unmarshal(data, &result)   // error silently dropped
```
**Fix:** check every error. If genuinely safe to ignore (rare), use `_ = x` explicitly with a comment explaining why, so it reads as an intentional decision, not an oversight. `errcheck` linter automates finding these.

### Errors swallowed in defer
**Grep for:** `defer conn.Close()`, `defer file.Close()`, `defer rows.Close()` and similar — these discard the returned error by default.
**Broken pattern:** on a **write path**, a failed `Close()` can mean data wasn't actually flushed/persisted, and silently dropping that error hides real data loss.
**Fix:** for read-only resources, discarding is usually fine (document it). For anything where `Close()` can fail meaningfully (files being written, buffered writers), capture it:
```go
defer func() {
    if cerr := f.Close(); cerr != nil && err == nil {
        err = cerr
    }
}()
```

### Panic recovery before deferred cleanup runs
**Grep for:** `recover()` calls — trace exactly what's deferred *above* the recover in call order, since defers run LIFO.
**Broken pattern:** a panic recovered high up the call stack skips execution of the panicking function's own body, but deferred calls **do** still run, in reverse order of registration — the bug is usually the opposite of what people expect: people assume recovery skips cleanup, when the real risk is a resource acquired *after* a deferred cleanup was registered elsewhere, or a recover placed in a spot that doesn't cover the goroutine where the panic actually happens.
**Fix:** verify defers are registered *immediately* after the resource is acquired (not batched at the top of a long function), and that every goroutine that can panic has its own `recover()` — a `recover()` in the parent does not catch a panic in a spawned goroutine, that panic crashes the whole process regardless of the parent's recover.
```go
go func() {
    defer func() {
        if r := recover(); r != nil {
            log.Printf("panic in worker: %v", r)
        }
    }()
    doWork()
}()
```

### Error wrapping losing context
**Grep for:** `return err` immediately after a call, with no wrapping.
**Broken pattern:** a low-level error ("connection refused") bubbles up through five layers of calls with zero added context, so a production log shows the symptom with no indication of which of the twelve calls to that function failed.
**Fix:** `return fmt.Errorf("doing X for user %d: %w", userID, err)` — wrap with `%w` (not `%v`, which breaks `errors.Is`/`errors.As`) and add the specific operation/identifiers relevant at that layer.

### Sentinel error comparison with `==` instead of `errors.Is`
**Grep for:** `err == someSentinelError` or `err == sql.ErrNoRows` style comparisons.
**Broken pattern:** once any layer wraps the error with `%w`, a direct `==` comparison silently stops matching, and the specific-error-handling branch stops firing — often not caught by tests that don't exercise the wrapped path.
**Fix:** always `errors.Is(err, target)` / `errors.As(err, &target)` instead of direct comparison.

---

## 3. Context usage

### Context not propagated
**Grep for:** functions that accept a `context.Context` param but don't pass it into the calls they make (DB queries, HTTP requests, downstream function calls) — look for `db.Query(` instead of `db.QueryContext(ctx, `, or `http.Get(` instead of a request built `WithContext(ctx)`.
**Broken pattern:** caller sets a 5s timeout via context, but the function ignores it and calls the non-context variant — the timeout silently does nothing, and a slow downstream call blocks far longer than the caller expects.
**Fix:** thread `ctx` through every call in the chain that has a context-aware variant. If a library doesn't support context, note it explicitly as a known gap.

### `context.WithCancel`/`WithTimeout` without a `cancel()` call
**Grep for:** `context.WithCancel(`, `context.WithTimeout(`, `context.WithDeadline(` — every one of these returns a `cancel` function that must be called.
**Broken pattern:**
```go
ctx, cancel := context.WithTimeout(parent, 5*time.Second)
// cancel never called — leaks until the 5s timeout fires on its own,
// and if this runs in a hot path, leaks pile up between timeouts
doWork(ctx)
```
**Fix:** `defer cancel()` immediately after creation, every time, even if the context is expected to time out naturally — the leak exists in the gap between creation and the timeout firing.

### `context.Background()` used where a real context should flow
**Grep for:** `context.Background()` or `context.TODO()` used inside a function that's called from a request-handling path (not at the true top-level entry point).
**Broken pattern:** a function three layers deep calls `context.Background()` instead of accepting and using the caller's context — this silently breaks cancellation propagation and timeout enforcement for that entire subtree, and it's easy to miss because the code still compiles and works under normal conditions.
**Fix:** `context.Background()` should only appear at genuine top-level entry points (`main`, top of an HTTP handler, a cron job's start) — everywhere else, the context should be a parameter.

### Values stuffed into context inappropriately
**Grep for:** `context.WithValue(` — check what's being stored.
**Broken pattern:** using context values for things that should be explicit function parameters (config, required dependencies) rather than genuinely request-scoped metadata (trace IDs, auth principal) — makes the dependency invisible in the function signature and untyped at the call site.
**Fix:** reserve `context.WithValue` for cross-cutting request-scoped data only; pass everything else explicitly.

---

## 4. Initialization

### Uninitialized (nil) maps written to
**Grep for:** struct fields or vars of map type, check whether they're initialized with `make(map[...]...)` or a literal before any write.
**Broken pattern:**
```go
type Config struct {
    Overrides map[string]string  // nil by default
}
c := Config{}
c.Overrides["key"] = "value"   // panic: assignment to entry in nil map
```
**Fix:** initialize in the constructor (`Overrides: make(map[string]string)`), or lazily initialize on first write with a nil check. Note: reading from a nil map is safe in Go (returns zero value) — only writing panics, so this specifically matters on write paths.

### Nil pointer dereference on optional struct fields
**Grep for:** struct fields that are pointer types (`*SomeType`) and accessed without a nil check, especially ones populated conditionally (from optional JSON fields, optional config).
**Broken pattern:** a field is `*string` because it's optional in the source data, and downstream code does `*cfg.Timeout` without checking `cfg.Timeout != nil` first.
**Fix:** nil-check before dereferencing, or use a non-pointer with a documented zero-value meaning "unset" if `nil` vs zero-value distinction genuinely isn't needed.

### Init order dependencies across files/packages
**Grep for:** package-level `var x = someFunc()` where `someFunc` depends on another package-level var being initialized first.
**Broken pattern:** Go initializes package-level vars in dependency order *within* a file, but the order across multiple files in the same package is determined by filename order — relying on this is fragile and a rename can silently break init order.
**Fix:** avoid inter-dependent package-level var initialization; use an explicit `init()` function or a constructor pattern where order is guaranteed by call sequence, not file order.

---

## 5. Resource management

### Unclosed DB rows
**Grep for:** `.Query(` or `.QueryContext(` calls — check for a corresponding `rows.Close()`.
**Broken pattern:** `rows, _ := db.Query(...)` with no `defer rows.Close()` — under load, this exhausts the connection pool since connections aren't returned until rows are closed (even if the result set was fully read, in most driver implementations `Close()` must still be called).
**Fix:** `defer rows.Close()` immediately after the nil-error check, always — even in the early-return error paths.

### Unclosed HTTP response bodies
**Grep for:** `http.Get(`, `http.Post(`, `client.Do(` — check for `resp.Body.Close()`.
**Broken pattern:** response body not closed leaks the underlying connection, and with `Keep-Alive` the connection can't be reused for the next request either — under sustained load this exhausts available connections/file descriptors.
**Fix:** `defer resp.Body.Close()` right after the nil-error check, before doing anything with `resp.Body`.

### File descriptor leaks
**Grep for:** `os.Open(`, `os.Create(` — check for `defer f.Close()`.
**Broken pattern:** same shape as DB/HTTP leaks — fine in a short-lived CLI tool, fatal in a long-running server that opens files per-request.
**Fix:** same pattern, `defer f.Close()` immediately after the open succeeds.

### Connection pool sizing not matching actual concurrency
**Grep for:** `SetMaxOpenConns`, `SetMaxIdleConns`, worker pool sizes — check these are actually set, not left at driver defaults, and that they match the real concurrency the app will see.
**Broken pattern:** default `SetMaxOpenConns` (0 = unlimited in `database/sql`) under real load opens far more connections than the database's `max_connections` allows, and the errors that result look like the *database's* problem, not a client-side config gap.
**Fix:** explicitly set pool sizes based on expected concurrency and the target's actual connection limits — don't rely on driver defaults for anything shipping to production.

---

## 6. Testing and CI gaps

### `-race` not run in CI
Already covered above, repeating because it's the single highest-leverage item: if `go test ./...` runs in CI but `go test -race ./...` doesn't, most of section 1 goes uncaught until production.

### Parallel tests sharing mutable state
**Grep for:** `t.Parallel()` calls, check whether the test touches package-level vars, shared fixtures, or global state also touched by other parallel tests.
**Broken pattern:** two `t.Parallel()` tests both mutate the same package-level var — passes most of the time, flakes under specific scheduling, and the failure is usually blamed on "flaky CI" rather than the actual bug.
**Fix:** each parallel test should own its own state; shared fixtures need to be read-only or properly isolated per test.

### `go vet` / linters configured but not gating
**Grep for:** CI config — confirm `go vet`, `staticcheck`/`golangci-lint` actually fail the build on error, rather than running and being ignored.
**Fix:** these tools are only useful if a failure blocks merge — verify the CI step's exit code is checked, not just that the command runs.

---

## Report format

When reporting findings, use this shape so the person can act on it fast:

```
## Will break in production
- [file:line] <one-line failure scenario> → <fix>

## Will leak resources over time
- [file:line] <one-line failure scenario> → <fix>

## Latent / edge-case
- [file:line] <one-line failure scenario> → <fix>

## Tooling gaps
- <e.g. "go test -race not in CI">
```

Don't report a clean bill of health without actually running `go test -race ./...` and `go vet ./...` first — a manual read-through alone will miss races that only the race detector catches deterministically.
