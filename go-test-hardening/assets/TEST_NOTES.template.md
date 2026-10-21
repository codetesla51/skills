# Test notes: <function or package>

## Contract
What this promises. Inputs and valid ranges, outputs, errors, side effects.

## Invariants
Rules that must always hold.
-

## Edge cases and failure modes considered
-

## What is real vs mocked
- Real:
- Mocked (and why):
- Failure paths tested for each mock (error, timeout, malformed, retry):
- How the fake or fixture was checked against the real thing:

## Bugs found
Every real bug the attacks exposed (even if already fixed), and which test found it.
Write "none found" only after listing what was tried.
-

## Red-first evidence
For each important test: how it was shown to fail (bug reproduced before fix, or
a deliberate mutation turned it red).
-

## Commands run and results
- go vet:
- go test -race -count=1:
- flakiness (-count=20):
- fuzz (targets, duration):
- mutation tool (gremlins, if installed: score, threshold; otherwise "not run"):

## Manual mutations
| Location | Mutation | Result | What was done |
|---|---|---|---|

## Surviving mutants
Each one still alive: location, what changed, and why it is acceptable.
-

## Known gaps
What was deliberately not tested, and why.
-

## How to re-run
