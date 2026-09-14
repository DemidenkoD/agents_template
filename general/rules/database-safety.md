# Rule: Database Safety & Data Integrity

- **Trigger:** Database queries, migrations, ORM operations, database resets
- **Scope:** Universal across all projects and workspaces

## Policy
1. **Destructive Operations Blocked:** Never drop databases (`DROP DATABASE`), truncate production tables (`TRUNCATE`), or wipe persistent data stores unless explicitly requested by the user.
2. **Decouple Deployments from Resets:** Routine code deployments and schema migrations must NEVER reset, flush, or wipe database tables or Redis caches. Data wipes and fixture seeding belong exclusively to dedicated, confirmation-protected maintenance scripts (e.g. `confirm: RESET`).
3. **Pre-Migration Safety Snapshots:** Always execute an automated database snapshot/backup prior to running schema migrations or structural updates on shared or live test servers (e.g. `pg-backup.sh`).
4. **Additive Migrations Only:** Production schema migrations must be strictly non-destructive (new nullable columns, new tables, non-blocking indexes). Never apply a destructive drop without a staged migration saga.
5. **Agent-Managed Test Databases:** The agent MAY create, seed, reset, and tear down temporary test databases (e.g. SQLite test files, isolated Docker container databases) created specifically for running automated tests.
6. **Dry-Run Inspection:** Always inspect generated migration SQL before execution and use dry-run commands where available.

