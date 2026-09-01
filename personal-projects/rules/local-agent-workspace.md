# Rule: Local Self-Contained Agent Workspace

- **Trigger:** Developing or maintaining personal repositories, client projects, or working on someone else's codebase
- **Scope:** Personal private projects and external non-owner codebases

## Core Operating Philosophy: The Guardian Persona
When working in this mode, the agent operates as a **Careful Guardian**:
- Exercise extreme caution with all host files.
- Treat `.agents/` as a safe local sandbox where notes, logs, context maps, and scratch testing scripts live.
- Perform changes to the wider project carefully and minimally, logging every modification locally with its rationale.

---

## Policy

1. **Strict Local Isolation:**
   - The `.agents/` directory MUST remain strictly local and excluded from version control.
   - For someone else's codebase: prefer using `.git/info/exclude` so even the project's `.gitignore` is not modified.
   - For private personal repos: add `.agents/` to `.gitignore`.
   - The repository itself remains clean, minimal, and free of agent artifacts.

2. **Self-Contained `.agents/` Directory Structure:**
   ```text
   .agents/
   ├── todo.md                  # Task roadmap & execution checklist (inside .agents/, not in project root)
   ├── context/                 # Codebase analysis results to help agent adapt to the project
   │   ├── codebase-map.md      # Key directories, entrypoints, and critical paths
   │   ├── architecture.md      # High-level architecture, data flows, and dependencies
   │   └── conventions.md       # Discovered code styles, naming patterns, and test frameworks
   ├── scripts/                 # Safe local testing scripts, reproduction helpers, & scratchpads
   ├── logs/                    # Folder for app runtime logs, debug outputs, and server traces
   ├── changes/                 # AI-authored records explaining what changed and why
   ├── rules/                   # Project-specific agent rules (including non-owner guardrails)
   └── skills/                  # Project-specific agent skills
   ```

3. **Safe Local Testing Scripts (`.agents/scripts/`):**
   - Write all one-off reproduction scripts, test harnesses, or debugging helpers inside `.agents/scripts/`.
   - Never clutter the host repository with temporary test scripts.

4. **Context Analysis (`.agents/context/`):**
   - Stores architectural outlines and codebase adaptation findings generated during onboarding.
   - Enables the agent to understand foreign codebases immediately upon resumption without re-scanning the entire project.

5. **Application Logs (`.agents/logs/`):**
   - The user or automated scripts place runtime logs, crash dumps, or terminal outputs in `.agents/logs/`.
   - The agent inspects logs here when debugging issues without polluting repository directories.

6. **Change Tracking & Explanations (`.agents/changes/`):**
   - After completing feature implementations, refactors, or bug fixes, the agent writes a concise markdown log into `.agents/changes/` (e.g. `YYYY-MM-DD_<feature_name>.md`).
   - Documents summary of change, why it was made, files affected, and verification steps.
