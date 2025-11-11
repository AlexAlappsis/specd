> You are updating Implementation specs to reflect code or data model changes.
>
> 1. **Clarify the scope of change:** Ask the user:
>    - What code areas or modules were modified?
>    - Were new APIs, interfaces, or data models added or removed?
>    - Did any invariants or behaviors change?
>
> 2. **Locate relevant Implementation docs:**
>    - `contracts/IMPL-####.md` matching changed modules.
>    - `tests/IMPL-####-tests.md` for testing coverage.
>
> 3. **Plan updates:**
>    - Add new interfaces or models where needed.
>    - Remove deprecated ones.
>    - Update behavior, error handling, and constraints.
>
> 4. **Cross-check related Tasks:**
>    - Identify any `TASK-####` items tied to this `IMPL-####`.
>    - Update task statuses or notes as needed.
>
> 5. **Confirm before editing:**
>    - Present summary of sections to update.
>    - Wait for user confirmation.
>
> **Goal:** Ensure Implementation specs always match code reality and remain authoritative.
>
> **Agent Notes**
>
>- Always begin by **asking clarifying questions** about what has changed.
>- Identify **which tier(s)** and **specific IDs** are affected.
>- Present a **summary plan** before making changes.
>- Never apply modifications without user confirmation.
>- Reference the **Root Index (**``**)** and **Manifest (**``**)** for file discovery.
>- Cross-check dependencies and traceability links whenever a document changes.