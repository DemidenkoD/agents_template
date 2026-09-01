# Rule: Production Code Quality & Architecture

- **Trigger:** Writing or refactoring production code in personal repositories
- **Scope:** Personal private production-grade projects

## Policy
1. **Strict Type Annotations:** All Python functions, methods, and classes must include explicit type hints (`mypy` compliant).
2. **Linting & Formatting:** Enforce `ruff` for linting and formatting. Fix all linter errors before declaring work complete.
3. **Clean Modular Architecture:** Separate concerns into clean layers (`domain`, `services`, `adapters`/`infrastructure`, `api`/`cli`).
4. **Documentation Integrity:** Preserve all existing non-obvious docstrings and comments. Include docstrings for all public modules and functions.

