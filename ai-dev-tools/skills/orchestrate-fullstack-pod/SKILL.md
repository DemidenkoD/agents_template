---
name: orchestrate-fullstack-pod
description: Orchestrates a concurrent multi-agent team (Frontend Developer, Backend Developer, QA/Security Auditor) to autonomously implement an end-to-end full-stack feature.
---

# Skill: Orchestrate Full-Stack Pod

## Purpose
Enables the Autonomous Tech Lead to parallelize full-stack development by spawning specialized subagents in isolated workspaces, verifying their work, and merging their outputs into the main repository.

## Subagent Roster

| Agent Role | Subagent Name / Type | Model Tier | Workspace Mode | Primary Responsibility |
| :--- | :--- | :--- | :--- | :--- |
| **Frontend Developer** | `frontend_developer` | `inherit` | `branch` | Implements React/Vite UI components in `frontend/` matching `openapi.yaml`. |
| **Backend Developer** | `backend_developer` | `inherit` | `branch` | Implements API endpoints, controllers, and DB queries in `backend/`. |
| **QA / Security Auditor** | `qa_security_auditor` | `flash` | `inherit` | Concurrently writes integration tests and audits permissions. |

## Procedural Steps

1. **Architecture & Contract Baseline:**
   - Parent agent creates or verifies `openapi.yaml` and `product-spec.md`.
2. **Concurrent Invocation:**
   - Call `invoke_subagent` with multiple entries:
     - Entry 1: Frontend Developer (Workspace: `branch`).
     - Entry 2: Backend Developer (Workspace: `branch`).
     - Entry 3: QA Auditor (Workspace: `inherit`).
3. **Continuous Coordination:**
   - Use `send_message` to pass API schemas or updates between agents as needed.
4. **Verification & Integration:**
   - Run integration tests (`docker-compose up` or `npm test`).
   - Merge verified branch outputs into project tree.
   - Update `todo.md` with completed milestone.

