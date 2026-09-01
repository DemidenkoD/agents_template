# Rule: Agent Tool & Skill Design Guidelines

- **Trigger:** Building or customizing AI agent tools, skills, and prompt specifications
- **Scope:** AI Dev Tools projects

## Guidelines
1. **Schema Precision:** Define explicit parameters, types, descriptions, and enum options for all agent tool schemas.
2. **Context Isolation:** Keep system prompts clean and concise. Use progressive disclosure to load heavy documentation or workflows only when activated.
3. **Idempotency:** Agent tools should be designed to be safely retryable without causing unintended state corruption.
4. **Structured Error Feedback:** Return clear, actionable error messages with log traces rather than cryptic codes or swallowed exceptions.

