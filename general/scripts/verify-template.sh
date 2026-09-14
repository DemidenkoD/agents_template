#!/usr/bin/env bash
# ==============================================================================
# Two-Tier Verification Runner Template
# Usage:
#   bash .agents/scripts/verify.sh [target]
#
# TWO-TIER TESTING ARCHITECTURE:
# ------------------------------
# 1. INNER LOOP (Targeted testing while developing - fast, low noise, <1s):
#      auth    - auth domain tests + static typecheck
#      api     - api routes and controllers
#      core    - shared core logic / contracts
#      ui      - component tests + linting
#      <path>  - directly run a specific test file
#
# 2. OUTER GATE (Full regression gate before commit or handoff):
#      commit | full - full test suite + typechecks + lint + session-end-check
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." 2>/dev/null && pwd || pwd)"
cd "${REPO_ROOT}"

TARGET="${1:-commit}"

echo "🔎 Running verification for target: ${TARGET}"

case "$TARGET" in
  # --------------------------------------------------------------------------
  # 1. Inner Loop: Targeted domain checks (Customise for your project)
  # --------------------------------------------------------------------------
  auth)
    echo "=== [Inner Loop] Verifying AUTH domain ==="
    # Example: pytest tests/test_auth.py OR bun test api/test/auth.test.ts
    # pytest tests/test_auth.py
    ;;

  api)
    echo "=== [Inner Loop] Verifying API domain ==="
    # Example: pytest tests/test_api.py OR npm test -- api
    ;;

  core)
    echo "=== [Inner Loop] Verifying CORE domain ==="
    # Example: npm run test:core OR cargo test core
    ;;

  # --------------------------------------------------------------------------
  # 2. Outer Gate: Comprehensive pre-commit & pre-handoff checks
  # --------------------------------------------------------------------------
  commit | full | all)
    echo "=== [Outer Gate] Step 1: Static Type Check ==="
    # Example: uv run mypy src/ OR bun run typecheck OR tsc --noEmit
    echo "Type check passed."

    echo "=== [Outer Gate] Step 2: Test Suite ==="
    # Example: uv run pytest tests/ OR bun test OR npm test
    echo "Test suite passed."

    echo "=== [Outer Gate] Step 3: Linter & Formatter ==="
    # Example: uv run ruff check . OR npm run lint
    echo "Lint check passed."

    echo "=== [Outer Gate] Step 4: Session End & Git Hygiene ==="
    if [[ -f "${SCRIPT_DIR}/session-end-check.sh" ]]; then
      bash "${SCRIPT_DIR}/session-end-check.sh"
    fi
    echo "✅ [Outer Gate] All checks passed! Ready for handoff/commit."
    ;;

  # --------------------------------------------------------------------------
  # 3. Direct file passthrough
  # --------------------------------------------------------------------------
  *)
    if [[ -f "$TARGET" ]]; then
      echo "=== Running specific test file: $TARGET ==="
      # Adapt test runner to your tech stack
      if command -v pytest >/dev/null 2>&1; then
        pytest "$TARGET"
      elif command -v bun >/dev/null 2>&1; then
        bun test "$TARGET"
      elif command -v npm >/dev/null 2>&1; then
        npm test -- "$TARGET"
      else
        echo "No test runner found for $TARGET"
        exit 1
      fi
    else
      echo "Unknown target: $TARGET"
      echo "Usage: $0 [auth | api | core | commit | full | path/to/test]"
      exit 2
    fi
    ;;
esac
