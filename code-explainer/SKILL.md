---
name: "code-explainer"
description: "Explain a code repository: high-level-first, then architecture, then details with why."
version: 2
created: "2026-09-07"
updated: "2026-09-25"
---
# Code Explainer

## When to Use
Use when asked to explain, walk through, or onboard onto a repo or codebase.

Shares the explainer skill's style rules — minimal text, diagrams over prose for structure/flow, concrete over abstract, no meta-phrasing. This file adds what's specific to explaining a whole repo.

## Before writing anything: actually read it

Don't infer architecture from file/folder names alone. Open the entry point (`main.go`, `cmd/`), the README if one exists, and skim tests — tests often state intent more plainly than the implementation does. Guessing at structure from names and being wrong wastes more of his time than the extra minute of reading.

## Procedure
1. **Pass 1 — purpose.** 1-2 plain sentences on what the repo is and who it's for. No code, no file names, no architecture yet.
2. **Pass 2 — architecture.** Entry point, layout, data flow, key components and how they connect. Draw this — a directory tree for layout, an arrow chain for data flow/request path (`main → router → handler → store`), not a paragraph narrating each hop.
3. **Pass 3 — details with why.** Non-obvious choices and what breaks if changed. For each key component, also flag: what could go wrong here (the failure modes this code has to guard against — a race, a nil, a partial write, a retry storm) and whether it could be simpler (over-engineered abstraction, unnecessary layer, a stdlib function reinventing itself) — call it out plainly if so, don't just describe the code as-is uncritically. Skip explaining known stdlib/language concepts and known patterns he already uses (see coding-style skill) — go straight to what's actually specific to this repo.
4. **Close** with how to run/verify (build/test/run commands actually found in the repo, not assumed) and where to look next if he wants to go deeper into one part.

## Pitfalls
- Starting in file detail before the big picture.
- Dumping every file instead of the ones that matter to the architecture.
- Repeating pass 1 in pass 3.
- Describing structure/flow in prose when a tree or arrow-chain diagram says it in one line.
- Guessing at how something works instead of opening the file and checking.

## Verification
1. Reader gets purpose, structure, then mechanism-plus-why, in that order.
2. Every architectural claim traces back to a file actually opened, not assumed from its name.
3. Pass 3 names at least the real failure modes and any obvious over-engineering, not just a neutral walkthrough.
