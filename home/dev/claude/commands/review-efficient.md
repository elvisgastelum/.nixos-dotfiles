---
description: Review current work using focused git-summary, lint/type analysis, and review subagents.
allowed-tools: Read, Grep, Glob, Task, Bash
model: sonnet
---

Follow the always-on cost-aware delegation instructions.

Do not edit files.

Use `code-git` to summarize changed files and diff context. Then use `code-review` for focused correctness, regression, security, missing-test, maintainability, and over-engineering review.

Use `code-lint` or `code-types` only if the diff or review findings suggest lint, formatting, import-order, TypeScript, schema, generated-client, DTO, or interface issues.

Return concise findings with file references where available, verification status, remaining risks, and next recommended action.
