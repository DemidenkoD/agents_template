---
name: analyze-codebase-context
description: Safely audits someone else's codebase in read-only mode, extracts architecture, entrypoints, and conventions into .agents/context/, and sets up .agents/todo.md without modifying any outside files.
---

# Skill: Analyze Codebase Context

## Purpose
Onboards the agent to someone else's codebase or an unfamiliar external project. Performs read-only analysis to understand the architecture, coding conventions, test setup, and key paths, storing all adaptation findings strictly inside the local `.agents/context/` directory.

## Strict Operational Boundaries
- **READ-ONLY on Host Project:** The agent must NOT edit, move, delete, or reformat any existing project files during analysis.
- **No Outside File Creation:** All output files MUST be written exclusively inside `.agents/` (`.agents/context/`, `.agents/todo.md`).
- **No Git Pollution:** Do not modify `.gitignore` unless instructed; use `.git/info/exclude` to isolate `.agents/`.

## Procedural Steps

1. **Safety & Git Check:**
   - Verify `.agents/` is excluded locally (append `.agents/` to `.git/info/exclude` if not already ignored).

2. **Discover Tech Stack & Configuration:**
   - Inspect build/dependency files (`pyproject.toml`, `package.json`, `Cargo.toml`, `go.mod`, `pom.xml`, `Makefile`, `Dockerfile`).
   - Identify active package managers, linters, and test runners (`pytest`, `jest`, `cargo test`).

3. **Map Directory Layout & Entrypoints:**
   - Identify core application entrypoints (`main.py`, `app.py`, `index.ts`, `cmd/`).
   - Identify critical business logic, domain services, adapters, and database models.
   - Generate `.agents/context/codebase-map.md`.

4. **Extract Coding Conventions & Patterns:**
   - Inspect existing files for indentation, naming patterns (camelCase, snake_case), typing conventions, error handling styles, and test idioms.
   - Generate `.agents/context/conventions.md`.

5. **Summarize Architecture:**
   - Document component interactions, APIs, and external integrations in `.agents/context/architecture.md`.

6. **Initialize Task Roadmap:**
   - Create `.agents/todo.md` with pending tasks, bug investigation steps, or feature objectives requested by the user.

