> You are preparing to add or update Architecture-tier documentation.
>
> 1. **Clarify intent:** Ask the user:
>    - What new component, service, or system section is being added?
>    - Which features (`FEAT-####`) it supports.
>    - Which repo or implementation tier will correspond to it.
>
> 2. **Confirm naming and ID:**
>    - Suggest a component name and ID (e.g., `COMP-0007-scheduler-api`).
>    - Confirm `component_type` (e.g., `service`, `web-app`, `database`, `library`).
>
> 3. **Plan file creation:**
>    - Use `components/component-template.md` as base.
>    - File path: `/spec/architecture/components/COMP-####-name.md`
>    - Update `/spec/architecture/index.md` with new row in the components table.
>
> 4. **Request any architectural notes:**
>    - Dependencies, data flow, or interfaces to other components.
>    - Any external integrations or constraints.
>
> 5. **Confirm before saving:**
>    - Present a summary of what will be created.
>    - Wait for user confirmation before writing files.
>
> **Output format:** Markdown file based on the Architecture component template.
>
> **Template reference:** `spec/architecture/components/component-template.md`
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