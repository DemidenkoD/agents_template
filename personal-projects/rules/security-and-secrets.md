# Rule: Security & Secret Management

- **Trigger:** Configuration, API integrations, environment handling
- **Scope:** Personal private production-grade projects

## Policy
1. **No Hardcoded Secrets:** Never commit API keys, tokens, DB credentials, or private certificates into version control.
2. **Environment Variable Pattern:** Use `pydantic-settings` or `python-dotenv` to load secrets from environment variables.
3. **Template Environment Files:** Always maintain a `.env.example` file showing required environment variable keys with dummy/placeholder values.
4. **Gitignore Protection:** Ensure `.env`, `*.pem`, `*.key`, and credential files are explicitly ignored in `.gitignore`.

