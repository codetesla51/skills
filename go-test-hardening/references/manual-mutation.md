# Manual mutation: break the code the way gremlins would

Mutation testing asks one question: if I introduce a bug here, does any test notice?
Do this by hand for the riskiest lines even when the gremlins tool is not installed.

## Contents
- Procedure
- Mutation operators
- Where to aim first
- Recording results
- Safety

## Procedure
1. List the lines worth mutating (see "Where to aim first").
2. For each line, pick one mutation from the operator list.
3. Run it in a throwaway copy:
   ```bash
   bash scripts/manual_mutate.sh path/to/file.go 42 's/>/>=/' ./path/to/pkg
   ```
   The third argument is a sed expression applied to that line only. The script
   copies the module to a temp directory, so your real files are never touched.
4. Read the result:
   - KILLED: a test failed. Good. Move on.
   - LIVED: all tests passed with a bug in the code. Write a test that fails on the
     mutant and passes on the original, or write a one-line reason it is harmless.
   - NOT VIABLE: it did not compile or nothing changed. Pick another mutation.
5. After adding a test for a LIVED mutant, run the same mutation again to confirm
   it is now KILLED.

If sed cannot express the change (multi-line, deleting a block), edit a temporary
copy of the module by hand instead and run `go test -count=1` there.

## Mutation operators
These mirror what gremlins does, plus a few that matter for agent-written code.

| Operator | Example mutation |
|---|---|
| Conditional boundary | `>` to `>=`, `<` to `<=`, and the reverse |
| Conditional negation | `==` to `!=`, `>` to `<=`, `<` to `>=` |
| Arithmetic | `+` to `-`, `*` to `/`, `%` to `*` |
| Increment/decrement | `i++` to `i--` |
| Invert negatives | `-x` to `x` |
| Invert logical | `&&` to `\|\|`, and the reverse |
| Invert assignment | `+=` to `-=`, `*=` to `/=` |
| Loop control | `break` to `continue`, and the reverse |
| Constant change | `0` to `1`, `100` to `101`, `true` to `false` |
| Wrong return | return the zero value or the input unchanged |
| Dropped error | ignore a returned error instead of handling it |
| Removed guard | delete an `if x == nil { return ... }` or validation check |
| Removed statement | delete a write, an unlock, a close, a `defer` |
| Swapped arguments | swap two arguments of the same type |
| Off-by-one slice | `s[1:]` to `s[:]`, `len(s)-1` to `len(s)` |

## Where to aim first
Order by how much damage a bug there would do:
1. Conditions and boundaries (thresholds, limits, comparisons)
2. Error handling and early returns
3. Arithmetic on money, counts, sizes, time
4. Loops and slice indexing
5. Anything touching state: writes, locks, transactions, retries
6. Validation and authorization checks

Skip: log lines, comments, and formatting. Do not spend mutations there.

## Recording results
In `TEST_NOTES.md`, one row per mutation:

| Location | Mutation | Result | What was done |
|---|---|---|---|
| pricing.go:9 | `>` to `>=` | LIVED then KILLED | added boundary test at exactly 100 |
| pricing.go:14 | `-` to `+` | KILLED | none needed |

## Safety
- Mutate only in the throwaway copy. Never leave a mutated file in the working tree.
- Before finishing, run `git status` and `git diff`: the only changes should be the
  intended tests and notes.
- Some mutants are equivalent (the code behaves the same either way). Name the
  reason; do not contort a test to kill them.
