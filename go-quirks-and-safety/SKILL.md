---
name: "go-quirks-and-safety"
description: "Defensive Go checklist covering nil map/slice/pointer panics, the nil-interface trap, out-of-bounds and slice-aliasing bugs, goroutine leaks, and resource leaks (unclosed files/connections, defer-in-loop). Use whenever writing or reviewing Go code, especially anything touching maps, slices, pointers, goroutines, channels, or opened resources (files, HTTP bodies, DB connections)."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Go Quirks & Safety

What the agent should check for on every Go change, and how to fix each one. This is a defensive checklist — the goal is catching latent panics and leaks before they ship, not after.

## Nil checks

**Nil maps**

| Operation | Result |
|---|---|
| Read from nil map | Returns the zero value — safe |
| Write to nil map | **Panics** |
| `len()` / range over nil map | Returns 0 / zero iterations — safe |

```go
// Bad — panics on the write
var m map[string]int
m["key"] = 1

// Good — initialize before writing
m := make(map[string]int)
m["key"] = 1
```
If a map is a struct field that might not be initialized by every constructor path, either initialize it in every constructor or lazy-init it on first write inside a method — pick one pattern and be consistent within a file.

**Nil slices**

| Operation | Result |
|---|---|
| Index into nil slice | **Panics** |
| Append to nil slice | Works fine — allocates as needed |
| `len()` / range over nil slice | Returns 0 / zero iterations — safe |

```go
// Bad — panics
var s []int
s[0] = 1

// Fine — nil slices are safe to append to
var s []int
s = append(s, 1)
```
A nil slice and an empty slice (`[]int{}` or `make([]int, 0)`) behave the same for append/range/len — don't add nil checks before appending, they're unnecessary.

**Nil pointers**

Dereferencing a nil pointer, or calling a method with a pointer receiver on a nil pointer, panics unless the method itself is written to handle a nil receiver.

```go
// Bad — panics if c is nil
c.Value++

// Good — check first when nil is a valid, expected state
if c != nil {
    c.Value++
}
```

**The nil interface trap** — this one is subtle and worth being careful with. An interface value is nil only when *both* its type and value are nil. Returning a typed nil pointer through an interface-typed return makes the interface non-nil, even though the pointer itself is nil.

```go
// Bad — returns a non-nil interface even when h is a nil pointer
func getHandler() http.Handler {
    var h *MyHandler
    if !enabled {
        return h // interface{type: *MyHandler, value: nil} != nil
    }
    return h
}

// Good — return nil explicitly for the "no handler" case
func getHandler() http.Handler {
    if !enabled {
        return nil
    }
    return &MyHandler{}
}
```
Watch for this specifically when a function returns an interface type (like `error` or `http.Handler`) and the concrete value came from a variable that might be a nil pointer.

## Out-of-bounds slices

Indexing past a slice's length, or past its capacity when re-slicing, panics.

```go
// Bad — panics if s has fewer than 3 elements
x := s[2]

// Good — check length first
if len(s) > 2 {
    x := s[2]
}
```

**Re-slicing aliasing** — a slice expression like `s[1:3]` shares the same underlying array as `s`. Mutating the result mutates the original, which can silently corrupt data the caller didn't expect to change.

```go
// Bad — mutates original's underlying array unexpectedly
sub := original[1:3]
sub[0] = 99 // original[1] is now 99 too

// Good — copy if the caller shouldn't see the mutation
sub := make([]int, 2)
copy(sub, original[1:3])
sub[0] = 99 // original is untouched
```
Same caution applies to `append` on a re-sliced value — it can silently overwrite the original array's later elements if capacity allows it. When in doubt about whether a slice is shared, copy defensively rather than assume.

## Goroutine leaks

A goroutine leak is a goroutine that starts but never terminates — it stays alive for the life of the process, silently consuming memory, until something crashes.

**Common cause: receiving from a channel nobody sends to, or sends to a channel nobody reads from**

```go
// Bad — this goroutine blocks forever if someChan never receives a value
func processRequests() {
    go func() {
        data := <-someChan
        process(data)
    }()
}

// Good — give it a way out via context cancellation
func processRequests(ctx context.Context) {
    go func() {
        select {
        case data := <-someChan:
            process(data)
        case <-ctx.Done():
            return
        }
    }()
}
```

**Loop variable capture** — in Go versions before 1.22, a closure over a loop variable in `go func(){}()` captures the same variable across all iterations, not a per-iteration copy.

```go
// Bad (pre-1.22) — all goroutines may print the same, final value of s
for _, s := range servers {
    go func() {
        fmt.Println(s)
    }()
}

// Good — pass it as a parameter so each goroutine gets its own copy
for _, s := range servers {
    go func(s *Server) {
        fmt.Println(s)
    }(s)
}
```
Check the Go version in `go.mod` before assuming this is fixed — 1.22+ changed loop variable semantics, but don't rely on that silently; passing the value explicitly is still clearer and safer either way.

**Closing a channel that other goroutines might still send to** — sending to a closed channel panics. Only the sender side should close a channel, and only once every goroutine that might send has finished.

## Resource leaks

Anything opened must be closed — files, network connections, HTTP response bodies, DB rows/statements, tickers/timers.

```go
// Bad — file handle leaks if an early return happens after Open
f, err := os.Open(path)
if err != nil {
    return err
}
// ... use f, but never closed

// Good — defer immediately after a successful open
f, err := os.Open(path)
if err != nil {
    return err
}
defer f.Close()
```

**Defer in a loop** — deferred calls run at function return, not at the end of each loop iteration. Deferring inside a loop that runs many times accumulates open resources until the whole function returns.

```go
// Bad — all files stay open until the function returns, not per-iteration
for _, path := range paths {
    f, err := os.Open(path)
    if err != nil {
        return err
    }
    defer f.Close()
}

// Good — wrap each iteration's work in its own function so defer fires per-iteration
for _, path := range paths {
    if err := processFile(path); err != nil {
        return err
    }
}

func processFile(path string) error {
    f, err := os.Open(path)
    if err != nil {
        return err
    }
    defer f.Close()
    // ... use f
    return nil
}
```

**HTTP response bodies** — always close `resp.Body`, even on non-2xx responses, or the underlying connection can't be reused/freed.

```go
resp, err := http.Get(url)
if err != nil {
    return err
}
defer resp.Body.Close()
```

## How the agent should apply this

- When writing new Go code, check it against this list before considering it done — same pass as the `go vet`/`go fmt` checks in the coding-style skill.
- When reviewing or editing existing Go code, flag any of these patterns found nearby, even if unrelated to the current task, and mention it rather than fixing it silently — Uthman reviews all diffs and owns architecture decisions, so surface it rather than assume the fix is wanted.
- Don't add defensive nil-checks or bounds-checks everywhere reflexively — only where a nil/empty/out-of-range value is actually a reachable case. Excess defensive checking on values that structurally can't be nil/empty adds noise, which conflicts with the "simple, self-explanatory code" preference.