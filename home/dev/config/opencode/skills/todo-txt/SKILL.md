---
name: todo-txt
description: Use when the user mentions todo.txt, Nextcloud/Tasks, plain-text todos, picking a task, continuing task progress, or updating progress in todo.txt files.
---

# Todo.txt Task Progress

Use this skill when the user asks to read, understand, continue, pick from, or update progress in `todo.txt` files.

Common trigger example:

```text
As a developer i need help at getting this tasks done, read the ~/Nextcloud/Tasks/tuxedo/todos/development/todo.txt file and help me to pick one tasks and start getting done the things
```

## Goal

Help the user turn a plain `todo.txt` task list into actionable work:

- Find the relevant `todo.txt` file.
- Parse task status, priority, dates, projects, contexts, and metadata.
- Summarize the current progress.
- Recommend one useful task to work on next.
- Execute the chosen task when it maps to the current workspace.
- Update the `todo.txt` file only after real progress is made.

## Finding Todo Files

If the user gives an explicit path, use it first. Support opencode-style references such as:

- `~/Nextcloud/Tasks/tuxedo/todos/development/todo.txt`
- `/absolute/path/to/todo.txt`
- `./relative/path/to/todo.txt`

If no path is given, search likely locations in this order:

- `~/Nextcloud/Tasks/**/todo.txt`
- `~/Nextcloud/Tasks/**/*todo*.txt`
- Workspace `**/todo.txt`
- Workspace `**/*todo*.txt`

Prefer exact `todo.txt` matches over similarly named files. If multiple plausible files exist and the intended file is ambiguous, ask one concise question with the best choices.

## Parsing Rules

Use the standard todo.txt conventions while preserving the user's existing formatting.

Recognize these fields:

- Completed task: starts with `x `.
- Completion date: first date after `x`, usually `x YYYY-MM-DD`.
- Priority: leading uppercase letter in parentheses, such as `(A)` or `(B)`.
- Creation date: first non-completion `YYYY-MM-DD` near the start of the task.
- Project tag: `+project`, such as `+dotfiles`.
- Context tag: `@context`, such as `@home`.
- Metadata: `key:value`, such as `due:2026-06-05`.

Treat tasks without leading `x ` as open. Preserve malformed or non-standard lines; do not rewrite them just to normalize style.

## Progress Summary

After reading the file, summarize the list before selecting work:

- Total open and completed tasks.
- Open tasks grouped by priority when priorities exist.
- Due or overdue tasks based on `due:YYYY-MM-DD`.
- Project tags that are relevant to the current workspace.
- Any obvious blockers, duplicates, or tasks that are too vague to start safely.

Keep the summary short. The purpose is to choose work, not to produce a report.

## Picking The Next Task

Recommend one task using this priority order:

- Explicit user preference.
- Highest priority, with `(A)` before `(B)` before unprioritized tasks.
- Due or overdue tasks.
- Tasks matching the current workspace or repository, especially project tags like `+dotfiles`.
- Tasks that can be completed independently in the current session.
- Smaller, concrete tasks before broad refactors or vague ideas.

When one best task is clear, state the selected task and start working. If several tasks are equally good, present up to three options and ask the user to choose.

## Working The Task

When the selected task requires multiple implementation steps, create an opencode todo list for the session. Keep it separate from the user's `todo.txt` file; the opencode todo list tracks the current execution plan, while `todo.txt` tracks durable user progress.

Before editing code or config:

- Inspect the relevant files first.
- Preserve unrelated user changes.
- Make the smallest correct change.
- Verify with the most relevant command available.

## Updating Todo.txt

Update the `todo.txt` file only when progress is real and verified enough to justify changing durable task state.

For completed tasks, preserve the original task text and mark completion using the user's existing convention:

```text
x YYYY-MM-DD ORIGINAL_TASK_TEXT
```

If the original task already has a creation date, the result usually becomes:

```text
x YYYY-MM-DD YYYY-MM-DD task text +project due:YYYY-MM-DD
```

Do not remove project tags, context tags, metadata, or due dates unless the user explicitly asks.

If the task is partially done but not complete, prefer a concise progress note in the conversation instead of modifying the todo file. Only add extra todo.txt metadata such as `progress:` or `blocked:` if the file already uses that convention or the user asks for it.

When adding follow-up tasks discovered during implementation:

- Ask before adding broad new work.
- Keep the new task concrete and compatible with the file's style.
- Place it near related tasks unless the file has another clear ordering convention.

## Safety Rules

- Do not mark a task complete just because work started.
- Do not reorder the file unless the user asks.
- Do not mass-format or normalize the whole file.
- Do not delete completed tasks unless the user asks.
- If the requested todo file is outside the workspace, read and edit only the requested file or ask before touching nearby files.

## Response Pattern

Use this flow when handling a todo.txt request:

1. Read or locate the todo file.
2. Briefly summarize the current state.
3. Pick or ask for the next task.
4. Execute the task in the relevant workspace.
5. Verify the result.
6. Mark the todo complete only if the task is actually complete.
7. Report what changed and whether the todo file was updated.
