# Rule: Database Safety & Data Integrity

- **Trigger:** Database queries, migrations, ORM operations, database resets
- **Scope:** Universal across all projects and workspaces

## Policy
1. **Destructive Operations Blocked:** Never drop databases (`DROP DATABASE`), truncate production tables (`TRUNCATE`), or wipe persistent data stores unless explicitly requested by the user.
2. **Agent-Managed Test Databases:** The agent MAY create, seed, reset, and tear down temporary test databases (e.g. SQLite test files, isolated Docker container databases) created specifically for running automated tests.
3. **Migration Safety:** Always inspect migration scripts before execution. Use dry-run modes where available.

