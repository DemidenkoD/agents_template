---
name: safely-branch-and-test
description: Spawns an isolated branch worker subagent to test experimental code, run scratch scripts in .agents/scripts/, and verify fixes without risking the host project.
---

# Skill: Safely Branch and Test

## Purpose
Enables the Careful Guardian persona to safely test modifications on someone else's codebase or a private repository inside an isolated git branch workspace (`Workspace: "branch"`).

## Procedural Steps

1. **Task Definition:**
   - Define the isolated bug fix or feature task.
2. **Spawn Branch Subagent:**
   - Call `invoke_subagent` with `Workspace: "branch"`:
     - The harness automatically clones or branches the repo in an isolated directory.
     - The subagent tests changes, creates reproduction scripts in `.agents/scripts/`, and runs tests.
3. **Review & Evaluation:**
   - The subagent reports back passing test results and diffs.
   - If tests fail, the subagent's temporary branch is discarded without polluting your main work tree.
4. **Clean Merge & Local Logging:**
   - Once verified, the parent agent applies the minimal targeted diff to the main workspace.
   - Documents the rationale in `.agents/changes/YYYY-MM-DD_<topic>.md`.

