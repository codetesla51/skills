---
name: "api-library-design"
description: "How to design public APIs for Go libraries. Friendly, consistent, discoverable."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# API & Library Design

## Core principle: friendly, consistent, discoverable

A public API should be usable by someone reading only the function signatures and a few examples — without needing to read the implementation. Consistency across the whole library matters more than any single function being clever.

## Naming conventions

- Be consistent across the entire package: if one constructor is `New(...)`, don't have another be `Create(...)` or `NewFoo(...)` unless there's a real reason for the difference (e.g., multiple constructors for different configurations — `NewWithConfig`, `NewFromFile`).
- Match Go stdlib naming instincts: `New` for constructors, `Must*` for a variant that panics instead of returning an error (used sparingly, and only when the panic is genuinely appropriate — e.g. package-level setup that can't reasonably continue), `With*` for functional options.
- Avoid stutter: `kyu.Queue`, not `kyu.KyuQueue`. Package name + type name should read naturally together at the call site (`kyu.New()`, not `kyu.NewKyu()`).
- Prefer verbs for functions/methods and nouns for types — `queue.Enqueue(job)`, not `queue.Job(job)`.
- Name things for what they do, not how they're implemented. `RateLimiter.Allow()` not `RateLimiter.CheckTokenBucket()` — the token bucket is an implementation detail, not part of the contract.

## Exposing configuration

- Default to the **functional options pattern** for anything with more than 2-3 optional configuration values — it keeps the zero-config case simple (`kyu.New()` just works) while letting advanced users opt into more control (`kyu.New(kyu.WithRetries(3), kyu.WithBackoff(...))`).
- Every option should have a sane default that works for the common case without the caller needing to know it exists. A library that requires reading the docs before it does anything useful has failed the "friendly" bar.
- Don't expose internal configuration that callers can't meaningfully act on — if a config value only matters for your own testing/debugging, keep it unexported.
- Struct-based config (a `Config` struct passed to `New`) is a reasonable alternative to functional options when the config is fixed and unlikely to grow — pick whichever fits the library's actual shape, but be consistent within one library.

## What belongs in the public API vs internal

- Export only what callers actually need to call or implement against. If a type exists purely to support another type's internals, keep it unexported.
- Interfaces should be defined at the point of use (by the consumer), not preemptively exported by the producer, unless the library's whole point is letting callers plug in their own implementation (e.g., a `Storage` interface in a job queue that callers implement for a custom backend — that's a legitimate export).
- A small, well-considered public surface is easier to keep backwards-compatible than a large one — every exported name is a promise to future callers.

## Versioning and breaking changes

- Follow semantic versioning: breaking changes to the public API require a major version bump, not a patch.
- Before removing or changing an exported name, consider deprecating it first (a comment noting deprecation, still functional) for at least one minor version if the library has real external users (Kyu, given it already has external contributors, should treat this seriously).
- Document breaking changes explicitly in a changelog — don't make external users diff two versions to find out what broke.

## Examples matter as much as the code

- Every public package should have at least one runnable example demonstrating the zero-config happy path, ideally as a Go example function (`func ExampleNew()`) so it's testable and shows up in generated docs.
- If the README doesn't show a working example in the first few lines (per the readme-writing skill), the API design likely has too much required setup before it becomes useful.

## What to avoid

- Don't expose a "kitchen sink" config struct with dozens of fields most callers will never touch — that's the opposite of friendly; use options with sane defaults instead.
- Don't add a public method "in case someone needs it later" — every exported symbol has a maintenance and compatibility cost. Wait until there's an actual caller need.
- Don't break naming consistency for a single function just because a slightly different name feels more precise — the value of consistency across the whole package usually outweighs one function's naming being marginally more accurate.