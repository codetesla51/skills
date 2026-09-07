---
name: "coding-style"
description: "Simple boring Go code, stdlib-first, behavior comments"
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Coding Style

## Core philosophy

Write simple, easy-to-read, self-explanatory code. Do not try to be clever or do too much in one place. If a simpler version of the same code exists, write the simpler version.

This applies especially to Go — Go code should look boring. If a function needs a paragraph to explain what it's doing, it's probably doing too much.

## Language conventions

- Follow idiomatic Go patterns strictly: standard naming (short receiver names, `err` for errors, no stutter like `pkg.PkgThing`), standard project layout, standard formatting (`gofmt`/`goimports`).
- Prefer the standard library first. Do not add a third-party dependency unless explicitly asked to.
- Explicit error returns everywhere — never panic for expected/recoverable failures. `if err != nil { return fmt.Errorf(...) }`, not `panic(err)`.

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

## Testing

- For core functions: write the test first, then the function (test-driven). "Core" means logic the rest of the system depends on being correct — an interpolator, a parser, a collision check — not glue/wiring code.
- Test **behavior**, not implementation. Test what the function is trying to become (its intended contract), not its current internal steps.
- Don't test redundantly. Only write tests for what actually needs testing, or what's explicitly asked for. Skip tests for trivial glue code, simple getters, or thin wrappers.
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