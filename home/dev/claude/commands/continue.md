---
description: Continue the current implementation end-to-end using the cost-aware delegation-first workflow.
allowed-tools: Read, Grep, Glob, Task, Edit, Write, Bash, mcp__context7__*
model: sonnet
---

Continue the current implementation flow end-to-end using the always-on cost-aware delegation workflow. All subagent prompts and outputs must be in English.

Act as an orchestrator: keep your own context small, avoid direct edits when a focused editing subagent can perform them, and delegate as much work as possible to specialized subagents.

First determine the current implementation state from the conversation. If needed, use `code-git` for changed-file status and `code-explore` for missing codebase context.

Do not run git, lint, typecheck, test, build, or formatting commands directly when a specialized subagent can run them. Delegate those to the appropriate subagents.

For every subagent call, provide deeply detailed and explicit instructions because subagents may be smaller models. Include:

- exact goal,
- files/folders to inspect or change,
- explicit non-goals,
- whether edits are allowed,
- expected output format,
- maximum summary length.

Use:

- `code-explore` for discovery,
- `code-research` for current docs,
- `code-writer` for exact file-by-file edits,
- `code-formatter` for formatting/autofix,
- `code-lint` for lint analysis,
- `code-types` for TypeScript/schema/generated-client issues,
- `code-tester` for tests,
- `code-artifacts-creator` for builds,
- `code-review` for focused review,
- `code-ui` for frontend UI concerns,
- `code-git` for repo-state summaries.

If more information is needed, call additional targeted subagents instead of expanding primary context. After edits, run the appropriate delegated verification flow and review.

Return a concise final status with:

- subagents used,
- files changed or planned,
- verification results,
- remaining risks,
- next recommended action.
