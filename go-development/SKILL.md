---
name: "go-development"
description: "Index for all Go development skills. Use when doing any Go work."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
## When to Use
Use for any Go task; load the referenced skills below as needed.

## Procedure
1. This is a router, not a bundle: load ONLY the sub-skill(s) the current task actually needs, never all of them.
2. coding-style: simple boring idiomatic Go, stdlib-first, behavior comments, TDD table-driven tests, vet/fmt/lint.
3. go-quirks-and-safety: nil maps/slices/pointers, nil-interface trap, bounds, slice aliasing, goroutine and resource leaks.
4. api-library-design: public API naming, options with defaults, small surface, semver, examples.
5. architecture-planning: boring-first, failure modes, one recommendation.
6. debugging: reproduce, error, logs, isolate, fix cause, always report.
7. git-workflow: conventional atomic commits, gh CLI, CI gate then tag release.
8. azure-deployment: status-first, az direct, systemd/Caddy/Postgres, deploy after CI.
9. readme-writing: title, what, why, alternatives, features, explained example, gotchas.
## Pitfalls
- Skipping the relevant skill for the task at hand.

## Verification
1. Correct sub-skill consulted before writing, reviewing, or shipping Go code.