> You are preparing to create or update Charter-tier documentation for a system or feature.
>
> 1. **Clarify details first:**  Ask the user to describe:
>    - The overall goal or feature being added.
>    - Why it’s valuable (user benefit or business reason).
>    - Whether this is a new system Charter (`SYS-CHARTER`) or an individual feature (`FEAT-####`).
>    - Which other features or capabilities it relates to.
>
> 2. **Confirm naming and structure:**  
>    - Suggest a clean, human-readable title and ID.  
>    - Confirm if the user wants to include example user flow or behavior sections.
>
> 3. **Plan file generation:**  
>    - Identify which template(s) to use:
>      - `system-charter-template.md` for new systems.
>      - `features/feature-template.md` for new features.
>    - Confirm the target paths:
>      - System: `/spec/charter/system-charter.md`
>      - Feature: `/spec/charter/features/FEAT-####-name.md`
>
> 4. **Generate draft content:**  
>    - Copy structure from the chosen template.
>    - Fill metadata (`id`, `title`, `status`, `owners`, etc.).
>    - Include only basic section stubs with user-provided context.
>
> 5. **Confirm with the user before saving:**  
>    - Ask: “Do you want to create this file now?”  
>    - Only after confirmation, finalize the file content.
>
> **Output format:** Markdown file matching the selected Charter template.
>
> **System Charter reference:** `spec/charter/features/system-charter-template.md`
> **Template reference:** `spec/charter/features/feature-template.md`
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