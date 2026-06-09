#!/bin/bash
# Runs the Patrol Android E2E suite with retries.

set -u

ATTEMPTS="${PATROL_ATTEMPTS:-3}"

for attempt in $(seq 1 "$ATTEMPTS"); do
  echo "::group::Patrol attempt $attempt/$ATTEMPTS"
  if dart run patrol_cli:main test --flavor standalone --verbose; then
    echo "::endgroup::"
    exit 0
  fi
  echo "::endgroup::"
  echo "Patrol attempt $attempt/$ATTEMPTS failed (likely an instrumentation-process crash); retrying..."
done

echo "Patrol failed after $ATTEMPTS attempts."
exit 1
