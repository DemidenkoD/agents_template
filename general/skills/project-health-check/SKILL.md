---
name: project-health-check
description: Audits project workspace health, package dependencies, environment setup, and code linting status.
---

# Skill: Project Health Check

## Purpose
Quickly evaluate the current state of a project directory to verify environment setup, dependency locks, code quality, and git working tree state.

## Procedural Steps

1. **Environment & Package Manager Audit:**
   - Check if `uv` or Python environment is active (`uv --version`, `python --version`).
   - Verify presence of project configuration files (`pyproject.toml`, `requirements.txt`, `package.json`).

2. **Git Status Audit:**
   - Run `git status` to check uncommitted changes or untracked files.
   - Verify `.gitignore` exists and covers standard runtime artifacts (`.venv/`, `__pycache__/`, `.env`, `data/raw/`).

3. **Dependency & Health Verification:**
   - For Python projects using `uv`: run `uv sync --dry-run` or check virtual environment status.
   - Run linter / syntax checks (`ruff check .` or `python -m py_compile`).

4. **Reporting:**
   - Summarize project readiness, missing config files, and recommendations.

