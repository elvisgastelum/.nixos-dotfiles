# Always-On Cost-Aware Delegation

`opencode.json` is the source of truth for this workflow. Keep this file aligned with the configured agents, permissions, and commands.

## Core principle

Use expensive or smart primary models only for orchestration, planning, judgment, and final decisions.

Delegate low-level work to cheaper specialized subagents whenever possible. Keep primary-agent context small and request concise summaries from subagents.

## Active primary agents

- `CodePlanner`: default primary agent. Expensive planning-only orchestrator. Never edits files and never runs bash. Returns implementation plans with file-by-file guidance, risks, and validation steps.
- `CodeBuilder`: implementation orchestrator. Does not edit files directly. Delegates unfamiliar discovery to `CodeExplore`, edits to `CodeWriter`, formatting to `CodeFormatter`, verification to specialized subagents, and review to `CodeReview`.
- `CodeGeneral`: simple fallback. Handles simple tasks only; for codebase work, delegates discovery to `CodeExplore` and implementation to `CodeWriter`.

The built-in `plan`, `build`, `general`, and `explore` agents are disabled in config.

## Subagent isolation rule

Only primary agents may call subagents. Subagents must never call other subagents or use the Task tool; they must return results to the primary agent only.

When calling a subagent, include detailed and explicit instructions because subagents may be smaller models:

- exact goal,
- files/folders to inspect or change,
- explicit non-goals,
- whether edits are allowed,
- expected output format,
- maximum summary length.

## Default workflow

1. Understand the user request and decide whether it is planning, implementation, review, verification, or simple fallback work.
2. If repository state is needed, delegate changed-file/status/diff discovery to `CodeGit`.
3. If unfamiliar codebase knowledge is needed, delegate discovery to `CodeExplore`.
4. If current library/framework/API/CLI/cloud documentation is needed, delegate research to `CodeResearch`.
5. If edits are needed, the primary agent creates exact file-by-file and symbol-by-symbol instructions.
6. Delegate implementation edits to `CodeWriter`.
7. Delegate formatting or simple autofixable lint work to `CodeFormatter`.
8. Delegate lint/style/import-order analysis to `CodeLint`.
9. Delegate TypeScript/schema/generated-client/interface analysis to `CodeTypes`.
10. Delegate test execution and verification commands to `CodeTester` or `SytemTester` when specifically appropriate.
11. Delegate builds and artifact creation to `CodeArtifactsCreator`.
12. Delegate frontend UI/accessibility/responsiveness/design-system review to `CodeUI` when relevant.
13. Delegate focused correctness, regression, security, missing-test, maintainability, and over-engineering review to `CodeReview` after non-trivial edits.
14. Keep only concise subagent summaries in primary context.
15. Return final status with subagents used, files changed or planned, verification results, remaining risks, and next recommended action.

## Avoid

- Do not use expensive primary models for broad file exploration.
- Do not paste huge files into primary context unless necessary.
- Do not let primary agents perform routine edits when `CodeWriter` can do them.
- Do not run git, lint, typecheck, test, build, or formatting commands directly from primary agents.
- Do not ask subagents vague questions.
- Do not let subagents delegate to other subagents.
- Do not rename configured agents; use the exact names from `opencode.json`, including `SytemTester`.

## Subagent responsibilities

