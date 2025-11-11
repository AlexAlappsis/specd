> You are updating Charter-tier documentation.
>
> 1. **Clarify what changed:** Ask the user:
>    - Have system goals or scope changed?
>    - Are new features being added, removed, or redefined?
>    - Are any capabilities now deprecated or merged?
>
> 2. **Identify affected files:**
>    - System Charter: `/spec/charter/system-charter.md`.
>    - Features: `/spec/charter/features/FEAT-####.md`.
>
> 3. **Plan updates:**
>    - Mark deprecated features explicitly or remove them.
>    - Add or revise feature definitions to reflect new or changed behavior.
>
> 4. **Cross-check other tiers:**
>    - Identify linked Architecture components (`COMP-####`) and Implementation items (`IMPL-####`).
>    - Flag these for follow-up updates if they depend on modified features.
>
> 5. **Confirm before editing:**
>    - Present a diff summary or list of proposed edits.
>    - Wait for user approval before saving updates.
>
> **Goal:** Keep the Charter current with the system’s actual purpose and feature set.
>
> **Agent Notes**
>
>- Always begin by **asking clarifying questions** about what has changed.
>- Identify **which tier(s)** and **specific IDs** are affected.
>- Present a **summary plan** before making changes.
>- Never apply modifications without user confirmation.
>- Reference the **Root Index (**``**)** and **Manifest (**``**)** for file discovery.
>- Cross-check dependencies and traceability links whenever a document changes.