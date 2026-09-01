# Rule: Model Context Protocol (MCP) Security & Safety

- **Trigger:** Developing Model Context Protocol (MCP) servers or sidecars
- **Scope:** MCP tool integrations

## Guidelines
1. **Zero Hardcoded Credentials:** Never store API tokens, secrets, or passwords inside source code or configuration files. Use environment variables.
2. **Input Sanitization:** Validate and sanitize all user and model parameters before constructing shell commands or API calls.
3. **Least Privilege:** Expose only the specific functions and file paths necessary for the tool's core functionality.

