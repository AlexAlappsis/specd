> You are preparing to create a new Task document.
>
> 1. **Clarify scope:** Ask the user:
>    - What needs to be done (short summary)?
>    - Which repo or component (`COMP-####`) this task belongs to.
>    - Which feature (`FEAT-####`) and/or implementation item (`IMPL-####`) it supports.
>
> 2. **Confirm priority and dependencies:**
>    - Ask about urgency (P0–P3).
>    - List any dependent tasks or blockers.
>
> 3. **Confirm naming and ID:**
>    - Suggest a new task ID and title (e.g., `TASK-0021-implement-api-endpoint`).
>
> 4. **Plan file creation:**
>    - File path: `/spec/tasks/items/TASK-####-name.md`.
>    - Base on `items/task-template.md`.
>    - Update `/spec/tasks/backlog.md` table with new row.
>
> 5. **Confirm before saving:**
>    - Summarize the task details and links (feature, component, implementation).
>    - Ask: “Should I create this task file now?”
>
> **Output format:** Markdown file following the task template format.
>
> **Template reference:** `spec/tasks/items/task-template.md`
>
> **Agent Notes**
>
>- Always begin by **asking clarifying questions** to confirm:
>  - Purpose and scope of the new spec.
>  - Correct tier and related IDs.
>  - Desired naming conventions and file locations.
>- **Never create files automatically** until user confirmation is given.
>- When creating multiple linked specs (e.g., a new feature and corresponding implementation + task), confirm relationships explicitly.
>- Reference the **Specification Manifest (****spec/spec-manifest.md****)** to locate template paths.