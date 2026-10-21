#!/usr/bin/env bash
# Usage: manual_mutate.sh <file> <line> '<sed-expression>' [package-pattern]
# Applies ONE mutation to one line in a throwaway copy of the module, then runs
# the tests. The real working tree is never modified.
#
# Example: manual_mutate.sh pricing/pricing.go 9 's/>/>=/' ./pricing
#
# Result (also the exit code):
#   KILLED       (0) tests failed: they caught the bug. Good.
#   LIVED        (1) tests still passed: a hole. Add a test or justify it.
#   NOT VIABLE   (2) mutated code does not compile, or the mutation changed
#                    nothing, or the setup was wrong. Pick a different mutation.
set -uo pipefail

if [ "$#" -lt 3 ]; then
  sed -n '2,13p' "$0"
  exit 2
fi

FILE="$1"; LINE="$2"; EXPR="$3"; PKG="${4:-./...}"

ROOT="$(go list -m -f '{{.Dir}}' 2>/dev/null || true)"
if [ -z "$ROOT" ]; then echo "NOT VIABLE: run inside a Go module"; exit 2; fi
if [ ! -f "$FILE" ]; then echo "NOT VIABLE: no such file: $FILE"; exit 2; fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
(cd "$ROOT" && tar --exclude=.git -cf - .) | tar -xf - -C "$TMP"

REL="$(realpath --relative-to="$ROOT" "$FILE")"
TARGET="$TMP/$REL"

before="$(sed -n "${LINE}p" "$TARGET")"
sed -i "${LINE}${EXPR}" "$TARGET"
after="$(sed -n "${LINE}p" "$TARGET")"

echo "file:   $REL:$LINE"
echo "before: $before"
echo "after:  $after"

if [ "$before" = "$after" ]; then
  echo "NOT VIABLE: the mutation did not change the line"
  exit 2
fi

cd "$TMP" || exit 2
if ! go build ./... >/tmp/mutant_build.out 2>&1; then
  echo "NOT VIABLE: mutated code does not compile"
  head -n 5 /tmp/mutant_build.out
  exit 2
fi

if go test -count=1 "$PKG" >/tmp/mutant_test.out 2>&1; then
  echo "LIVED: tests still pass with this bug. Add a test that kills it, or justify."
  exit 1
fi

echo "KILLED: tests caught it."
grep -E '^(--- FAIL|FAIL)' /tmp/mutant_test.out | head -n 3
exit 0
