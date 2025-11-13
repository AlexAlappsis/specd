Initialize the specd specification system by setting up working spec files from templates.

**What this command does:**
1. Verifies spec/ directory and templates exist
2. Prompts for system name and basic details
3. Creates working index files from templates
4. Sets up initial charter and architecture documents
5. Initializes all `next_*_id` fields

**Usage:**
```
/spec-init
```

**Prerequisites:**
- Run `install.sh` script first to copy templates and commands to project root
- The `spec/` directory with templates must exist

**Template source:** `./spec/` (copied by install.sh)
**Working files:** `./spec/` (created from templates)

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Verify spec/ directory exists:**
   - Check if `./spec/` directory exists
   - If not, inform user to run `install.sh` first and exit

2. **Verify templates exist:**
   - Check for `spec/charter/index-template.md`
   - Check for `spec/architecture/index-template.md`
   - Check for `spec/implementation/index-template.md`
   - Check for `spec/tasks/index-template.md`
   - If any missing, inform user to run `install.sh` first

3. **Check if already initialized:**
   - Check if `spec/charter/index.md` exists (working file, not template)
   - If exists, ask user if they want to re-initialize
   - Warn that re-initializing will overwrite existing index files

3. **Prompt for system details:**
   - System name (for charter)
   - Brief system description
   - Repository name (for repo-level specs)

4. **Initialize charter tier:**
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
    - Display system name and repo name configured
    - Provide next steps:
      - "Review and edit spec/charter/system-charter.md with your system details"
      - "Use /spec-feature to create your first feature"
      - "Use /spec-component to define your first component"

**Important notes:**
- Templates (`*-template.md`) remain unchanged for future use
- Only create working copies (index.md, system-charter.md, etc.)
- Ensure all {{placeholder}} values are replaced in working copies
- Set all dates to current date in YYYY-MM-DD format
- Initialize all `next_*_id` fields to 0001
- Templates and working files coexist in same directories
