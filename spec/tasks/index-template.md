---
id: TASK-INDEX
title: Tasks Index (Repo-Level)
status: active
last_updated: 2025-11-10
summary: Entry point for task lists and work items (TASK-####) for this repository.
repo: your-repo-name-or-path
next_task_id: TASK-0001
notes: ""
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, repo, next_task_id
- Status values: draft | active
- next_task_id: The next available TASK-#### ID to assign
-->

# Tasks Index (Repo-Level)

This directory defines **work items** for this repository.

> **Purpose:** Tasks translate implementation specs (IMPL-####) into actionable work items with priorities, dependencies, and execution order. Every implementation should have at least one task before code generation begins.

It answers:

- What task lists exist for this repo (backlog, current sprint, etc.).
- Where individual tasks (`TASK-####`) live.
- How tasks relate to features (`FEAT-####`), components (`COMP-####`), and implementation areas (`IMPL-####`).

## Task Lists

Each task list is a Markdown file that groups tasks by status, priority, or theme.

Common lists:

- **Backlog** – main list of tasks for this repo.  
  - File: `backlog.md`
- **Current Sprint / Active Work** – tasks currently in progress.  
  - File: `current-sprint.md` (optional; create by copying `backlog-template.md`)
- **Icebox / Ideas** – tasks or ideas not yet prioritized.  
  - File: `icebox.md` (optional)

> **Convention:**  
> - Each list file should include a table of tasks and link to the individual task docs under `items/`.  
> - You can create additional list files as needed by copying `backlog-template.md`.

## Individual Tasks (TASK-####)

Each task has its own file under `items/` with a unique ID (`TASK-####`).

Example layout:

- `items/TASK-0001-implement-export-endpoint.md`
- `items/TASK-0002-add-validation.md`

## ID Conventions

- **Tasks index (this file):** `TASK-INDEX`.  
- **Task IDs:** `TASK-####` (e.g., `TASK-0001`).

## Relationships to Other Tiers

- **Charter – `FEAT-####`:** tasks should reference which features they contribute to.  
- **Architecture – `COMP-####`:** tasks should reference which components they touch.  
- **Implementation – `IMPL-####`:** tasks should reference which implementation areas they modify or create.

## Usage Notes (for Agents)

### Task Creation is Mandatory

Tasks are the **execution planning layer** between specs and code:

**For simple implementations:**
- Create one task that references the IMPL-####
- Set appropriate priority (P0-P3)
- No dependencies needed if standalone

**For complex implementations:**
- Break into multiple phased tasks
- Define dependencies between tasks (depends_on)
- Assign priorities to control execution order
- Each task still references the same IMPL-#### for contracts

### Working with Tasks

When using tasks in this repo:

1. Open the relevant task list (e.g., `backlog.md` or `current-sprint.md`) to find candidate tasks.
2. For a specific `TASK-####`, open its file in `items/` to get full context (description, dependencies, links to specs).
3. Read the referenced `IMPL-####` spec(s) for detailed contracts, data models, and invariants.
4. After completing a task:
   - Update its status and completion fields in the task file.
   - Update any affected specs in Charter, Architecture, or Implementation tiers.
   - Adjust task lists (move between backlog, sprint, etc.) as needed.
5. When creating a new task, use `next_task_id` from the front matter, then increment it.

---

> **Agent note:**
> Tasks are MANDATORY for code generation. Always create at least one task per implementation.
> Code generation tools read TASK-#### files, which reference IMPL-#### for detailed contracts.
> This separation keeps specs (what to build) separate from execution planning (when/how to build).
> This index is the entry point for all task-level documentation in this repo.
> Always update task lists when adding or removing tasks.
> When a task is complete, update its status to `done` but keep the file for historical reference.