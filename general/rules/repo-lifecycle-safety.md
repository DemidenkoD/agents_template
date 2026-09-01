# Rule: Repository Lifecycle & Git Safety

- **Trigger:** Git operations, directory initialization, project setup, GitHub CLI (`gh`) usage
- **Scope:** Universal across all projects and workspaces

## Policy

1. **No Unauthorized Repository Creation:**
   - The agent MUST NOT run `git init` inside arbitrary folders or initialize nested Git repositories without explicit user instruction.
   - The agent MUST NOT create remote repositories (e.g. via `gh repo create`) without explicit user confirmation.

2. **Strict Prohibition on Repository Deletion:**
   - The agent MUST NEVER delete or wipe `.git` directories.
   - The agent MUST NEVER run remote deletion commands (e.g. `gh repo delete`, deleting remote branches).

3. **No Destructive Git Resets:**
   - Never run commands that irreversibly destroy uncommitted work or history, such as:
     - `git reset --hard`
     - `git clean -fd` or `git clean -fdx`
     - `git checkout -- .` (unless explicitly instructed to discard specific file changes)
     - `git push --force` or `--force-with-lease`

