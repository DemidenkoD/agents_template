# Rule: Production Environment Hygiene & Dev Feature Gating

- **Trigger:** Adding development tools, persona switchers, debug inspectors, autofill helpers, or environment configurations
- **Scope:** Full-stack web applications, APIs, frontends, and cloud services

## The Principle
Development conveniences (one-click logins, test persona switchers, raw payload inspectors, bypass tokens) accelerate local and testing workflows, but pose severe security risks if leaked to production. These features must be strictly gated by both environment configuration and authenticated user authorization.

---

## 1. Runtime Configuration Architecture

1. **Strict Public vs Private Config Separation:**
   - **Public Runtime Config (`runtimeConfig.public` / client bundle):** Exposes only non-sensitive boolean feature flags (e.g. `devLogin`, `allowDevPersonas`). NEVER put database URLs, tokens, or encryption secrets into client-accessible config.
   - **Private Runtime Config (Server runtime):** Secret tokens, HMAC keys, database connection strings, and encryption keys must be private to the server process and injected via environment variables at container runtime.
2. **Zero Hardcoded Secrets in Images:**
   - Container images must NEVER bake in production credentials, fallback secrets, or development seed files.
   - Images must run deterministically from environment variables passed at runtime (`docker compose --env-file`).

---

## 2. Dev Persona & Tool Gating Rules

1. **Clean Public Auth Screens:**
   - Public authentication screens (`/login`, `/signup`) in test, staging, and production MUST be clean.
   - One-click quick login pills (`devLogin`) are permitted ONLY in local development (`NODE_ENV=development`).
2. **In-App Dev Persona Switcher Gating:**
   - An in-app persona switcher (e.g. in the application header) allows developers and QA testers to switch between simulated roles (`Admin`, `Investigator`, `Monitor`, `Sponsor`).
   - The switcher MUST only render when **ALL** of the following conditions are satisfied:
     1. **Environment Gate:** `allowDevPersonas === true` (explicitly enabled in test/staging; strictly `false` or absent in production).
     2. **Authentication Gate:** An active, authenticated session exists (`user !== null`).
     3. **Role/Identity Gate:** The logged-in user is an authorized administrator (`sudo_admin`) or an explicitly registered development seed account (`@project.local`).
   - Ordinary non-dev users on test environments and ALL users in production must NEVER see or access the switcher.
3. **API-Level Enforcement:**
   - UI gating alone is NEVER authorization. The backend API must independently enforce that development persona identities and credentials cannot authenticate or receive tokens when `ALLOW_DEV_PERSONAS !== 'true'` in production.
