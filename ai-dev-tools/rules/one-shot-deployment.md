# Rule: Pragmatic One-Shot Deployment for AI Dev Tools

- **Trigger:** Containerizing, packaging, or deploying AI Dev Tools, MCP servers, or demo web applications.
- **Scope:** All AI Dev Tools projects and container definitions.

## Core Principle: Pragmatic Simplicity
AI Dev Tools and Zoomcamp projects typically require a **one-time deployment** (e.g. running an MCP server or demo app locally in Docker or deploying once to a cloud VM/VPS).

Avoid over-engineering:
- **NO** complex blue-green deployment sagas.
- **NO** multi-workflow database migration pipelines.
- **NO** multi-locale translation verification scripts.
- **YES** clean, single-command Docker containerization that works the first time.

---

## 1. Minimal Dockerfile Standards

1. **Lightweight Base Images:**
   - Use official slim or alpine images (e.g., `python:3.12-slim` or `node:20-alpine`).
2. **Multi-Stage Builds for Full-Stack Apps:**
   - Build frontend assets in a build stage and copy the static build artifacts into the backend or web server stage.
3. **Non-Root User:**
   - Create a non-root application user for running the service.
4. **Clean Dependency Caching:**
   - Copy dependency manifests (`pyproject.toml`, `requirements.txt`, or `package.json`) before copying application code so Docker caches dependencies effectively.

---

## 2. Single-File Compose Orchestration (`docker-compose.yml`)

Orchestrate the app, MCP server, or auxiliary services (e.g. SQLite / PostgreSQL / Redis) using a single, clear `docker-compose.yml`:

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    env_file:
      - .env
    environment:
      - NODE_ENV=production
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8000/health || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 5s
```

---

## 3. Environment & Secret Hygiene

1. **Zero Hardcoded Secrets:**
   - Secrets and API keys (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `DATABASE_URL`) must never be baked into Dockerfiles or committed to version control.
2. **Mandatory `.env.example`:**
   - Always commit a `.env.example` file that lists every required environment variable with placeholder values and brief setup comments.
3. **Ignore Local `.env`:**
   - Ensure `.env` is listed in `.gitignore`.

---

## 4. One-Shot Deployment Lifecycle

Keep operations to three straightforward commands:

```bash
# 1. Build and launch services in background
docker compose up -d --build

# 2. Verify health and logs
docker compose ps
docker compose logs --tail=50 -f app

# 3. Stop and clean up when needed
docker compose down
```
