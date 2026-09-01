---
name: scaffold-prod-repo
description: Scaffolds a production-ready Python repository with a clean minimal repo footprint, local self-contained .agents/ directory (ignored in git), uv, ruff, mypy, and pytest.
---

# Skill: Scaffold Production Repository

## Purpose
Initializes a full production-grade Python project layout equipped with linting, typing, testing, environment configuration, and a clean local-only `.agents/` directory for app logs, change tracking, and task management.

## Repository Layout Produced
```text
project_root/
├── .gitignore                           # Ignores .venv/, .agents/, .env, etc.
├── pyproject.toml                       # Dependencies and ruff/mypy/pytest configurations
├── .env.example                         # Template environment variables
├── Dockerfile                           # Production container build
├── README.md                            # Clean documentation
├── src/<package_name>/                  # Clean layered application logic
├── tests/                               # pytest test suite
└── .agents/                             # LOCAL ONLY (Ignored by Git)
    ├── todo.md                          # Local task list & milestone roadmap
    ├── logs/                            # App runtime logs & debug output for agent inspection
    ├── changes/                         # AI changelog files explaining what changed & why
    ├── rules/                           # Project agent rules
    └── skills/                          # Project agent skills
```

## Procedural Steps
1. Run `uv init --lib` or `uv init --app`.
2. Configure `pyproject.toml` with `ruff`, `mypy`, and `pytest` settings.
3. Add core dependencies (`uv add pydantic pydantic-settings structlog`) and dev dependencies (`uv add --dev ruff mypy pytest pytest-cov`).
4. Set up standard folder structure:
   - `src/<package_name>/`: Source code (`config.py`, `main.py`, `services/`, `adapters/`).
   - `tests/`: Unit and integration tests (`conftest.py`, `test_main.py`).
   - `.github/workflows/ci.yml`: GitHub Actions workflow running `ruff`, `mypy`, and `pytest`.
   - `.env.example`: Template environment keys.
   - `Dockerfile`: Multi-stage build container.
5. Set up the local `.agents/` structure:
   - Create `.agents/logs/` and `.agents/changes/`.
   - Create `.agents/todo.md`.
   - Ensure `.agents/` is added to `.gitignore`.
6. Verify test runner: `uv run pytest`.
