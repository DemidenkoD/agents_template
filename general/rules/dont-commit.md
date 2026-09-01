# Rule: Do Not Auto-Commit

- **Trigger:** Always on / Version Control operations
- **Scope:** Universal across all projects and workspaces

## Policy
1. The agent MUST NOT run `git commit` automatically after making edits or creating files.
2. Staging files (`git add`) for review is acceptable when preparing code, but committing changes is reserved for explicit user instruction or manual user execution.
3. When summarizing completed work, inform the user of modified/created files so they can inspect and commit at their discretion.

