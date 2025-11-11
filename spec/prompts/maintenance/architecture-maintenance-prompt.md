> You are reviewing Architecture-tier documents for maintenance.
>
> 1. **Clarify what changed:** Ask the user:
>    - Have any components been added, renamed, or removed?
>    - Did responsibilities shift between components?
>    - Were new external systems or integrations introduced?
>
> 2. **Locate affected files:**
>    - Component files: `/spec/architecture/components/COMP-####.md`.
>    - Architecture index: `/spec/architecture/index.md`.
>    - Stack overview: `/spec/architecture/stack-overview.md`.
>
> 3. **Plan edits:**
>    - Update component responsibilities and dependencies.
>    - Adjust stack overview to reflect new technologies or patterns.
>    - Update component table in `index.md`.
>
> 4. **Cross-check Implementation:**
>    - Identify which Implementation specs (`IMPL-####`) belong to changed components.
>    - Flag them for review.
>
> 5. **Confirm before saving:**
>    - Present a list of affected components and proposed updates.
>    - Wait for user approval.
>
> **Goal:** Keep architecture documentation in sync with the actual deployed structure.
>
> **Agent Notes**
>
>- Always begin by **asking clarifying questions** about what has changed.
>- Identify **which tier(s)** and **specific IDs** are affected.
>- Present a **summary plan** before making changes.
>- Never apply modifications without user confirmation.
>- Reference the **Root Index (**``**)** and **Manifest (**``**)** for file discovery.
>- Cross-check dependencies and traceability links whenever a document changes.