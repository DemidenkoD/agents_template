---
name: scaffold-homework-todo
description: Parses Zoomcamp homework files or URLs and generates an interactive todo.md checklist with step-by-step invocation steps.
---

# Skill: Scaffold Homework TODO

## Purpose
Parses a DataTalks.Club Zoomcamp homework specification (URL or local markdown file) and generates a structured, step-by-step interactive `todo.md` checklist.

## Procedural Steps
1. **Fetch / Read Homework Spec:**
   - Retrieve content from local file path or remote GitHub URL (e.g. `homework.md`).
2. **Parse Structure:**
   - Extract assignment overview, setup requirements, questions (Q1..Qn), expected outputs, and submission criteria.
3. **Generate `todo.md` Layout:**
   ```markdown
   # 📝 Homework Checklist: [Homework Title]

   - [ ] **Phase 1: Environment & Setup**
     - [ ] Step 1.1: Verify packages and environment
     - [ ] Step 1.2: Download datasets / initialize repo

   - [ ] **Question 1: [Question Title]**
     - [ ] Step 1: Draft initial prompt / solution approach
     - [ ] Step 2: Execute code / query logic
     - [ ] Step 3: Record exact answer for submission

   - [ ] **Question 2: [Question Title]**
     - [ ] Step 1: ...
   ```
4. **Execution & Invocation:**
   - As the user or agent executes each step, mark `[x]` on completed items in `todo.md`.

