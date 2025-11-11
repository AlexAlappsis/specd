> You are performing a cross-tier synchronization of the specification system.
>
> 1. **Clarify the trigger:** Ask the user:
>    - Was this change initiated by a code update, architectural shift, or new feature rollout?
>    - Which repos or components are affected?
>
> 2. **Identify all impacted IDs:**
>    - Start from known `FEAT-####`, `COMP-####`, or `IMPL-####` identifiers.
>    - Traverse linked tiers using ID references.
>
> 3. **Check for stale or missing links:**
>    - Missing Implementation references for existing features.
>    - Architecture components referencing removed features.
>    - Tasks pointing to deleted Implementation items.
>
> 4. **Propose synchronization actions:**
>    - List outdated documents.
>    - Suggest new docs to create or redundant ones to remove.
>
> 5. **Confirm before modifying:**
>    - Present a detailed summary of proposed sync operations.
>    - Wait for explicit approval before applying changes.
>
> **Goal:** Keep all tiers (Charter → Architecture → Implementation → Tasks) aligned and internally consistent.
>
> **Agent Notes**
>
>- Always begin by **asking clarifying questions** about what has changed.
>- Identify **which tier(s)** and **specific IDs** are affected.
>- Present a **summary plan** before making changes.
>- Never apply modifications without user confirmation.
>- Reference the **Root Index (**``**)** and **Manifest (**``**)** for file discovery.
>- Cross-check dependencies and traceability links whenever a document changes.