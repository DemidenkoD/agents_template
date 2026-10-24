# Rule: MCP Server Usage (opencode)

- **Trigger:** agent needs docs, DB inspection, browser checks, or repo-graph context.
- **Scope:** `opencode.json` `mcp` block is the sole MCP config. No other file configures servers.

## Config shape (`opencode.json` excerpt)

```json
{
  "mcp": {
    "context7":  { "type": "remote", "url": "https://mcp.context7.com/mcp", "enabled": true },
    "postgres":  { "type": "local", "command": ["npx", "mcp-postgres-server", "<connection-string>"], "enabled": true },
    "playwright":{ "type": "local", "command": ["npx", "@playwright/mcp", "--headless", "--isolated"], "enabled": true },
    "graft":     { "type": "local", "command": ["graft", "mcp"], "enabled": true }
  }
}
```

See `general/templates/opencode-mcp-template.json` for the copy-paste version.

## Per-server usage

| Server | For | Call sequence | Notes |
|---|---|---|---|
| `context7` | current library docs | `resolve-library-id` → `query-docs` (max 3 per question) | Prefer over web search for API syntax; pass `language` when known. |
| `postgres` | read-only DB recon | `list_schemas` → `list_tables` → `describe_table` → `query` | Placeholders `$1, $2` + `LIMIT`; never interpolate request input. |
| `playwright` | browser check / demo | `navigate` → `snapshot` → `find` → `click` / `type` → `console` / `network` | Snapshot before acting; never guess selectors. |
| `graft` | repo-graph context | `repo_map` → `find_code` → `find_all` / `trace_calls` | Cheapest-first (below). Graph refreshes on each query. |

## Recon-only rule

- `postgres` and `playwright` MCPs are **read / navigate only**. Schema changes, seed writes, and data fixes go through repo scripts/migrations — never through MCP write-shaped calls.
- Browser-affecting requests must stay compatible with the app's CSRF / auth-fixture middleware (same-origin `/api/*`, fixture login helper).

## Secrets rule

- DB credentials and third-party keys are **local fixtures / env vars only** (e.g. `.env.local`, never committed). Template JSON holds placeholders, not values.
- Never paste tokens, connection strings, or MFA secrets into docs, specs, chat, or the `mcp` block checked into git.

## Graft: cheapest-first + top-N warning

1. `repo_map` (orientation, $0) → 2. `find_code` (ranked answer, top-N) → 3. `file_api`/skeleton (cheap skim) → 4. `trace_calls` (blast radius) → 5. `find_all`/grep (exhaustive).
2. `find_code` returns **top-N ranked hits, not complete coverage**. For "every caller / every occurrence" use `find_all` (indexed files) and fall back to raw `grep -rn` only for unindexed files.
3. After large refactors run `graft build` ($0, deterministic) to refresh the graph.
