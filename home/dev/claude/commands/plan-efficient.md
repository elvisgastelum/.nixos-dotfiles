---
description: Create a cost-aware implementation plan using focused discovery and docs research subagents.
allowed-tools: Read, Grep, Glob, Task, mcp__context7__*
model: sonnet
---

Follow the always-on cost-aware delegation instructions.

Do not edit files. Do not run git, lint, typecheck, test, build, or formatting commands directly.

Use `code-explore` for codebase discovery when repository context is needed. Use `code-research` for current library/framework/API/CLI/cloud documentation when needed.

Return a detailed implementation plan with:

- files and symbols likely involved,
- relevant conventions and dependencies,
- risks and edge cases,
- subagents used or recommended,
- validation steps.
