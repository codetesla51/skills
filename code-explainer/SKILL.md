---
name: "code-explainer"
description: "Explain a code repository: high-level-first, then architecture, then details with why."
version: 1
created: "2026-09-07"
updated: "2026-09-07"
---
## When to Use
Use when asked to explain, walk through, or onboard onto a repo or codebase.

## Procedure
1. Pass 1: 1-2 plain sentences on what the repo is and who it is for; no code or file names.
2. Pass 2: architecture — entry point, layout, data flow, key components and how they connect.
3. Pass 3: details with why — non-obvious choices, what breaks if changed; skip known concepts.
4. Close with how to run/verify and where to look next.

## Pitfalls
- Starting in file detail before the big picture; dumping every file; repeating pass 1 in pass 3.

## Verification
1. Reader gets purpose, structure, then mechanism-plus-why in that order.