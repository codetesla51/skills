---
name: "debugging"
description: "How to debug a bug. Ordered sequence; always report cause and fix."
version: 3
created: "2026-09-07"
updated: "2026-09-25"
---
# Debugging

## The sequence — follow in order

1. **Find the bug.** Reproduce it. Don't start reading code or guessing until there's a concrete way to trigger the failure — a specific input, a specific command, a specific test.
2. **Shrink the reproduction.** Cut away everything not needed to trigger the failure — fewer inputs, a smaller test case, one request instead of a whole flow. A minimal repro makes every later step (reading, isolating, verifying) faster and is often half the diagnosis on its own.
3. **Read the error first.** The actual error message and stack trace, in full, before forming any theory. Most of the answer is usually already in the error text — read it carefully rather than skimming past it to get to the "real" debugging.
4. **Check the logs.** Application logs, system logs (`journalctl` where relevant), anything already being recorded that shows what happened leading up to the failure.
5. **Check what changed recently.** If this used to work, `git diff`/`git log` since the last known-good state (or `git bisect` if the "last good" point isn't obvious) often points straight at the cause — cheaper than isolating from scratch.
6. **Form a hypothesis, then test it.** State in one sentence what you think is wrong before changing anything. A hypothesis you can't state plainly is a guess, not a diagnosis — and a guess you "fix" without testing often leaves the real bug in place.
7. **Isolate to find the actual cause.** Narrow down which component, function, or line is responsible — cut the problem in half repeatedly (comment out code, bisect commits, remove inputs) rather than staring at the whole system at once.
8. **Use debug prints to find where execution stops or diverges.** When it's not obvious where things go wrong, add prints at decision points to see how far execution actually gets and what the values are at that point, rather than guessing. Print the actual value, don't assume it — a variable that "should" be X is exactly where wrong assumptions hide.
9. **Check if it's platform-specific.** If the bug only shows up on one OS/architecture/environment, isolate to that specific platform before assuming the bug is in the general logic — platform-specific bugs (file paths, line endings, syscalls, GPU drivers) need a different kind of fix than logic bugs.
10. **Fix the bug.** Only after the actual cause is identified — not a plausible-looking symptom.
11. **Verify the fix, don't assume it.** Re-run the original reproduction from step 1/2 and confirm it now passes. Then add a regression test covering the exact case that broke, so this doesn't come back silently.
12. **Check for the same bug elsewhere.** If the root cause is a pattern (a copy-pasted block, a misused API, a wrong assumption applied in one place), grep for other places that repeat the same pattern — they likely have the same bug even if it hasn't surfaced yet.

## Always report back — every single time

After every bug fix, report back to Uthman, without being asked:

- **What caused it** — the actual root cause, not just "there was a bug in X."
- **How it was fixed** — what changed and why that addresses the cause, not just the symptom.
- **How it was verified** — what confirms it's actually fixed (repro re-run, new test, both).

This applies to every bug, no exceptions — even small ones. Don't silently fix something and move on without explaining it. Use the explainer skill's high-level-then-low-level structure for this report: one or two plain sentences on what went wrong, then the mechanism.

## What to avoid

- Don't jump straight to a fix based on a guess before reading the actual error/logs — a fix for the wrong cause often looks like it works while leaving the real bug in place.
- Don't skip isolation and try to reason about the whole system at once when the bug could be narrowed down first.
- Don't fix a bug and move on without reporting back — the report is not optional, even for a one-line fix.
- Don't assume a bug is platform-specific (or isn't) without actually checking — verify rather than guess which category it falls into.
- Don't trust an assumed value — print or inspect it. "It should be empty here" is the assumption that's usually wrong.
- Don't call a fix done without re-running the original repro — a fix that "looks right" but was never re-tested against the actual failure isn't confirmed.
