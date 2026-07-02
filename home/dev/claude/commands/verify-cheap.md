---
description: Run cost-aware verification through lint, typecheck, tests, and builds.
allowed-tools: Read, Grep, Glob, Task, Bash
model: sonnet
---

Follow the always-on cost-aware delegation instructions.

Do not edit files except by delegating formatting/autofix to `code-formatter` when explicitly needed.

Use the specialized verification flow:

- `code-lint` for lint and formatting checks,
- `code-types` for typecheck and schema/generated-client issues,
- `code-tester` for tests and verification commands,
- `code-artifacts-creator` for builds.

Ask each subagent for max 2-3 line summaries. Return concise verification status, failures, responsible follow-up subagent if any, and next recommended action.
