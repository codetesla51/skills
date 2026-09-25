---
name: "coding-style"
description: "Simple boring Go code, stdlib-first, behavior comments"
version: 3
created: "2026-09-07"
updated: "2026-09-25"
---
# Coding Style

## Core philosophy

Write simple, easy-to-read, self-explanatory code. Do not try to be clever or do too much in one place. If a simpler version of the same code exists, write the simpler version.

This applies especially to Go — Go code should look boring. If a function needs a paragraph to explain what it's doing, it's probably doing too much.

## Language conventions

- Follow idiomatic Go patterns strictly: standard naming (short receiver names, `err` for errors, no stutter like `pkg.PkgThing`), standard project layout, standard formatting (`gofmt`/`goimports`).
- Prefer the standard library first. Do not add a third-party dependency unless explicitly asked to.
- Explicit error returns everywhere — never panic for expected/recoverable failures. `if err != nil { return fmt.Errorf(...) }`, not `panic(err)`.

## Naming conventions

- Package names: short, lowercase, no underscores, no stutter (`http`, not `httpUtils`). The package name is part of the call site (`http.Client`), so don't repeat it in identifiers inside the package.
- Variables: short names for short-lived/small-scope things (`i` in a loop, `r` for a receiver named `Reader`), longer descriptive names as scope grows. A variable used across 30 lines needs a real name; one used across 3 doesn't.
- Functions/methods: verbs or verb phrases (`ParseConfig`, `Close`), exported names start uppercase, unexported lowercase. No `Get` prefix on simple accessors (`user.Name()`, not `user.GetName()`).
- Interfaces: often named by what they do, ending in `-er` for single-method interfaces (`Reader`, `Writer`, `Closer`).
- Constants: no `ALL_CAPS` — Go uses `MixedCaps` even for constants (`MaxRetries`, not `MAX_RETRIES`).
- Booleans: name so the zero value (`false`) is the sensible default, and reads naturally in an `if` (`isValid`, `hasError`, not `notValid`).

## Maps

- Declare with `make` when you know you'll add entries: `m := make(map[string]int)`. A `nil` map can be read (`v := m["x"]` returns the zero value) but writing to a `nil` map panics — always `make` before writing.
- Zero value for a missing key: `count := counts["missing"]` gives `0` for `map[string]int`, not an error. Use the two-value form to tell "missing" apart from "present with zero value": `v, ok := m[key]`.
- Iteration order is randomized by the runtime — never rely on map order. If order matters, collect the keys into a slice and sort them.
- Deleting a key: `delete(m, key)` — no-op if the key isn't there, no error.
- Example:
  ```go
  wordCount := make(map[string]int)
  for _, w := range words {
      wordCount[w]++ // missing key reads as 0, so this works on first sight of w
  }
  if n, ok := wordCount["gopher"]; ok {
      fmt.Println("seen", n, "times")
  }
  ```

## Functions

- One function does one job. If you're reaching for "and" to describe what it does (`validateAndSave`), split it.
- Keep the parameter list short (roughly ≤4). Group related parameters into a struct when it grows past that.
- Return early on error/invalid input instead of nesting the happy path inside an `if`:
  ```go
  func Parse(s string) (int, error) {
      if s == "" {
          return 0, errors.New("empty input")
      }
      // happy path stays unindented
      return strconv.Atoi(s)
  }
  ```
- Named return values only when they clarify meaning for the caller (e.g. `(n int, err error)` in an `io.Reader`-like signature) — not as a substitute for a clear `return` statement.
- A function's name and signature should make a comment describing "what it does" unnecessary; comments are for *why*, not *what* (see Comments below).

## Comments

Comments explain **behavior**, not syntax.

- Bad: `// loop over items` above a `for` loop.
- Good: `// skip entities marked dead so a killed enemy doesn't get drawn twice`

Comment on:
- What the code is expected to do (the intent/contract), especially for non-obvious logic
- Edge cases and why they're handled a certain way
- A short example when it clarifies expected input/output, e.g. `// Interpolate(kfs, 1.5) with keyframes at t=1 and t=2 returns the halfway value`

Do not comment:
- Anything the code already says clearly by being well-named
- Language syntax itself (what a `for` loop or `map` is)

Keep comments minimal and earn their place:
- Before adding or keeping a comment, ask "does this tell the reader something the code doesn't already say?" If no, delete it.
- Never leave a comment that just restates the line below it (`// increment i` above `i++`) — remove it.
- Don't comment every line or every block out of habit. Most well-written code needs zero or very few comments; a comment on nearly every line is a sign the code itself isn't clear enough, and the fix is better naming/structure, not more comments.
- When reviewing or editing existing code, actively remove comments that are redundant, stale, or no longer true — don't just leave them because they were already there.

## Testing (TDD)

Practice test-driven development for core logic: **red, green, refactor**.

1. **Red** — write a test for the behavior you're about to add, before the code exists. Run it, watch it fail (compile error counts as failing). This confirms the test actually tests something.
2. **Green** — write the minimum code to make that test pass. Don't add extra behavior the test doesn't require yet.
3. **Refactor** — clean up the code (and the test, if needed) now that it's covered, without changing behavior. Re-run tests after every refactor step.

Repeat this cycle per behavior/case, not once for the whole feature — e.g. write a test for the empty-input case, make it pass, then write a test for the negative-number case, make it pass, and so on.

- "Core" means logic the rest of the system depends on being correct — an interpolator, a parser, a collision check, a state transition. Glue/wiring code (e.g. a `main` that just calls other already-tested functions, a handler that only deserializes and delegates) is not core.
- Test **behavior**, not implementation. Test what the function is trying to become (its intended contract), not its current internal steps — the test shouldn't need to change just because you refactored the internals.
- Do NOT write a test for something that doesn't need one. Skip tests for: trivial glue code, simple getters/setters, thin wrappers with no logic of their own, and anything not explicitly asked for. Writing a test "for coverage" with no real chance of catching a bug is wasted effort — don't do it.
- Use table-driven tests always — a slice of `{name, input, want}` cases run through one test body, not repeated near-identical test functions.
- Keep tests simple. A test should be as easy to read as the code it's testing.
- The goal of a test is to find where the function breaks. Deliberately try to break it: boundary values, empty input, zero, negative, past-the-end, malformed input.
- Use fuzz tests (Go's built-in `testing.F` / `go test -fuzz`) where useful, especially for functions that parse or transform input, to surface edge cases you didn't think to write by hand.

## Code quality checks

The agent should always run these before considering a change done:

- `go vet ./...`
- `go fmt ./...` (or `gofmt -l .` to check, `-w` to fix)
- A linter (e.g. `golangci-lint run`) if one is configured in the project

Prefer wiring these into the project's `Makefile` as a `check` (or `lint`) target so they run the same way every time, rather than the agent running ad hoc commands from memory:

```makefile
.PHONY: check
check:
    go vet ./...
    gofmt -l .
    golangci-lint run
```

If a project has no `Makefile` yet, ask whether to add one rather than running the checks individually every time. If a `Makefile` already exists, add to it rather than replacing it.
