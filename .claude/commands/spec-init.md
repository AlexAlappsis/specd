Initialize the specd specification system in this project by copying templates from the .specdocs submodule.

**What this command does:**
1. Checks if .specdocs submodule exists at project root
2. Copies template structure from .specdocs/spec/ to ./spec/
3. Creates initial directory structure for all four tiers
4. Prompts for system name and basic details
5. Creates initial charter and architecture index files

**Usage:**
```
/spec-init
```

**Prerequisites:**
- The .specdocs submodule must be present at the project root
- If not present, add it with: `git submodule add <repo-url> .specdocs`

**Template source:** `.specdocs/spec/`
**Destination:** `./spec/`

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Verify .specdocs submodule exists:**
   - Check if `.specdocs/spec/` directory exists
   - If not, inform user they need to add the submodule first and exit

2. **Check if spec/ already exists:**
   - If `./spec/` exists, ask user if they want to overwrite or merge
   - Default to aborting to prevent data loss

3. **Prompt for system details:**
   - System name (for charter)
   - Brief system description
   - Repository name (for repo-level specs)

4. **Copy template structure:**
   - Copy entire `.specdocs/spec/` directory to `./spec/`
   - Preserve all templates (files ending in `-template.md`)
   - Create working copies of index files

5. **Initialize charter tier:**
   - Copy `spec/charter/index-template.md` → `spec/charter/index.md`
   - Copy `spec/charter/system-charter-template.md` → `spec/charter/system-charter.md`
   - Replace {{system_name}} and {{description}} placeholders with user-provided values
   - Set initial dates to today's date (YYYY-MM-DD)
   - Set `next_feature_id: FEAT-0001`

6. **Initialize architecture tier:**
   - Copy `spec/architecture/index-template.md` → `spec/architecture/index.md`
   - Copy `spec/architecture/stack-overview-template.md` → `spec/architecture/stack-overview.md`
   - Set `next_component_id: COMP-0001`
   - Remove example rows from component table

7. **Initialize implementation tier:**
   - Copy `spec/implementation/index-template.md` → `spec/implementation/index.md`
   - Copy `spec/implementation/overview-template.md` → `spec/implementation/overview.md`
   - Replace {{repo}} placeholder with user-provided repo name
   - Set `next_impl_id: IMPL-0001`
   - Remove example rows from implementation table

8. **Initialize tasks tier:**
   - Copy `spec/tasks/index-template.md` → `spec/tasks/index.md`
   - Copy `spec/tasks/backlog-template.md` → `spec/tasks/backlog.md`
   - Replace {{repo}} placeholder with user-provided repo name
   - Set `next_task_id: TASK-0001`
   - Remove example rows from task table

9. **Create spec/readme.md:**
   - Copy from template and ensure it references the correct system name

10. **Report completion:**
    - List created files
    - Provide next steps:
      - "Review and edit spec/charter/system-charter.md with your system details"
      - "Use /spec-feature to create your first feature"
      - "Use /spec-component to define your first component"

**Important notes:**
- Preserve all `-template.md` files for future reference
- Do not modify templates, only create working copies
- Ensure all {{placeholder}} values are replaced in working copies
- Set all dates to current date in YYYY-MM-DD format
- Initialize all `next_*_id` fields to 0001
