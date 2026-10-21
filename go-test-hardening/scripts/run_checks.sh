#!/usr/bin/env bash
# Usage: run_checks.sh [package-pattern] [fuzz-seconds-per-target]
# Runs vet, tests with the race detector, a flakiness check, and optional fuzzing.
set -uo pipefail

PKG="${1:-./...}"
FUZZ_SECS="${2:-0}"
fail=0

step() { echo; echo "=== $1 ==="; }

step "go vet"
go vet "$PKG" || fail=1

step "tests (race detector, no cache)"
go test -race -count=1 -cover "$PKG" || fail=1

step "flakiness check (20 runs)"
if ! go test -count=20 "$PKG" >/tmp/flaky.out 2>&1; then
  echo "FAILED or FLAKY. Last output:"
  tail -n 30 /tmp/flaky.out
  fail=1
else
  echo "stable across 20 runs"
fi

if [ "$FUZZ_SECS" -gt 0 ]; then
  step "fuzzing (${FUZZ_SECS}s per target)"
  found=0
  for pkg in $(go list "$PKG"); do
    for f in $(go test -list '^Fuzz' "$pkg" 2>/dev/null | grep '^Fuzz' || true); do
      found=1
      echo "-- $pkg $f"
      go test -run='^$' -fuzz="^${f}\$" -fuzztime="${FUZZ_SECS}s" "$pkg" || fail=1
    done
  done
  [ "$found" -eq 0 ] && echo "no fuzz targets found"
fi

echo
if [ "$fail" -ne 0 ]; then echo "RESULT: FAIL"; exit 1; fi
echo "RESULT: PASS"
