#!/usr/bin/env python3
"""
Production-Ready FastMCP Server Boilerplate for AI Dev Tools Zoomcamp.
Implements:
  1. Typed Tools with Pydantic argument validation and error boundaries.
  2. Dynamic Resources for contextual system/application data.
  3. Reusable Prompt Templates.
  4. Resilient Stdio communication preventing pipeline crashes.

Requirements:
  pip install fastmcp pydantic
Usage:
  python mcp-server/server.py
"""

from typing import Any, Dict, List, Optional
from pydantic import BaseModel, Field
from fastmcp import FastMCP

# Initialize the FastMCP Server
mcp = FastMCP(
    name="AI Dev Tools MCP Server",
    instructions="Provides specialized tools, context resources, and prompt templates for the application.",
)


# ==============================================================================
# 1. Pydantic Models for Robust Input Validation
# ==============================================================================

class SearchQueryInput(BaseModel):
    query: str = Field(
        ...,
        min_length=2,
        max_length=200,
        description="Search terms or keywords to query the knowledge base.",
    )
    max_results: int = Field(
        default=5,
        ge=1,
        le=20,
        description="Maximum number of search results to return.",
    )
    filter_tag: Optional[str] = Field(
        default=None,
        description="Optional category or tag to filter results.",
    )


class CalculationInput(BaseModel):
    operation: str = Field(
        ...,
        pattern="^(add|subtract|multiply|divide)$",
        description="Arithmetic operation to perform.",
    )
    a: float = Field(..., description="First operand.")
    b: float = Field(..., description="Second operand.")


# ==============================================================================
# 2. MCP Tools (@mcp.tool)
# ==============================================================================

@mcp.tool(
    name="search_knowledge_base",
    description="Search the local repository or knowledge base for relevant documents and code snippets.",
)
def search_knowledge_base(params: SearchQueryInput) -> Dict[str, Any]:
    """
    Executes a search query and returns ranked results.
    Error boundaries ensure friendly JSON errors rather than stdio pipe crashes.
    """
    try:
        # Replace with your actual search or database lookup logic
        mock_results = [
            {
                "id": "doc-01",
                "title": f"Result for {params.query}",
                "snippet": f"Sample relevant content matching query: {params.query}",
                "tag": params.filter_tag or "general",
            }
        ]
        return {
            "status": "success",
            "count": len(mock_results),
            "results": mock_results[: params.max_results],
        }
    except Exception as exc:
        return {
            "status": "error",
            "message": f"Search failed: {str(exc)}",
        }


@mcp.tool(
    name="perform_calculation",
    description="Perform safe arithmetic calculations with zero division prevention.",
)
def perform_calculation(params: CalculationInput) -> Dict[str, Any]:
    try:
        if params.operation == "add":
            result = params.a + params.b
        elif params.operation == "subtract":
            result = params.a - params.b
        elif params.operation == "multiply":
            result = params.a * params.b
        elif params.operation == "divide":
            if params.b == 0:
                return {"status": "error", "message": "Cannot divide by zero."}
            result = params.a / params.b
        else:
            return {"status": "error", "message": f"Unknown operation: {params.operation}"}

        return {"status": "success", "result": result}
    except Exception as exc:
        return {"status": "error", "message": str(exc)}


# ==============================================================================
# 3. Dynamic Resources (@mcp.resource)
# ==============================================================================

@mcp.resource("system://health")
def get_system_health() -> str:
    """Returns current system health status as an MCP resource."""
    return '{"status": "healthy", "service": "mcp-server", "uptime": "ok"}'


@mcp.resource("config://app-settings")
def get_app_settings() -> str:
    """Returns runtime configuration and capability flags."""
    return '{"version": "1.0.0", "environment": "development", "features": ["search", "calc"]}'


# ==============================================================================
# 4. Prompt Templates (@mcp.prompt)
# ==============================================================================

@mcp.prompt(name="review_code_diff")
def review_code_diff_prompt(diff_text: str) -> str:
    """Generates a structured code review prompt template for the LLM."""
    return f"""You are a Senior Software Engineer conducting a thorough code review.

Analyze the following git diff for:
1. Logic errors, potential crashes, or edge-case oversights.
2. Security issues or exposed secrets.
3. Code cleanliness and adherence to project conventions.

Git Diff:
```diff
{diff_text}
```

Provide your feedback organized with clear bullet points and actionable suggested fixes.
"""


# ==============================================================================
# 5. Server Entrypoint
# ==============================================================================

if __name__ == "__main__":
    # Runs the MCP server over standard input/output (stdio)
    mcp.run()
