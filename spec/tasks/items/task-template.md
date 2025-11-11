---
id: TASK-0000                    # e.g., TASK-0001
title: Example Task Title
last_updated: 2025-11-10
status: todo                     # todo | in-progress | blocked | done
priority: P2                     # P0 | P1 | P2 | P3
repo: your-repo-name-or-path
features: []                     # e.g., ["FEAT-0001"]
components: []                   # e.g., ["COMP-0001"]
implementation_items: []         # e.g., ["IMPL-0001"]
depends_on: []                   # e.g., ["TASK-0003", "IMPL-0002"]
blocked_by: []                   # optional extra clarity; often overlaps with depends_on
created_by: your-name-or-team
created_at: 2025-11-10
completed_at: null
notes: >
  Optional short notes about this task or its context.
---

# {{title}} ({{id}})

## 1. Summary

> _Short, clear description of what this task is about._

- What needs to be done?  
- Why is it needed (in one or two sentences)?

## 2. Context & Links

> _Connect this task back to specs and related work._

- **Features (`FEAT-####`):**
  - `FEAT-0001` – brief note on how this task relates.  
- **Components (`COMP-####`):**
  - `COMP-0001` – component this task touches.  
- **Implementation items (`IMPL-####`):**
  - `IMPL-0001` – implementation area this task modifies or extends.  
- **Related tasks (`TASK-####`):**
  - `TASK-0003` – must be done first.  

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

> _Agent note:_  
> Use this task file as the source of truth for what needs to be done and why.  
> Before making changes, read the linked Charter/Architecture/Implementation docs.  
> After completing the work:
> - Update `status` and `completed_at`.  
> - Ensure all relevant specs are updated to reflect the new reality.  
> - Add any important decisions to the Notes & History section.