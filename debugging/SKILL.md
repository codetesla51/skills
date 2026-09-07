---
name: "debugging"
description: "How to debug a bug. Ordered sequence; always report cause and fix."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Debugging

## The sequence — follow in order

1. **Find the bug.** Reproduce it. Don't start reading code or guessing until there's a concrete way to trigger the failure — a specific input, a specific command, a specific test.
2. **Read the error first.** The actual error message and stack trace, in full, before forming any theory. Most of the answer is usually already in the error text — read it carefully rather than skimming past it to get to the "real" debugging.
3. **Check the logs.** Application logs, system logs (`journalctl` where relevant), anything already being recorded that shows what happened leading up to the failure.
4. **Isolate to find the actual cause.** Narrow down which component, function, or line is responsible — cut the problem in half repeatedly (comment out code, bisect commits, remove inputs) rather than staring at the whole system at once.
5. **Use debug prints to find where execution stops or diverges.** When it's not obvious where things go wrong, add prints at decision points to see how far execution actually gets and what the values are at that point, rather than guessing.
6. **Check if it's platform-specific.** If the bug only shows up on one OS/architecture/environment, isolate to that specific platform before assuming the bug is in the general logic — platform-specific bugs (file paths, line endings, syscalls, GPU drivers) need a different kind of fix than logic bugs.
7. **Fix the bug.** Only after the actual cause is identified — not a plausible-looking symptom.

## Always report back — every single time

After every bug fix, report back to Uthman, without being asked:

- **What caused it** — the actual root cause, not just "there was a bug in X."
- **How it was fixed** — what changed and why that addresses the cause, not just the symptom.

This applies to every bug, no exceptions — even small ones. Don't silently fix something and move on without explaining it. Use the explainer skill's high-level-then-low-level structure for this report: one or two plain sentences on what went wrong, then the mechanism.

## What to avoid

- Don't jump straight to a fix based on a guess before reading the actual error/logs — a fix for the wrong cause often looks like it works while leaving the real bug in place.
- Don't skip isolation and try to reason about the whole system at once when the bug could be narrowed down first.
- Don't fix a bug and move on without reporting back — the report is not optional, even for a one-line fix.
- Don't assume a bug is platform-specific (or isn't) without actually checking — verify rather than guess which category it falls into.