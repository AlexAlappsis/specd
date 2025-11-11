> You are updating task documentation.
>
> 1. **Clarify progress:** Ask the user:
>    - Which tasks were completed or blocked?
>    - Are there any new dependencies or reprioritizations?
>    - Should any tasks move between lists (e.g., backlog → current sprint → done)?
>
> 2. **Locate affected files:**
>    - Task items: `/spec/tasks/items/TASK-####.md`.
>    - Task lists: `/spec/tasks/backlog.md`, `/spec/tasks/current-sprint.md`.
>
> 3. **Plan updates:**
>    - Update status, priority, or completion date.
>    - Move or copy rows between task lists if necessary.
>    - Add notes or history entries for key decisions.
>
> 4. **Cross-check Implementation and Features:**
>    - Identify any linked `IMPL-####` or `FEAT-####` specs affected by task completion.
>
> 5. **Confirm before saving:**
>    - Show a summary of changes.
>    - Wait for approval before applying updates.
>
> **Goal:** Maintain accurate task tracking aligned with the actual project state.
>
> **Agent Notes**
>
>- Always begin by **asking clarifying questions** about what has changed.
>- Identify **which tier(s)** and **specific IDs** are affected.
>- Present a **summary plan** before making changes.
>- Never apply modifications without user confirmation.
>- Reference the **Root Index (**``**)** and **Manifest (**``**)** for file discovery.
>- Cross-check dependencies and traceability links whenever a document changes.