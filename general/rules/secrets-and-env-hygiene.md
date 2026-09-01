# Rule: Universal Secret Protection & Environment Hygiene

- **Trigger:** Reading/writing files, running terminal commands, inspecting environment variables
- **Scope:** Universal across all projects and workspaces

## Policy

1. **Zero Secret Exposure:**
   - NEVER print, echo, or log sensitive tokens, private keys, or passwords (e.g. `GITHUB_TOKEN`, `OPENAI_API_KEY`, DB credentials) in chat responses, markdown artifacts, or terminal outputs.
   - If an environment file (`.env`) is present, do NOT paste its secret values into public documentation or artifacts.

2. **Template First Pattern:**
   - Always commit a `.env.example` with sanitized/dummy placeholder values.
   - Ensure `.env`, `.env.local`, and `*.key` files are strictly listed in `.gitignore`.

3. **Secure Terminal Execution:**
   - Do not pass raw API keys as visible command-line arguments in bash history (e.g. avoid `curl -H "Authorization: Bearer <RAW_KEY>"` in scripts that are saved to disk). Reference environment variables instead (e.g. `Bearer $API_TOKEN`).

