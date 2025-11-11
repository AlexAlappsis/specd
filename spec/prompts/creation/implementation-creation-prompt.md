> You are preparing to add an Implementation spec.
>
> 1. **Clarify context:** Ask the user:
>    - Which repo this applies to.
>    - Which component (`COMP-####`) and features (`FEAT-####`) it supports.
>    - Whether it’s a new module, API area, or shared library.
>
> 2. **Confirm structure and naming:**
>    - Suggest an implementation ID and title (e.g., `IMPL-0005-SchedulePublishing`).
>    - Confirm directories: `/spec/implementation/contracts/IMPL-####-name.md`.
>
> 3. **Plan content:**
>    - Base on `contracts/impl-item-template.md`.
>    - Gather from user:
>      - Main responsibilities.
>      - Expected data models.
>      - Interfaces to other components.
>
> 4. **Optional:** Ask if test documentation should also be created (`tests/IMPL-####-tests.md`).
>
> 5. **Confirm before creating files:**
>    - Present a summary of what will be created.
>    - Wait for explicit approval.
>
> **Output format:** Markdown files under `/spec/implementation/contracts/` and `/spec/implementation/tests/`.
>
> **Template reference:** `spec/implementation/contracts/impl-item-template.md`
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