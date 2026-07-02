---
name: cost-aware-delegation
description: "Use for all planning, implementation, testing, review, exploration, refactoring, debugging, verification, or opencode workflow tasks where agents should minimize expensive primary-model context by delegating to specialized subagents."
---

# Cost-Aware Delegation

Always minimize expensive primary-model context. Treat `opencode.json` as the source of truth for agent names, models, permissions, and command workflows.

## Active primary agents

- `CodePlanner` is the default primary agent and is planning-only. It must never edit files or run bash.
- `CodeBuilder` is an implementation orchestrator. It must not edit files directly; it delegates implementation to `CodeWriter`.
- `CodeGeneral` handles simple fallback work. For codebase work, it still delegates discovery and edits.

The built-in `plan`, `build`, `general`, and `explore` agents are disabled by config.

## Delegation rules

Only primary agents may call subagents. Subagents must never call other subagents or use the Task tool; they must return results to the primary agent.

Primary agents should keep their own context small and ask subagents narrow questions with exact expected outputs.

Use specialized subagents for:

- codebase discovery: `CodeExplore`,
- current library/framework/API/CLI/cloud documentation: `CodeResearch`,
- exact file edits: `CodeWriter`,
- formatting and simple lint autofix: `CodeFormatter`,
- lint/style/import-order analysis: `CodeLint`,
- TypeScript/schema/generated-client/interface analysis: `CodeTypes`,
- tests and verification commands: `CodeTester` or `SytemTester` when specifically appropriate,
- builds and artifact creation: `CodeArtifactsCreator`,
- git status/diff/log summaries: `CodeGit`,
- focused correctness and maintainability review: `CodeReview`,
- frontend UI/accessibility/responsiveness/design-system review: `CodeUI`.

## Command workflows

Follow the always-on workflow from `instructions/cost-aware-delegation.md`. The configured commands are:

- `plan-cheap`: plan only; use `CodeExplore` and `CodeResearch` as needed.
- `implement-cheap`: discover first unless trivial, then delegate edits to `CodeWriter`, formatting to `CodeFormatter`, and checks/review to specialized subagents.
- `continue`: continue end-to-end with detailed English subagent prompts and delegated verification.
- `review-cheap`: use `CodeGit` for changed files, then `CodeReview` and focused analysis subagents as relevant.
- `verify-cheap`: use `CodeLint`, `CodeTypes`, `CodeTester`, and `CodeArtifactsCreator`; only delegate autofix to `CodeFormatter` when explicitly needed.

## Permission expectations

Primary agents must not edit directly or run bash. Edit work belongs to `CodeWriter` or `CodeFormatter`. Commands belong to verification/build/git/lint/type/test subagents according to their configured permissions.

After changing opencode config, instructions, skills, agents, plugins, MCP servers, or permission rules, remind the user to quit and restart opencode because config-time files are not hot-reloaded.
