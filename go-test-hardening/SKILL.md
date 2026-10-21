---
name: "go-test-hardening"
description: "Write Go tests that try to break the code and fail when it is wrong, then prove they can. Use this skill whenever writing, reviewing, fixing, or extending tests for Go code, when the user asks to make a function reliable, bulletproof, \"never break\", or well tested, when tests were written by an AI agent and need checking, or when testing Postgres-backed Go code. Covers attack-first test design, edge cases, fuzzing, race detection, real-database tests, mocking and fakes, mutation testing (with the gremlins tool or by hand), and a written report of known gaps. Trigger even if the user only says \"add tests\" or \"write tests for this function\" in a Go project."
version: 1
created: "2026-10-21"
updated: "2026-10-21"
---

# Go test hardening

The goal of a test is to find where code breaks. A test is an attack on the code,
not a demonstration that it runs.

Agents default to the opposite: tests that pass, copy the implementation's logic
into the expectation, mock everything, assert nothing, and never saw a red state.
This skill replaces that with a workflow where every test has to earn its place.

A test suite cannot prove code never breaks. The goal is to attack the code from
several angles until bugs are hard to hide, and to be honest about what is not covered.

## Mindset: never test by just running the function

A test that only calls a function is not a test. All of these are banned:
- calling the function and checking only that it did not panic or return an error
- calling it and printing or logging the result
- calling it to reach a line, raise coverage, or make the suite green
- asserting something that is true no matter what the code does

Instead:
- **Every test targets a specific bug.** Name or comment each test with the bug it
  would catch ("off-by-one at the discount threshold", "double charge on retry").
  If you cannot name a bug the test would catch, delete the test.
- **Assume the code is wrong until it survives.** Spend most of the effort on
  inputs and conditions built to break it: boundaries, invalid and hostile input,
  failing dependencies, concurrency, retries.
- **A break is a success.** When an attack finds a bug, report it. Do not adjust
  the test until it passes and do not hide it. If you made a serious attempt and
  found nothing, say what you tried.
- **Green proves nothing by itself.** After a test passes, ask what change to the
  code would make it fail. If the answer is "nothing", the test is worthless.

## Workflow

Follow these in order. Do not skip a step silently; if a step cannot be done
(tool missing, no Docker), say so in the report.

### 1. Write the contract first
Before writing any test, write down what the function promises, from the
requirement, docstring, or caller needs, not from reading the implementation line by line:
inputs and valid ranges, outputs, errors returned, side effects, and invariants
(things that must always be true). Use `assets/TEST_NOTES.template.md`.
Expected values in tests come from this contract. If the contract is unclear, ask
the user rather than inferring it from the code. Tests derived from the code
only prove the code does what it does.

### 2. List the ways it could break
Read `references/checklist.md` and write down the attacks before coding tests:
boundaries (one below, at, one above), zero/nil/empty, duplicates, ordering, huge
and negative values, unicode, malformed input, dependency failures, timeouts,
concurrency. Each item becomes a test or a recorded gap.

### 3. Write behavior-level tests
- Table-driven tests with named cases, `t.Run` per case.
- Assert on outputs and observable effects, not internals.
- Hardcode expected values from the contract. Never compute the expected value
  with the same logic as the code under test.
- Assert on the specific error (`errors.Is`/`errors.As`), not just `err != nil`.

### 4. Prove each test can fail (red first)
- Bug fix: run the new test against the unfixed code and confirm it fails for the
  right reason, then fix, then confirm it passes.
- New code: for each important test, break the implementation and confirm the test
  goes red. Step 8 covers how to do this safely.

### 5. Add fuzz or property tests when there is an invariant
If the function has a rule that must always hold (never negative, round-trips,
idempotent, output sorted, no panic on any input), add a fuzz test:
```go
func FuzzThing(f *testing.F) {
    f.Add(100) // seed with boundaries
    f.Fuzz(func(t *testing.T, in int) {
        out := Thing(in)
        if out < 0 { t.Fatalf("negative output %d for input %d", out, in) }
    })
}
```
Commit any crashing inputs Go writes to `testdata/fuzz/`.

### 6. Use real dependencies for what you own; mock the rest properly
Do not mock the database, queue, or cache the project owns. Mocks miss constraints,
locking, transaction behavior, and query-planner quirks. For Postgres, use a real
instance (testcontainers-go, or a template database per test) and isolate each test
with a transaction that rolls back or a fresh database. Details in
`references/checklist.md`.

Mock only what you cannot run or control: third-party APIs, payment or email
providers, the clock, randomness, and failures you cannot trigger on demand. Read
`references/mocking.md` before writing any mock or fake. The short version:
- prefer fakes over strict mocks; define small interfaces at the consumer
- every mocked dependency must be able to fail, and every failure path gets a test
  (error, timeout, slow response, malformed data, retry, context cancel)
- use `httptest` for HTTP instead of mocking `http.Client`
- assert outcomes, not call counts or call order
- keep fakes faithful to the real thing

### 7. Run the checks
```bash
bash scripts/run_checks.sh ./path/to/pkg 30   # vet, -race, flakiness, fuzz for 30s each
```
Everything must pass. A flaky test is a failing test: find the cause (shared state,
time, ordering, goroutines), do not retry it until green.

### 8. Break the code yourself (mutation testing)
Mutation testing means deliberately introducing a small bug and checking that a
test fails. A mutant that no test catches ("LIVED" or "survived") is a hole in the
suite. The tool `gremlins` automates this, but it is optional; the practice is not.

**With gremlins (optional, use when installed):**
```bash
bash scripts/mutation_gate.sh 70      # run from the Go module root; 70 = min efficacy %
```
If gremlins is not installed the script says so and exits cleanly. Do not install
it unless the user wants that, and never report mutation results you did not get.

**By hand (always do this, with or without gremlins):** act like gremlins. Pick the
riskiest lines (conditions, boundaries, arithmetic, error handling, early returns,
loops) and mutate them one at a time using `references/manual-mutation.md` and
`scripts/manual_mutate.sh`, which applies one mutation in a throwaway copy of the
module and runs the tests, so the real code is never left broken. For each
mutation, KILLED is good; LIVED means write a test that kills it, or write a
one-line justification (for example, the mutation does not change behavior).
At minimum, hand-mutate every conditional and boundary in the code you tested.

Do not lower a threshold or skip a mutant to make the result look better.

### 9. Write the report
Fill in `assets/TEST_NOTES.template.md` and save it as `TEST_NOTES.md` next to the
tests (or include it in the PR description). The report is not optional: the
sections on bugs found, surviving mutants, and known gaps are what keep the work honest.

## Hard rules

- Never write a test that only runs the function, or one that cannot fail.
- Never mock something the project owns (its database, its own packages), and never
  write a test that asserts the mock's own return value.
- Every mocked dependency gets at least one failure-path test.
- Never edit or delete an existing test just to make it pass. If the test's
  expectation is wrong according to the contract, say so explicitly and explain why.
- Never weaken a threshold, skip a test, or add `t.Skip` to get green without
  telling the user.
- Never leave a deliberately broken (mutated) version of the code in the working tree.
- Never claim code is "fully tested" or "bug-free". Report what was attacked and
  what was not.
- Keep test code as readable as production code. A confusing test gets ignored.
- Use `-race` and `-count=1` when running tests so results are not cached.

## Output the user should see

At the end, summarize in a few lines: what you attacked, what broke (bugs found,
mutants that survived and what you did about them), what is deliberately not
covered, and the commands to re-run everything.
