---
name: "code-ownership"
description: "Keep the human owning AI-written code: defense per batch, diffs before commits, rejected options, hands-on fixes."
version: 1
created: "2026-09-12"
updated: "2026-09-12"
---
## When to Use
Use on every coding task where an AI agent writes code the human will own: before commits, after batches, whenever velocity tempts skipping review.

## Procedure
1. Before any commit of AI-written code, defend ONE decision: what it does, what was rejected and why. No defense, no commit.
2. Read git diff before every commit, never just the agent's summary.
3. End every design answer with the rejected alternative and why it lost. No named rejection means no design happened.
4. Touch code weekly: change a number, rename something, break a test on purpose and watch it fail.
5. When the urge to ask 'explain again' appears, explain it back first (wrong is fine) and let the agent correct.

## Pitfalls
- Accepting summaries instead of reading diffs — summaries are sales pitches.
- Asking for re-explains instead of explaining back wrong and getting corrected.
- Letting green tests substitute for understanding — tests only check what was thought to assert.
- Committing fast yeses with no defense step when velocity feels good.

## Verification
1. Human can state why any merged piece works the way it does, not just what it does.
2. Recent commits each trace to a defended decision, not a fast yes.