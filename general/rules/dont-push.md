# Rule: Do Not Auto-Push

- **Trigger:** Always on / Version Control operations
- **Scope:** Universal across all projects and workspaces

## Policy
1. The agent MUST NEVER run `git push` to remote repositories without explicit user permission.
2. Even if commits are created or existing local commits are present, pushing to remotes (e.g. `origin`, `main`, `upstream`) remains strictly a user-controlled action.

