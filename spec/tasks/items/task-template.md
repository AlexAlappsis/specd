---
id: TASK-0001
title: Example Task Title
status: todo
last_updated: 2025-11-10
summary: Brief one-line description of what this task accomplishes.
priority: P2
repo: your-repo-name-or-path
features: []
components: []
implementations: []
depends_on: []
created_at: 2025-11-10
completed_at: null
notes: "Use this field to capture context, constraints, or important decisions about this task"
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, priority, repo, created_at
- id format: TASK-NNNN (e.g., TASK-0001)
- Status values: todo | in-progress | blocked | done
- Priority values: P0 (urgent) | P1 (high) | P2 (normal) | P3 (low)
- Traceability arrays:
  - features: FEAT-#### IDs this task contributes to
  - components: COMP-#### IDs this task touches
  - implementations: IMPL-#### IDs this task modifies
  - depends_on: Can include other TASK-#### or IMPL-#### IDs that must exist first
  - Example: features: ["FEAT-0001"], implementations: ["IMPL-0003"]
- Dates: Use YYYY-MM-DD format
- completed_at: null until task is done, then set to completion date

CROSS-TIER CONSISTENCY:
- Tasks reference other tiers but are not referenced back (one-way links)
- All FEAT-####, COMP-####, and IMPL-#### IDs referenced must exist
- All TASK-#### IDs in depends_on must exist

TEMPLATE USAGE:
- Replace {{id}} with the actual task ID (e.g., TASK-0001)
- Replace {{title}} with the actual task name
- Replace {{status}}, {{priority}}, {{repo}} with actual values
- Replace {{created_at}} with actual date in YYYY-MM-DD format
- Replace {{features}}, {{components}}, {{implementations}}, {{depends_on}} with actual arrays
- Replace all {{variable}} placeholders before saving
-->

# Task: {{title}}

**ID:** `{{id}}`
**Status:** `{{status}}`
**Priority:** `{{priority}}`
**Repo:** `{{repo}}`
**Created:** `{{created_at}}`
**Completed:** `{{completed_at}}`

## 1. Summary

> _Short, clear description of what this task is about._

- What needs to be done?  
- Why is it needed (in one or two sentences)?

## 2. Traceability

**Cross-tier links:**

- **Features:** `{{features}}` (FEAT-#### IDs this task contributes to)
- **Components:** `{{components}}` (COMP-#### IDs this task touches)
- **Implementations:** `{{implementations}}` (IMPL-#### IDs this task modifies or creates)
- **Dependencies:** `{{depends_on}}` (TASK-#### or IMPL-#### IDs that must be complete first)

> **Note:** These arrays should be populated when creating the task based on existing specs.  

## 3. Requirements & Constraints

> _Any important constraints or requirements for completing this task._

- Behavioral expectations (what should change, at a high level).  
- Non-functional constraints (performance, security, UX, etc.), if relevant.  
- Any notes about what **must not** be changed.

## 4. Plan / Suggested Steps (Optional)

> _Optional breakdown of how to approach this task._

- Step 1: …  
- Step 2: …  
- Step 3: …

(Useful for complex tasks or for guiding agents.)

## 5. Completion Criteria

> _What conditions must be true for this task to be considered done._

- Code changes implemented in the relevant repo/paths.  
- Tests updated or added (if required).  
- Specs updated (Charter, Architecture, Implementation) if behavior or contracts changed.  
- Any manual verification steps.

## 6. Notes & History

> _Optional freeform notes, decisions, or history for this task._

- You can add dated bullet points here, e.g.:  
  - 2025-11-10 – Clarified requirement with product owner.  
  - 2025-11-11 – Initial implementation started.

---

> **Agent note:**
> Tasks are OPTIONAL. For simple/medium implementations, work directly from IMPL-#### specs.
> This task file is used when breaking down complex implementations into smaller work items.
> Before making changes, read the linked Implementation docs for detailed contracts and data models.
> After completing the work:
> - Update `status` to `done` and set `completed_at` to the completion date.
> - Ensure all relevant specs are updated to reflect the new reality.
> - Add any important decisions to the Notes & History section.
> - Update the backlog table to reflect the new status.
> Keep completed tasks for historical reference rather than deleting them.