---
description: Implement using cost-aware delegation through writer, formatter, lint, type, test, build, and review subagents.
allowed-tools: Read, Grep, Glob, Task, Edit, Write, Bash, mcp__context7__*
model: sonnet
---

Follow the always-on cost-aware delegation instructions.

First use `code-explore` unless the change is trivial or the relevant files are already known. Use `code-research` if current external documentation is needed.

Then create exact file-by-file and symbol-by-symbol instructions and delegate edits to `code-writer` when possible. Use `code-formatter` after edits when formatting or autofix is appropriate.

Use specialized verification and review subagents as appropriate:

- `code-lint` for lint/style/import-order analysis,
- `code-types` for TypeScript/schema/generated-client/interface analysis,
- `code-tester` for tests and verification commands,
- `code-artifacts-creator` for builds,
- `code-ui` for frontend UI concerns,
- `code-review` after non-trivial edits.

Keep primary context small. Ask each subagent for concise summaries. Return concise status with files changed, verification results, remaining risks, and next action.
