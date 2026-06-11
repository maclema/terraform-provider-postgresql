#!/bin/bash
set -u

# Run the full acceptance test suite (superuser + rds) against multiple
# PostgreSQL major versions, one at a time.
#
# Override the version list with:
#   PGVERSIONS="15 16 17" make testacc-all
PGVERSIONS=${PGVERSIONS:-"12 13 14 15 16 17 18"}

log() {
  echo "############################################################"
  echo "## ->  $1 "
  echo "############################################################"
}

passed=()
failed=()

for version in $PGVERSIONS; do
  log "Running acceptance tests against PostgreSQL ${version}"
  if PGVERSION="$version" "$(pwd)"/tests/testacc_full.sh; then
    passed+=("$version")
  else
    failed+=("$version")
  fi
done

log "Summary"
echo "Passed: ${passed[*]:-none}"
echo "Failed: ${failed[*]:-none}"

if [ ${#failed[@]} -ne 0 ]; then
  exit 1
fi
