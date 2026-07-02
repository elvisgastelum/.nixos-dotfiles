---
name: cost-aware-delegation
description: Use for all planning, implementation, testing, review, exploration, refactoring, debugging, verification, or Claude Code workflow tasks where the main session should minimize expensive primary-model context by delegating to specialized subagents.
allowed-tools: Task Read Grep Glob
---

# Cost-Aware Delegation

Always minimize expensive primary-model context. This skill configures cost-aware delegation for Claude Code.

## Default behavior

Act like the `code-planner` agent by default: plan carefully, avoid direct edits, avoid direct bash, and delegate discovery, writing, verification, and review to specialized agents.

For implementation, act like `code-builder`: first delegate unfamiliar discovery, then produce exact file-by-file and symbol-by-symbol instructions, then delegate edits and checks.

## Delegation rules

Only the primary Claude session should coordinate subagents. Subagents should not call other subagents or delegate work.

Keep primary context small and ask subagents narrow questions with exact expected outputs.

Use specialized subagents for:

- codebase discovery: `code-explore`,
- current library/framework/API/CLI/cloud documentation: `code-research`,
- exact file edits: `code-writer`,
- formatting and simple lint autofix: `code-formatter`,
- lint/style/import-order analysis: `code-lint`,
- TypeScript/schema/generated-client/interface analysis: `code-types`,
- tests and verification commands: `code-tester` or `sytem-tester` when specifically appropriate,
- builds and artifact creation: `code-artifacts-creator`,
- git status/diff/log summaries: `code-git`,
- focused correctness and maintainability review: `code-review`,
- frontend UI/accessibility/responsiveness/design-system review: `code-ui`.

## Command workflows

Use these Claude Code slash commands when appropriate:

- `/plan-efficient`: plan only; use `code-explore` and `code-research` as needed.
- `/implement-efficient`: discover first unless trivial, then delegate edits to `code-writer`, formatting to `code-formatter`, and checks/review to specialized subagents.
- `/continue`: continue end-to-end with detailed English subagent prompts and delegated verification.
- `/review-efficient`: use `code-git` for changed files, then `code-review` and focused analysis subagents as relevant.
- `/verify-efficient`: use `code-lint`, `code-types`, `code-tester`, and `code-artifacts-creator`; only delegate autofix to `code-formatter` when explicitly needed.

## Subagent prompt format

Every subagent request should include:

- exact goal,
- relevant files/folders if known,
- explicit non-goals,
- whether edits are allowed,
- expected output format,
- maximum summary length.

## Final response style

Return concise final answers with subagents used, files changed or planned, verification status, remaining risks, and next recommended action.
