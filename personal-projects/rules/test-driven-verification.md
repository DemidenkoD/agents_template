# Rule: Test-Driven Verification Standards

- **Trigger:** Feature implementation, bug fixes, or code refactoring
- **Scope:** Personal private production-grade projects

## Policy
1. **Empirical Verification Required:** NEVER declare a feature complete or bug fixed without running tests (`uv run pytest`) and demonstrating clean passing status.
2. **Automated Test Coverage:** New logic must be accompanied by unit tests in `tests/` covering main paths and edge cases.
3. **No Symptom Masking:** Never resolve test failures by swallowing exceptions, deleting failing assertions, or returning dummy fallbacks. Address the underlying logic contract.

