---
name: "readme-writing"
description: "How to write a project README. Professional, simple, no emojis."
version: 4
created: "2026-09-07"
updated: "2026-09-25"
---
# README Writing

## Structure, in order

1. **Title and one-line description** — what the project is, immediately, in plain terms.
2. **What it does** — a short paragraph, not a feature dump yet. The reader should understand the project's purpose before seeing any code.
3. **Why it exists** — what problem it solves, and why it was worth building rather than using something that already exists.
4. **Why not use the alternatives** — name the existing options in this space and say honestly what this project does differently or better for its specific niche. Don't oversell; if an alternative is genuinely better for some use cases, say so.
5. **Features** — a real list, kept to what's actually built and working, not aspirational. Simple bullet points, not over-explained.
6. **Installation — never skipped.** The exact command to get it (`go get github.com/...`, `npm install ...`), plus any real prerequisite (Go version, etc.) if it's not obvious. This section is mandatory in every README regardless of project size or how "obvious" installing it seems — a reader who can't figure out how to get the thing running never gets to anything else in the document. Verify the actual module path/command against the real repo — don't write it from memory or guess it from the project name.
7. **Quick start / usage example — never skipped.** A minimal, runnable example as early as possible, right after installation. The point of this section is to get the reader from installed to running something in the fewest steps possible — don't let "how it works" or deeper explanation come before this. Every code example gets a short explanation of what it does and why, not just the code with no context. Verify it against the current code (read the real function signatures, or actually run it) before including it — an example that doesn't compile against the actual API is worse than no example.
8. **How it works** — after the reader has something running, explain the mechanism: what happens internally, in plain terms first, then the actual approach (algorithm, architecture, key design choice) and why it's built that way. Use the explainer skill's high-level-then-why structure. This is about the actual implementation, not a restatement of the features list.
9. **Arguments / options / configuration, if applicable** — for a CLI tool, library with configurable options, or anything with flags/parameters: list each one, what it does, its default, and one concrete example showing it in use. Don't just list flag names with no explanation — a flag without an example is often unclear what it actually changes.
10. **Benchmarks, if any exist** — if the project has real benchmark numbers (from an actual `go test -bench` run or similar, not estimated), include them plainly: what was measured, the numbers, and the environment they were run on (hardware, if it matters to the numbers). Never fabricate or round up numbers to look better, and never include a benchmarks section at all if none have actually been run — an absent section is honest, a padded or invented one isn't.
11. **Things to watch out for** — gotchas, footguns, known limitations. These should be obvious and easy to find, not buried in prose — call them out explicitly (a "Note" or "Warning" callout, or a dedicated short section), the same way the logos2d README already does with its `> Note` / `> Warning` callouts.
12. **License / credits**, if applicable.

This mirrors the structure logos2d's own README already uses well — treat that README as the reference example when in doubt about tone or level of detail. Installation and quick start are the two sections that must never be cut for length or buried lower in the document — everything else (how it works, benchmarks, arguments) comes after the reader can already run something.

## Style rules

- No emojis, anywhere.
- Badges (build status, version, license, go report card) are fine here, unlike on a landing page — but keep it to a small, meaningful set, not a decorative row of ten.
- Minimal em dashes — prefer a period, comma, or restructured sentence over reaching for an em dash.
- Simple, not over-complex. If a sentence needs a subordinate clause and a semicolon to make its point, it's usually two sentences instead.
- Professional tone throughout — not stiff or corporate, but not casual/jokey either.
- Not too long. A README's job is to get someone from "what is this" to "I'm running it" as fast as possible — extra prose that doesn't serve that goal gets cut.
- Code examples are always explained, at least briefly, immediately before or after the block — never just dropped in with no framing.
- Gotchas/watch-outs must be visually distinct from regular prose (callout blocks, a dedicated "Limitations" or "Notes" section) so they can't be missed by skimming.

## What to avoid

- Don't write a wall of prose before the reader sees what the project actually does — get to the point in the first couple of sentences.
- Don't list aspirational or planned features alongside built ones without clearly marking which is which.
- Don't skip the "why not use X" comparison — a README that never acknowledges existing alternatives reads as either unaware of them or avoiding the honest comparison.
- Don't let the README grow past what's needed to get someone running the project and understanding its scope — split deeper docs into a `docs/` folder or wiki rather than growing the README indefinitely.
- Don't write installation commands or usage examples from memory/assumption — check the real module path and current function signatures first, the same way the code-explainer skill requires actually opening files instead of guessing from names.
- When updating a README for a project whose API just changed, check the whole file for now-stale examples — a README correct in one section and stale in another is worse than an honestly outdated whole one.
- Don't bury installation or the quick start under "how it works," benchmarks, or any other section — a reader must be able to get it running before reading anything else.
- Don't invent or round up benchmark numbers, and don't include a benchmarks section when no real benchmark has actually been run.
- Don't list a flag/argument by name only — every one gets a plain explanation and a concrete example of it in use.
