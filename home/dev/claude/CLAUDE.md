# Claude Code Global Instructions

This file configures Claude Code global instructions.

## Default behavior

Act like the `code-planner` agent by default:

- Use the main model only for orchestration, planning, judgment, and final decisions.
- Do not perform broad repository exploration yourself when a focused subagent can do it.
- Do not run git, lint, typecheck, test, build, or formatting commands directly when a specialized subagent or slash command workflow is more appropriate.
- Keep primary context small and request concise summaries from subagents.
- For implementation work, act like `CodeBuilder`: inspect only what is needed, produce exact file-by-file instructions, and delegate edits to the appropriate editing agent when possible.

## Context7 documentation rule

Use Context7 MCP to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service -- even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use it even when you think you know the answer because training data may not reflect recent changes. Prefer Context7 over web search for library docs.

Do not use Context7 for refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

### Context7 steps

1. Always start with library ID resolution using the library name and the user's question, unless the user provides an exact library ID in `/org/project` format.
2. Pick the best match by exact name match, description relevance, code snippet count, source reputation, and benchmark score.
3. Query docs with the selected library ID and the user's full question, not single keywords.
4. Answer using the fetched docs.

## Cost-aware delegation

Use specialized Claude Code subagents for focused work:

- codebase discovery: `code-explore`
- current documentation research: `code-research`
- exact file edits: `code-writer`
- formatting and simple lint autofix: `code-formatter`
- lint/style/import-order analysis: `code-lint`
- TypeScript/schema/generated-client/interface analysis: `code-types`
- tests and verification commands: `code-tester` or `sytem-tester` when specifically appropriate
- builds and artifact creation: `code-artifacts-creator`
- git status/diff/log summaries: `code-git`
- focused correctness and maintainability review: `code-review`
- frontend UI/accessibility/responsiveness/design-system review: `code-ui`

Only the primary Claude session should coordinate subagents. Subagents should not delegate to other subagents.

When calling a subagent, include:

- exact goal,
- files/folders to inspect or change,
- explicit non-goals,
- whether edits are allowed,
- expected output format,
- maximum summary length.

## Slash command workflows

Use these Claude Code workflows when appropriate:

- `/plan-efficient`: planning only with focused discovery and docs research.
- `/implement-efficient`: implementation through discovery, exact edits, formatting, checks, and review.
- `/continue`: continue an implementation end-to-end with detailed English subagent prompts.
- `/review-efficient`: summarize changed files and run focused review.
- `/verify-efficient`: delegated lint, typecheck, tests, and build verification.

## Final response style

Return concise final answers with:

- what was planned or changed,
- which subagents were used,
- files changed or planned,
- verification status,
- remaining risks,
- next recommended action.
