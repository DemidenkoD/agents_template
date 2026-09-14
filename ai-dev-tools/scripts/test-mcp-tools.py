#!/usr/bin/env python3
"""
Local MCP Stdio Test Runner for AI Dev Tools Zoomcamp.
Boots an MCP server over stdio, performs protocol handshake, queries tools/list,
and optionally invokes a tool with test arguments.

Usage:
  python test-mcp-tools.py --server "python mcp-server/server.py"
  python test-mcp-tools.py --server "python mcp-server/server.py" --call perform_calculation --args '{"operation": "add", "a": 5, "b": 10}'
"""

import argparse
import json
import subprocess
import sys
import time
from typing import Any, Dict, Optional


class McpStdioClient:
    def __init__(self, command: str):
        self.process = subprocess.Popen(
            command,
            shell=True,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            bufsize=1,
        )
        self.request_id = 0

    def send(self, method: str, params: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        self.request_id += 1
        payload = {
            "jsonrpc": "2.0",
            "id": self.request_id,
            "method": method,
            "params": params or {},
        }
        line = json.dumps(payload) + "\n"
        if not self.process.stdin or not self.process.stdout:
            raise RuntimeError("Subprocess pipes not available.")

        self.process.stdin.write(line)
        self.process.stdin.flush()

        response_line = self.process.stdout.readline()
        if not response_line:
            stderr = self.process.stderr.read() if self.process.stderr else ""
            raise RuntimeError(f"Server exited or returned empty response. Stderr: {stderr}")

        return json.loads(response_line)

    def close(self):
        if self.process.stdin:
            self.process.stdin.close()
        self.process.terminate()
        self.process.wait(timeout=2)


def main():
    parser = argparse.ArgumentParser(description="Test an MCP server over stdio")
    parser.add_argument(
        "--server",
        default="python mcp-server/server.py",
        help="Command to launch the MCP server",
    )
    parser.add_argument(
        "--call",
        help="Name of the tool to invoke",
    )
    parser.add_argument(
        "--args",
        default="{}",
        help="JSON string of tool arguments",
    )
    args = parser.parse_args()

    print(f"🔌 Connecting to MCP server: `{args.server}`...")
    client = McpStdioClient(args.server)

    try:
        # Step 1: Handshake (initialize)
        init_res = client.send(
            "initialize",
            {
                "protocolVersion": "2024-11-05",
                "capabilities": {},
                "clientInfo": {"name": "mcp-test-runner", "version": "1.0"},
            },
        )
        server_info = init_res.get("result", {}).get("serverInfo", {})
        print(f"✅ Handshake successful! Server: {server_info.get('name', 'Unknown')} v{server_info.get('version', '')}")

        # Step 2: List available tools
        tools_res = client.send("tools/list")
        tools = tools_res.get("result", {}).get("tools", [])
        print(f"\n📋 Available Tools ({len(tools)} found):")
        for tool in tools:
            name = tool.get("name")
            desc = tool.get("description", "No description")
            print(f"  • {name}: {desc}")

        # Step 3: Optional tool invocation
        if args.call:
            print(f"\n🚀 Invoking tool `{args.call}` with args: {args.args}")
            call_args = json.loads(args.args)
            call_res = client.send(
                "tools/call",
                {"name": args.call, "arguments": call_args},
            )
            print("\n📬 Result:")
            print(json.dumps(call_res.get("result", call_res), indent=2))

        print("\n🎉 MCP test run complete!")
    except Exception as exc:
        print(f"\n❌ MCP Error: {exc}", file=sys.stderr)
        sys.exit(1)
    finally:
        client.close()


if __name__ == "__main__":
    main()
