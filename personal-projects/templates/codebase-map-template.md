# Codebase Map: [Project Name]

## 1. Executive Summary
- **Domain / Purpose:** [Brief description of what this application does]
- **Primary Languages & Frameworks:** [e.g. Python 3.11, FastAPI, SQLAlchemy, PostgreSQL]
- **Package & Dependency Manager:** [e.g. uv, poetry, pip, npm]

## 2. Key Directories & Responsibilities
- `src/core/`: Application settings, logging, and core utilities.
- `src/domain/`: Core business models, entities, and validation logic.
- `src/services/`: Application services and business logic orchestration.
- `src/api/`: Route handlers, controllers, and request/response schemas.
- `tests/`: Test suites (unit, integration, e2e).

## 3. Critical Entrypoints & Execution Paths
- **Application Startup:** `src/main.py` -> `create_app()`
- **Primary Request Flow:** `Router` -> `Service` -> `Repository` -> `DB`
- **Background Jobs / Workers:** [Celery, cron, or async workers if applicable]

## 4. Run & Test Commands
- **Run Application Locally:** `[command]`
- **Execute Test Suite:** `[e.g. uv run pytest tests/]`
- **Linting & Type Checking:** `[e.g. uv run ruff check . && uv run mypy src/]`