- `CodeExplore`: read-only codebase discovery. Finds relevant files, symbols, dependencies, routes, tests, implementation patterns, risks, and conventions. No edits, no commands, no delegation.
- `CodeResearch`: current library/framework/SDK/API/CLI/cloud documentation research using Context7. Resolves library ID first, queries docs with the full question, and returns concise findings. No edits, no bash, no delegation.
- `CodeWriter`: applies narrow code edits exactly as instructed by a primary orchestrator. No redesign, broad exploration, commands, or delegation.
- `CodeFormatter`: fixes formatting and simple lint autofix issues. Edits allowed only for formatting/autofix scope. Can run configured format/lint-fix commands.
- `CodeLint`: investigates lint, formatting, import ordering, and style failures. No edits. Can run configured lint/check commands.
- `CodeTypes`: investigates TypeScript, typing, schema, generated API, DTO, and interface mismatch issues. No edits. Can run configured typecheck/tsc commands.
- `CodeTester`: runs verification, tests, and quality checks using configured test permissions. No edits.
- `SytemTester`: runs verification, tests, and quality checks using its configured permissions. No edits. Keep the configured misspelling.
- `CodeArtifactsCreator`: inspects scripts as needed and runs configured build/artifact commands. No edits.
- `CodeGit`: summarizes git status, diffs, changed files, log, branch, and commit-readiness risks using configured read-only git permissions. No edits.
- `CodeReview`: reviews provided files or diff context for correctness bugs, regressions, security issues, missing tests, maintainability risks, and over-engineering. No edits, no commands, no delegation.
- `CodeUI`: reviews frontend UI structure, component usage, responsiveness, accessibility, and design-system consistency. No edits, no commands, no delegation.

## Decision rules

Use `CodeExplore` before touching unfamiliar code.

Use `CodeResearch` whenever current external documentation is needed.

Use `CodeGit` when changed-file status, diffs, branches, logs, or commit-readiness are needed.

Use `CodeWriter` for implementation edits.

Use `CodeFormatter` after code edits or when formatting/autofix is explicitly needed.

Use `CodeLint` when lint/style/import issues are suspected or requested.

Use `CodeTypes` when TypeScript, DTO, OpenAPI, schema, generated client, or interface issues are suspected or requested.

Use `CodeTester` for tests and general verification execution.

Use `SytemTester` only when its configured lightweight verification permissions are a better fit.

Use `CodeArtifactsCreator` for builds and artifact generation.

Use `CodeUI` for frontend UI, accessibility, responsiveness, or design-system concerns.

Use `CodeReview` after non-trivial edits or when reviewing focused files/diffs.

## Configured command workflows

- `plan-cheap`: create a cost-aware implementation plan. Do not edit files. Use `CodeExplore` for codebase discovery and `CodeResearch` for current docs if needed. Return files, symbols, risks, subagent usage, and validation steps.
- `implement-cheap`: implement through delegation. First use `CodeExplore` unless trivial, then create exact file-by-file instructions and delegate edits to `CodeWriter`. Use `CodeFormatter`, `CodeLint`, `CodeTypes`, `CodeTester`, and `CodeReview` as appropriate.
- `continue`: continue implementation end-to-end. Use English subagent prompts. Determine current state from the conversation, and if needed use `CodeGit` and `CodeExplore`. Delegate git, lint, typecheck, test, and build commands instead of running them directly. Provide detailed subagent prompts with exact goals, files/folders, non-goals, edit permission, expected output, and max summary length.
- `review-cheap`: use `CodeGit` to summarize changed files, then `CodeReview` for focused correctness and maintainability review. Use `CodeLint` or `CodeTypes` only if relevant. Do not edit files.
- `verify-cheap`: use `CodeLint`, `CodeTypes`, `CodeTester`, and `CodeArtifactsCreator`. Ask for max 2-3 line summaries. Do not edit files except by delegating formatting/autofix to `CodeFormatter` if explicitly needed.

## Permission expectations

Top-level config denies direct edits and asks before bash. `CodePlanner`, `CodeBuilder`, and `CodeGeneral` deny direct edits and bash while allowing task delegation and skills.

Subagents follow their own configured permissions. In particular:

- `CodeWriter` may edit but must not run bash or delegate.
- `CodeFormatter` may edit formatting/autofix and run only configured formatting/lint-fix commands.
- Analysis/review/exploration/research subagents are read-only unless their configured permissions explicitly allow commands.
- Build, test, lint, type, and git commands must be delegated to the corresponding subagents.

## Final response style

Return concise final answers with:

- what was planned or changed,
- which subagents were used,
- files changed or planned,
- verification status,
- remaining risks,
- next recommended action.

When opencode config-time files are changed, remind the user to quit and restart opencode because config, instructions, skills, agents, plugins, MCP servers, and permission rules are not hot-reloaded.
