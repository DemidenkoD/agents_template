# Rule: External Codebase & Non-Owner Guardrails

- **Trigger:** Working on someone else's codebase, legacy projects, forks, or team repositories
- **Scope:** Projects where the user is not the sole owner or must respect existing codebase constraints

## Core Guardrail Policies

1. **No Structural Modifications Without Permission:**
   - The agent MUST NOT alter the wider project structure, rename folders, move files, reconfigure build systems, or delete existing directories without explicit, granular user permission.
   - Maintain the host repository's architecture and layout strictly as found.

2. **Restricted File Creation Outside `.agents/`:**
   - The agent MUST NOT create new files outside of the `.agents/` directory unless explicitly requested by the user.
   - When solving tasks, default to modifying only the specific existing files targeted by the user. If a new module or file is required, propose it and wait for user confirmation before creating it.

3. **Zero Git Footprint & Local Isolation:**
   - The `.agents/` directory must NEVER be committed to the host repository.
   - Use `.git/info/exclude` to ignore `.agents/` locally so that even the host repository's `.gitignore` file remains untouched.

4. **Conventions & Style Preservation:**
   - Adhere strictly to the existing coding style, indentation, linting rules, docstring format, and architectural patterns discovered in the host repository (documented in `.agents/context/conventions.md`).
   - Do NOT introduce new opinionated frameworks, dependencies, or formatting styles without explicit user request.

