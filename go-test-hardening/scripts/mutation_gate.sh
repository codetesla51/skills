#!/usr/bin/env bash
# Usage: mutation_gate.sh [min-efficacy-percent] [extra gremlins flags...]
# Optional helper: runs gremlins on the Go module in the current directory and
# lists mutants no test caught. If gremlins is not installed, it exits 0 and tells
# you to mutate by hand instead (see references/manual-mutation.md).
#
# Verified against the gremlins docs: `gremlins unleash`, --threshold-efficacy
# (exit code 10 if not met), --threshold-mcover (exit code 11). Gremlins is 0.x,
# so flags can change between releases: check `gremlins unleash --help`.
set -uo pipefail

MIN="${1:-70}"
shift || true

if ! command -v gremlins >/dev/null 2>&1; then
  echo "gremlins is not installed (optional)."
  echo "Do manual mutation instead: references/manual-mutation.md and scripts/manual_mutate.sh"
  echo "Say in the test notes that no tool-based mutation results exist."
  echo "To install: go install github.com/go-gremlins/gremlins/cmd/gremlins@latest"
  exit 0
fi

if [ ! -f go.mod ]; then
  echo "Run this from the Go module root (the directory with go.mod)."
  exit 2
fi

gremlins unleash --threshold-efficacy "$MIN" "$@" 2>&1 | tee /tmp/gremlins.out
status=${PIPESTATUS[0]}

echo
echo "=== Mutants no test caught (LIVED) or no test reaches (NOT COVERED) ==="
echo "Each needs a new test or a written justification."
grep -E 'LIVED|NOT COVERED' /tmp/gremlins.out || echo "none"

case "$status" in
  10) echo "FAIL: test efficacy below ${MIN}%" ;;
  11) echo "FAIL: mutant coverage below threshold" ;;
esac
exit "$status"
