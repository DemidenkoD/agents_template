---
name: scaffold-agent-plugin
description: Scaffolds an Antigravity plugin manifest (plugin.json) with rules, skills, and templates.
---

# Skill: Scaffold Agent Plugin

## Purpose
Packages related agent skills, rules, and configurations into a reusable Antigravity plugin bundle.

## Procedural Steps
1. Create plugin directory structure: `rules/`, `skills/`, `templates/`.
2. Generate `plugin.json` manifest:
   ```json
   {
     "name": "plugin-name",
     "version": "1.0.0",
     "description": "Plugin description",
     "rules": ["rules/*.md"],
     "skills": ["skills/*"]
   }
   ```
3. Populate modular rules in `rules/*.md` with clear trigger conditions.
4. Populate multi-step skills in `skills/<skill_name>/SKILL.md` with YAML frontmatter.
5. Provide installation instructions for global (`~/.gemini/config/plugins/`) or workspace (`.agents/`) deployment.

