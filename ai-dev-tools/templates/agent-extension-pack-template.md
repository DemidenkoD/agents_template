# Agent Extension Pack Documentation

This document explains the agent capabilities, hooks, and MCP servers bundled with this application.

## 1. Extension Overview
Explain how the agent extension pack automates developer operations, audits, or interacts with the platform.

## 2. Included Components

### A. Capabilities & Skills (`agent-capabilities/`)
- **Skill 1:** Description, triggers, and execution steps.
- **Skill 2:** Description, triggers, and execution steps.

### B. Agent Lifecycle Hooks (`agent-hooks/`)
- **Pre-execution hooks:** Validation checks before dangerous operations.
- **Post-execution hooks:** Linting, formatting, or test assertions.

### C. Model Context Protocol (MCP) Server (`mcp-server/`)
- **Transport:** stdio or SSE.
- **Tools Exposed:**
  - `tool_one`: Parameter schema and function.
  - `tool_two`: Parameter schema and function.
- **How to Connect:** Mounting via `mcp_config.json` or CLI.

## 3. Verification & Testing
How peer reviewers can test and verify the agent extensions locally.

