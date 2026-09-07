---
name: "plan-mode"
description: "Plan-only mode: discuss before coding, no code/files except final plan.md."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Plan Mode

## Core rule: no code, no file edits

In plan mode, the agent talks through the problem with Uthman and does not write or edit any code, and does not touch any files, except for producing the final `plan.md` at the end. This is a conversation, not an implementation session. If the conversation drifts toward "let me just write this real quick to show you," stop — that's not what this mode is for.

## How to think and talk during planning

- **Always think before responding.** Don't answer the first idea that comes to mind — actually reason about tradeoffs before speaking.
- **Reply simply.** Use the explainer skill's structure: high-level first, plain language, no unnecessary jargon. A plan discussion should be easy to follow out loud, not read like a spec document from the first sentence.
- **Default to the simple solution over the complex one** — this is the architecture-planning skill's core stance, and it applies here just as much as in actual architecture decisions. When a complex approach is tempting, name the simple alternative first and explain specifically why it isn't enough, rather than skipping straight to the complex version.
- **Talk through tradeoffs out loud**, not just the final recommendation. Uthman should see the reasoning, not just get handed a conclusion — this is a planning conversation, not a ruling.
- **Explain what could break.** For whatever's being planned, actively raise the realistic failure modes and edge cases before they're an accident found in code — same failure-mode-hunting instinct as the architecture-planning skill, applied at the feature level, not just the system level.
- **Scope tightly.** Resist the urge to plan more than what's actually being asked for. A plan for one feature should not quietly grow into a plan for three adjacent features "while we're at it" — flag those separately as out of scope rather than folding them in.

## Refer to the architecture-planning skill for the actual tradeoff analysis

When the plan involves a real architecture or technology decision (not just "what order to build things in"), use the architecture-planning skill's process directly: state the requirement, propose the boring option first, find where it fails, only escalate if a real failure mode demands it.

## Producing plan.md

Once the discussion has converged on an actual approach, write it to `plan.md`. The plan should capture:

- **What's being built** — scope, stated plainly.
- **The approach decided on**, and briefly why (the boring-vs-complex reasoning from the conversation, condensed).
- **What could break / known risks** — carried over from the conversation, not re-derived from scratch.
- **Explicit out-of-scope items** — anything that came up during planning but was deliberately excluded, so it doesn't quietly get built later without a decision to do so.
- **Steps**, roughly ordered, similar in spirit to the atomic-step breakdowns used for kyfram — each step should be independently checkable, not a vague phase.

Keep `plan.md` itself simple and readable — this is a working plan, not a formal spec document. Follow the readme-writing skill's style instincts (no emojis, minimal em dashes, simple sentences) even though it's not a README.

## After the plan exists: follow it strictly

Once `plan.md` is written and implementation starts, follow its scope strictly. Do not silently expand scope, swap the agreed approach for a different one, or add anything not in the plan — unless Uthman explicitly says otherwise in the moment. If something comes up during implementation that seems like it should change the plan, stop and raise it as a conversation, not a silent deviation — update `plan.md` to reflect the change once agreed, don't just diverge from it in the code.

## What to avoid

- Don't write or edit any code during the planning conversation itself, including "just a quick example" snippets that aren't part of the final plan.md.
- Don't skip straight to a complex solution without first stating the simple one and why it falls short.
- Don't let scope creep into the plan itself — a bigger plan than what was asked for is a failure of this mode, not thoroughness.
- Don't treat `plan.md` as a suggestion once implementation starts — deviating without flagging it defeats the purpose of planning first.