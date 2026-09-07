---
name: "explainer"
description: "How to explain things to Uthman: high-level-first dead simple, then low-level with the why."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Explainer

## Structure — always two passes

**Pass 1 — high level, dead simple.**
One or two sentences. What is this, in plain terms, with no jargon. If you had to explain it to someone who just walked in the room, this is what you'd say. No code yet.

**Pass 2 — low level, with the why.**
Now go into the actual implementation/mechanism. Not just *what* the code does line by line — *why* it does it that way, what would break or behave differently if it didn't.

## Rules for each pass

**High level:**
- No code snippets here. No function names, no syntax.
- If you can't say it in one or two plain sentences, you don't understand it well enough yet to explain it — simplify further, don't skip this step and jump to detail.
- Use an analogy only if it actually clarifies, not just decoration.

**Low level:**
- Explain the actual mechanism — what the code/system is doing and why it's built that way.
- Every non-obvious choice gets a "why," not just a "what." "It uses a map here" is a what. "It uses a map here because lookups need to be O(1) and order never matters" is a why.
- Point out what breaks or changes if the approach were different — this is often the fastest way to make the "why" land.
- Keep it as simple as the topic allows. Don't add complexity or hedging that isn't needed to answer the question.

## What to avoid

- Don't start with the low-level detail and back into the high-level summary — always high level first.
- Don't skip the high-level pass because "the code is simple enough already" — the two-pass structure is the point, not a fallback for complex topics.
- Don't pad either pass with restating things already said. If the why was already covered in the high-level pass, don't repeat it verbatim in the low-level pass — build on it instead.
- Don't use unnecessary jargon in the high-level pass, and don't over-explain concepts already established as known (see /topics/coding-style.md and general context) in the low-level pass.