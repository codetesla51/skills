---
name: "plan-mode"
description: "Plan-only mode: discuss before coding, no code/files except final plan.md."
version: 3
created: "2026-09-07"
updated: "2026-09-25"
---
# Plan Mode

## Core rule: no code, no file edits

In plan mode, the agent talks through the problem with Uthman and does not write or edit any code, and does not touch any files, except for producing/updating `plan.md` at the end. This is a conversation, not an implementation session. If the conversation drifts toward "let me just write this real quick to show you," stop — that's not what this mode is for.

## How to think and talk during planning

- **Always think before responding.** Don't answer the first idea that comes to mind — actually reason about tradeoffs before speaking.
- **Reply simply.** Use the explainer skill's structure: high-level first, plain language, no unnecessary jargon. A plan discussion should be easy to follow out loud, not read like a spec document from the first sentence.
- **Default to the simple solution over the complex one** — this is the architecture-planning skill's core stance, and it applies here just as much as in actual architecture decisions. When a complex approach is tempting, name the simple alternative first and explain specifically why it isn't enough, rather than skipping straight to the complex version.
- **Talk through tradeoffs out loud**, not just the final recommendation. Uthman should see the reasoning, not just get handed a conclusion — this is a planning conversation, not a ruling.
- **Explain what could break.** For whatever's being planned, actively raise the realistic failure modes and edge cases before they're an accident found in code — same failure-mode-hunting instinct as the architecture-planning skill, applied at the feature level, not just the system level.
- **Scope tightly.** Resist the urge to plan more than what's actually being asked for. A plan for one feature should not quietly grow into a plan for three adjacent features "while we're at it" — flag those separately as out of scope rather than folding them in.

## This mode and architecture-planning share one plan.md

Plan mode is not a separate document from the architecture-planning skill's `plan.md` — they're the same file. When the plan involves a real architecture or technology decision (not just "what order to build things in"), run the architecture-planning skill's process directly inside this conversation: state the requirement, propose the boring option first, find where it fails, only escalate if a real failure mode demands it. Every architecture decision reached this way goes in the same `plan.md`, in the same format described there — don't maintain two separate plan documents for one project.

## Producing / updating plan.md

Always in `plan.md` at the project root, always gitignored — same as architecture-planning. If `plan.md` already exists, read it first and build on it; don't overwrite or start a fresh one.

Same structure as architecture-planning's:

```markdown
# Architecture Plan — <project>

## Overview
<the full front-to-back picture: components, data flow, diagram>

## Decisions
- [x] Storage: Postgres — boring option; SQLite ruled out because <specific failure>. (2026-09-25)
- [ ] Job queue: TBD — cron vs Kyu, pending write-volume numbers.

## Out of scope
- <anything that came up during planning but was deliberately excluded, with why>

## Tasks
- [x] Set up Postgres schema (2026-09-25)
- [ ] Wire up handler → store path
- [ ] Add retry logic for external API calls
```

- **Overview**: what's being built, stated plainly, plus the full picture diagram — carried from the architecture-planning skill's deliverable rule.
- **Decisions**: the approach decided on and why (boring-vs-complex reasoning, condensed), one dated line per decision. Known risks/failure modes from the conversation get a short note next to the relevant decision, not re-derived later from scratch.
- **Out of scope**: anything raised during planning but deliberately excluded, so it doesn't quietly get built later without a real decision to do so.
- **Tasks**: roughly ordered, each independently checkable — not a vague phase. Mark `[x]` with the date the moment it's actually verified done, never before. Never delete a line; if a decision or task changes later, append a new dated line explaining the change instead of erasing the old one — the file is the project's roadmap history, not just its current state.

Keep it simple and readable — this is a working plan, not a formal spec document. Follow the readme-writing skill's style instincts (no emojis, minimal em dashes, simple sentences) even though it's not a README.

## After the plan exists: follow it strictly

Once `plan.md` is written and implementation starts, follow its scope strictly. Do not silently expand scope, swap the agreed approach for a different one, or add anything not in the plan — unless Uthman explicitly says otherwise in the moment. If something comes up during implementation that seems like it should change the plan, stop and raise it as a conversation, not a silent deviation — update `plan.md` (append, don't overwrite) to reflect the change once agreed, don't just diverge from it in the code.

## What to avoid

- Don't write or edit any code during the planning conversation itself, including "just a quick example" snippets that aren't part of the final plan.md.
- Don't skip straight to a complex solution without first stating the simple one and why it falls short.
- Don't let scope creep into the plan itself — a bigger plan than what was asked for is a failure of this mode, not thoroughness.
- Don't treat `plan.md` as a suggestion once implementation starts — deviating without flagging it defeats the purpose of planning first.
- Don't create a second plan document, or overwrite plan.md's history — one file, one roadmap, append-only.
- Don't forget to check plan.md is actually gitignored before writing to it.
