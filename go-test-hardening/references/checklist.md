# Checklist and Go specifics

## Contents
- Edge cases
- Failure injection
- Concurrency
- Time and randomness
- Postgres testing in Go
- Test smells to remove

## Edge cases
- Numbers: 0, -1, 1, min/max int, overflow, NaN/Inf for floats, rounding.
- Boundaries: one below, exactly at, one above every threshold in the code.
- Strings: empty, whitespace only, very long, unicode, invalid UTF-8, injection-like input.
- Collections: nil vs empty, one element, duplicates, unsorted, very large.
- Pointers/interfaces: nil input.
- Time: zero time, past/future, DST, time zones, leap day.
- IDs and keys: missing, duplicate, wrong type, wrong owner.

## Failure injection
Make dependencies fail and check the function returns a clear error without panic,
partial writes, or leaked resources:
- timeout and context cancellation (`context.WithTimeout`, cancel mid-call)
- connection refused, connection dropped mid-query
- constraint violation (unique, foreign key, not null)
- partial response, malformed response
- retries: does a retry cause a double effect (double charge, duplicate row)?

## Concurrency
- Run with `go test -race`.
- Call the function from many goroutines with shared state and check invariants.
- Test cancellation and shutdown: no goroutine leaks (check with `goleak` if available).
- Avoid `time.Sleep` in tests; use channels, sync primitives, or `Eventually` helpers.

## Time and randomness
Inject a clock and a random source instead of calling `time.Now()` or `rand` inside
logic. Tests must not depend on the wall clock or on execution order.

## Postgres testing in Go
- Prefer a real Postgres: testcontainers-go, or one migrated template database and
  `CREATE DATABASE test_x TEMPLATE base` per test.
- Isolate: run each test in a transaction and roll back, or use a fresh database.
- Test the things only a real database shows: constraints, unique violations,
  transaction isolation, deadlocks, NULL handling, ordering without ORDER BY, and
  migrations (apply N, seed data, apply N+1, check the data survived).
- Assert on query results with known seed data. For slow queries, assert on the
  plan (index used, no sequential scan) instead of wall-clock time, which is flaky.
- For logic that lives inside the database (functions, triggers, RLS), pgTAP is an
  option.
- For CDC or logical replication code, configure the container with
  `wal_level=logical`, run statements, and assert on the events received.

## Test smells to remove
- No assertion, or only `err == nil`.
- Expected value computed with the same code path as the implementation.
- Mock returns X, test asserts X.
- One giant test covering many behaviors.
- Test name says nothing about the behavior.
- Tests that depend on order or shared global state.
- `t.Skip` or commented-out tests with no explanation.
- Only the happy path.
