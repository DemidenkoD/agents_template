#!/usr/bin/env bash
# ==============================================================================
# Universal Agent Session End Gate
# Validates:
#   1. Developer Diary has an entry for the session.
#   2. No temporary AGENT-RESERVE markers remain in source code.
#   3. Git diff is clean of whitespace/EOF/conflict errors.
#
# Usage: bash .agents/scripts/session-end-check.sh (or ./scripts/session-end-check.sh)
# ==============================================================================
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." 2>/dev/null && pwd || pwd)"
cd "${REPO_ROOT}"

fail=0

# 1. Check for Developer Diary entry
DIARY_PATH=""
if [[ -f ".agents/DEV_DIARY.md" ]]; then
  DIARY_PATH=".agents/DEV_DIARY.md"
elif [[ -f "DEV_DIARY.md" ]]; then
  DIARY_PATH="DEV_DIARY.md"
fi

if [[ -z "${DIARY_PATH}" ]]; then
  echo "FAIL: Neither .agents/DEV_DIARY.md nor DEV_DIARY.md found."
  fail=1
elif ! head -35 "${DIARY_PATH}" | grep -q "^## \["; then
  echo "FAIL: No recent diary entry found in head -35 of ${DIARY_PATH}."
  fail=1
else
  echo "OK: Diary entry present in ${DIARY_PATH}."
fi

# 2. Check for temporary reservation markers in tracked source
RESERVE_PATTERN="AGENT""-RESERVE"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git grep -n "${RESERVE_PATTERN}" -- ':!*.md' ':!*.json' ':!*.log' ':!*.sh' ':!.agents/scripts/*' 2>/dev/null; then
    echo "FAIL: Temporary ${RESERVE_PATTERN} markers found in source code."
    fail=1
  else
    echo "OK: No ${RESERVE_PATTERN} markers found in source."
  fi
else
  echo "SKIP: Not inside a git work tree (skipping marker check)."
fi

# 3. Check git diff hygiene (whitespace, trailing newlines, conflict markers)
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if ! git diff --check; then
    echo "FAIL: git diff --check reported whitespace or formatting errors."
    fail=1
  else
    echo "OK: Git diff hygiene clean."
  fi
else
  echo "SKIP: Not inside a git work tree (skipping diff check)."
fi

if [[ "$fail" -eq 0 ]]; then
  echo "✅ All session completion gates passed."
else
  echo "❌ Session completion gate failed. Resolve errors before handoff."
fi

exit "$fail"
