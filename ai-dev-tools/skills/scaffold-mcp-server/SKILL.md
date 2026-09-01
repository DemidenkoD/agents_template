---
name: scaffold-mcp-server
description: Scaffolds a Python Model Context Protocol (MCP) server using FastMCP or mcp SDK.
---

# Skill: Scaffold MCP Server

## Purpose
Builds a standardized Model Context Protocol (MCP) server for extending agent capabilities with custom tools and resources.

## Procedural Steps
1. Create server workspace directory.
2. Initialize environment using `uv init` and add `mcp` / `fastmcp` dependencies (`uv add "mcp[cli]"`).
3. Create `server.py` exposing tool functions decorated with `@mcp.tool()`.
4. Provide `mcp_config.json` configuration snippet for agent mounting.
5. Verify tool execution using MCP inspector (`uv run mcp dev server.py`).

