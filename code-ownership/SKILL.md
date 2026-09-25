---
name: "code-ownership"
description: "Keep the human owning AI-written code: defense per batch, diffs before commits, rejected options, hands-on fixes."
version: 2
created: "2026-09-12"
updated: "2026-09-25"
---
# Code Ownership

## When to Use
Use on every coding task where an AI agent writes code the human will own: before commits, after batches, whenever velocity tempts skipping review.

## Procedure
1. Before any commit of AI-written code, defend ONE decision: what it does, what was rejected and why. No defense, no commit.
2. Put the defense in the commit message itself, not just said out loud — a one-line "why this, not X" in the commit body. If the commit message can't state it, the decision wasn't actually made.
3. Read git diff before every commit, never just the agent's summary.
4. Keep batches small enough to actually review — a diff too large to read in one sitting doesn't get rubber-stamped, it gets split. Ownership scales with diff size in the wrong direction: bigger batches get skimmed, not read.
5. End every design answer with the rejected alternative and why it lost. No named rejection means no design happened. If the decision is architectural (not just a local code choice), it also belongs in `plan.md`'s Decisions section (see architecture-planning skill) — don't let it live only in chat history.
6. Touch code weekly: change a number, rename something, break a test on purpose and watch it fail.
7. When the urge to ask 'explain again' appears, explain it back first (wrong is fine) and let the agent correct.
8. Check any agent-written test before trusting it: does it assert the *intended* behavior, or does it just assert whatever the code currently does? A test that would still pass after reintroducing the bug it's meant to catch is worthless — read the assertion, not just the pass/fail color.

## Pitfalls
- Accepting summaries instead of reading diffs — summaries are sales pitches.
- Accepting a large batch because splitting it feels like it slows things down — the slowdown is the point; that's the review actually happening.
- Asking for re-explains instead of explaining back wrong and getting corrected.
- Letting green tests substitute for understanding — tests only check what was thought to assert, and an agent-written test can be shaped to match the code instead of the intent.
- Committing fast yeses with no defense step when velocity feels good.
- Letting a defended decision live only in the conversation — if it's architectural, it needs to end up in `plan.md` or it's lost the next session.

## Verification
1. Human can state why any merged piece works the way it does, not just what it does.
2. Recent commits each trace to a defended decision, not a fast yes — and that defense is visible in the commit message itself.
3. Every commit's diff was small enough to have actually been read in full.
4. Any agent-written test in the batch asserts intended behavior, confirmed by deliberately breaking the code and watching that specific test fail.
