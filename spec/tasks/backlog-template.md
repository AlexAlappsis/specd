---
id: TASK-BACKLOG
title: Backlog (Repo-Level)
last_updated: 2025-11-10
repo: your-repo-name-or-path
description: Primary backlog of tasks for this repository.
---

# Backlog (Repo-Level)

This file lists tasks (`TASK-####`) for this repository.

> **Convention:**  
> - Use this as the primary backlog.  
> - Keep tasks sorted/grouped in a way that makes sense for your workflow (by priority, status, or theme).  
> - Each row should link to an individual task file under `items/`.

## Task Table

| ID        | Title                            | Status       | Priority | Depends On                      | Features (`FEAT-####`)     | Implementation (`IMPL-####`)     | File path                                           |
|-----------|-----------------------------------|--------------|----------|----------------------------------|----------------------------|----------------------------------|-----------------------------------------------------|
| TASK-0001 | _example task name_              | todo         | P1       | `TASK-0000`, `IMPL-0001`        | `FEAT-0001`                | `IMPL-0001`                      | `items/TASK-0001-example-task-name.md`             |
| TASK-0002 | _another example task_           | in-progress  | P0       | `TASK-0001`                     | `FEAT-0002`                | `IMPL-0002`                      | `items/TASK-0002-another-example-task.md`          |

> **Status values:** `todo`, `in-progress`, `blocked`, `done`.  
> **Priority values:** `P0` (urgent), `P1` (high), `P2` (normal), `P3` (low).

## Notes

- You may break this backlog into sections (e.g., by domain or feature) as it grows.  
- You can create additional list files (e.g., `current-sprint.md`) by copying this template and adjusting the front matter.

---

> _Agent note:_  
> Use this file to discover available tasks and their relationships to features and implementation areas.  
> Always open the individual task file under `items/` before making code changes.