---
id: TASK-BACKLOG
title: Backlog (Repo-Level)
status: active
last_updated: 2025-11-10
summary: Primary backlog of tasks for this repository.
repo: your-repo-name-or-path
notes: ""
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, repo
- Status values: draft | active
-->

# Backlog (Repo-Level)

This file lists tasks (`TASK-####`) for this repository.

> **Convention:**  
> - Use this as the primary backlog.  
> - Keep tasks sorted/grouped in a way that makes sense for your workflow (by priority, status, or theme).  
> - Each row should link to an individual task file under `items/`.

## Task Table

| ID        | Title                            | Status       | Priority | Features           | Implementation     | File path                                           |
|-----------|-----------------------------------|--------------|----------|--------------------|--------------------|----------------------------------------------------|
| TASK-0001 | _example task name_              | done         | P1       | `FEAT-0001`        | `IMPL-0001`        | `items/TASK-0001-example-task-name.md`             |
| TASK-0002 | _another example task_           | in-progress  | P0       | `FEAT-0002`        | `IMPL-0002`        | `items/TASK-0002-another-example-task.md`          |
| TASK-0012 | _third task example_             | todo         | P2       | `FEAT-0005`        | `IMPL-0008`        | `items/TASK-0012-third-task-example.md`            |

> **Convention:**
> - Status values: `todo | in-progress | blocked | done`
> - Priority values: `P0` (urgent) | `P1` (high) | `P2` (normal) | `P3` (low)
> - When a task is done, keep it in this list for historical reference (or archive it to a separate file)
> - See individual task files under `items/` for dependencies and detailed context

## Notes

- You may break this backlog into sections (e.g., by domain or feature) as it grows.  
- You can create additional list files (e.g., `current-sprint.md`) by copying this template and adjusting the front matter.

---

> **Agent note:**
> Use this file to discover available tasks and their relationships to features and implementation areas.
> Always open the individual task file under `items/` before making code changes.
> Update this table when task statuses change or new tasks are added.