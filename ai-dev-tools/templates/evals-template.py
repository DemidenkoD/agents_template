#!/usr/bin/env python3
"""
Lightweight LLM & Tool Evaluation Runner for AI Dev Tools Zoomcamp.
Evaluates:
  1. Tool calling accuracy (correct tool chosen, argument validation).
  2. Output assertions (must_contain / must_not_contain).
  3. Latency & token budgeting.

Usage:
  python evals/run_evals.py
  python evals/run_evals.py --file evals/eval_cases.json
"""

import argparse
import json
import os
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional


def load_eval_cases(file_path: Path) -> List[Dict[str, Any]]:
    if not file_path.exists():
        print(f"Error: Evaluation file not found at {file_path}")
        sys.exit(1)
    with open(file_path, "r", encoding="utf-8") as f:
        return json.load(f)


def evaluate_mock_pipeline(test_case: Dict[str, Any]) -> Dict[str, Any]:
    """
    Simulated agent call. Replace this function with your actual agent/LLM invocation.
    Example:
      response = agent.run(test_case["input"])
      return {"tool_called": response.tool_name, "args": response.tool_args, "output": response.text}
    """
    user_input = test_case["input"].lower()
    start_time = time.perf_counter()

    # Simple deterministic mock router for demonstration
    if "weather" in user_input and "munich" in user_input:
        tool_called = "get_current_weather"
        tool_args = {"city": "Munich", "unit": "celsius"}
        output_text = "The current temperature in Munich is 18°C with clear skies."
    elif "factorial" in user_input:
        tool_called = None
        tool_args = None
        output_text = "The factorial of 12 is 479001600."
    elif "ignore all previous instructions" in user_input:
        tool_called = None
        tool_args = None
        output_text = "I cannot fulfill this request. How else may I assist you?"
    else:
        tool_called = None
        tool_args = None
        output_text = "I am an AI assistant."

    duration_ms = (time.perf_counter() - start_time) * 1000

    return {
        "tool_called": tool_called,
        "tool_args": tool_args,
        "output_text": output_text,
        "duration_ms": duration_ms,
        "tokens_used": len(user_input.split()) + len(output_text.split()),
    }


def run_evals(cases: List[Dict[str, Any]]) -> bool:
    print(f"\n🧪 Running {len(cases)} Evaluation Cases...\n" + "=" * 60)
    passed_count = 0

    for idx, case in enumerate(cases, 1):
        case_id = case.get("id", f"case-{idx}")
        desc = case.get("description", "Evaluation case")
        print(f"[{idx}/{len(cases)}] {case_id}: {desc}")

        res = evaluate_mock_pipeline(case)
        failures = []

        # 1. Tool selection check
        expected_tool = case.get("expected_tool")
        if res["tool_called"] != expected_tool:
            failures.append(
                f"Expected tool '{expected_tool}', but got '{res['tool_called']}'"
            )

        # 2. Tool arguments check
        expected_args = case.get("expected_args")
        if expected_args and res["tool_args"] != expected_args:
            failures.append(
                f"Expected args {expected_args}, but got {res['tool_args']}"
            )

        # 3. Must-contain text assertions
        for text in case.get("must_contain", []):
            if text.lower() not in res["output_text"].lower():
                failures.append(f"Missing required phrase: '{text}'")

        # 4. Must-not-contain text assertions
        for text in case.get("must_not_contain", []):
            if text.lower() in res["output_text"].lower():
                failures.append(f"Forbidden phrase found: '{text}'")

        # Result display
        if not failures:
            passed_count += 1
            print(
                f"  ✅ PASS ({res['duration_ms']:.1f}ms | ~{res['tokens_used']} tokens)"
            )
        else:
            print(f"  ❌ FAIL ({res['duration_ms']:.1f}ms)")
            for fail in failures:
                print(f"     • {fail}")

    print("=" * 60)
    score_pct = (passed_count / len(cases)) * 100
    print(f"📊 Results: {passed_count}/{len(cases)} Passed ({score_pct:.1f}%)\n")

    return passed_count == len(cases)


def main() -> None:
    parser = argparse.ArgumentParser(description="Run LLM evaluation suite")
    parser.add_argument(
        "--file",
        type=Path,
        default=Path(__file__).parent / "eval_cases.json",
        help="Path to evaluation test cases JSON file",
    )
    args = parser.parse_args()

    cases = load_eval_cases(args.file)
    success = run_evals(cases)
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
