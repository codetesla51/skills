---
name: "readme-writing"
description: "How to write a project README. Professional, simple, no emojis."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# README Writing

## Structure, in order

1. **Title and one-line description** — what the project is, immediately, in plain terms.
2. **What it does** — a short paragraph, not a feature dump yet. The reader should understand the project's purpose before seeing any code.
3. **Why it exists** — what problem it solves, and why it was worth building rather than using something that already exists.
4. **Why not use the alternatives** — name the existing options in this space and say honestly what this project does differently or better for its specific niche. Don't oversell; if an alternative is genuinely better for some use cases, say so.
5. **Features** — a real list, kept to what's actually built and working, not aspirational. Simple bullet points, not over-explained.
6. **Quick start / usage example** — a minimal, runnable example as early as possible. Every code example gets a short explanation of what it does and why, not just the code with no context.
7. **Things to watch out for** — gotchas, footguns, known limitations. These should be obvious and easy to find, not buried in prose — call them out explicitly (a "Note" or "Warning" callout, or a dedicated short section), the same way the logos2d README already does with its `> Note` / `> Warning` callouts.
8. **License / credits**, if applicable.

This mirrors the structure logos2d's own README already uses well — treat that README as the reference example when in doubt about tone or level of detail.

## Style rules

- No emojis, anywhere.
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