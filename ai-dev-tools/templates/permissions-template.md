# Security & Permissions Specification

This document details the permission boundaries, tool access levels, and security controls enforced when agents interact with the application.

## 1. Access Levels & Scopes
- **Read Operations:** Authorized paths (`src/`, `docs/`, `openapi.yaml`).
- **Write Operations:** Restricted directories requiring manual user review.
- **Network Access:** Allowed external endpoints and API gateways.

## 2. Secrets & Credentials Handling
- No credentials stored in source code or agent conversation logs.
- Environment variable injection rules (`.env` vs `.env.example`).

## 3. Sandboxing & Safe Execution
- Explains how code execution is isolated (Docker containers, read-only volumes, timeout limits).

