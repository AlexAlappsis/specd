Create a new task (TASK-####) for execution planning. Tasks are mandatory before code generation.

**What this command does:**
1. Auto-assigns next available TASK-#### ID
2. Creates new task file from template
3. Updates task backlog with new entry
4. Increments next_task_id

**Usage:**
```
/spec-task
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Check if tasks tier is initialized:**
   - Check if `spec/tasks/index.md` exists (working file, not template)
   - If exists, proceed to step 3 (tier already initialized)
   - If not exists, proceed to step 2 (initialize tier)

2. **Initialize tasks tier (if needed):**
   - Check if `spec/` directory exists; if not, inform user to run `install.sh` first and exit
   - Check for `spec/tasks/index-template.md`; if missing, inform user to run `install.sh` first and exit
   - Check for `spec/tasks/backlog-template.md`; if missing, inform user to run `install.sh` first and exit
   - Prompt user for repository name (needed for tier initialization)
   - Copy `spec/tasks/index-template.md` → `spec/tasks/index.md`
   - Copy `spec/tasks/backlog-template.md` → `spec/tasks/backlog.md`
   - Replace {{repo}} placeholder with user-provided repository name in both files
   - Set initial `next_task_id: TASK-0001`
   - Set `last_updated` to today's date (YYYY-MM-DD)
   - Remove any example rows from task table
   - Inform user: "Tasks tier initialized for repo: {repo}. Creating first task..."

3. **Read task index:**
   - Open `spec/tasks/index.md`
   - Extract `next_task_id` and `repo` from front matter
   - Parse existing task table from `spec/tasks/backlog.md`

4. **Read available specs for linking:**
   - Open `spec/charter/index.md` for FEAT-#### list
   - Open `spec/architecture/index.md` for COMP-#### list
   - Open `spec/implementation/index.md` for IMPL-#### list
   - List existing TASK-#### IDs for depends_on

5. **Prompt user for task details:**
   - Task title (concise, action-oriented, e.g., "Implement user login endpoint")
   - Brief summary (one-line description of what gets done)
   - Priority (P0=urgent | P1=high | P2=normal | P3=low)
   - Features this contributes to (select from FEAT-####, can be multiple)
   - Components this touches (select from COMP-####, can be multiple)
   - Implementations this modifies/creates (select from IMPL-####, typically one but can be multiple)
   - Dependencies (select from TASK-#### or IMPL-####, optional)
   - Detailed requirements (what needs to be built?)
   - Completion criteria (how do we know it's done?)

6. **Generate task slug:**
   - Convert title to kebab-case
   - Create filename: `TASK-####-{slug}.md`

7. **Create task file:**
   - Copy `spec/tasks/items/task-template.md`
   - Save to `spec/tasks/items/TASK-####-{slug}.md`
   - Replace all {{placeholder}} values:
     - `{{id}}` → assigned TASK-#### ID
     - `{{title}}` → user-provided title
     - `{{summary}}` → user-provided summary
     - `{{status}}` → "todo"
     - `{{priority}}` → user-selected priority (P0-P3)
     - `{{last_updated}}` → today's date
     - `{{repo}}` → from task index front matter
     - `{{features}}` → array of selected FEAT-#### IDs
     - `{{components}}` → array of selected COMP-#### IDs
     - `{{implementations}}` → array of selected IMPL-#### IDs
     - `{{depends_on}}` → array of TASK-#### or IMPL-#### dependencies
     - `{{created_at}}` → today's date
     - `{{completed_at}}` → null
     - `{{notes}}` → ""
   - Fill in requirements and completion criteria from user prompts

8. **Update task backlog:**
   - Open `spec/tasks/backlog.md`
   - Add new row to task table:
     ```
     | TASK-#### | Title | Status | Priority | Features | Implementation | File path |
     ```
   - Keep sorted by priority (P0 first) then ID
   - Update `last_updated` in front matter

9. **Update task index:**
   - Increment `next_task_id`
   - Update `last_updated`

10. **Report completion:**
   - Display created file path
   - Show assigned TASK-#### ID
   - Display priority and dependencies
   - Emphasize that tasks are mandatory for code generation
   - Suggest next steps:
      - "Review and refine the task details"
      - "For complex implementations, create additional tasks for different phases"
      - "Use specdocs-generator TASK-#### to generate code (when ready)"
      - "Update task status to 'in-progress' when you start work"

**Example interaction:**
```
User: /spec-task

Claude: I'll help you create a new task for execution planning.

Available implementations:
- IMPL-0007: User API Endpoints

Task title: Implement user login endpoint
Summary: Build POST /api/auth/login endpoint with JWT token generation
Priority: P1
Features: FEAT-0005
Components: COMP-0003
Implementations: IMPL-0007
Dependencies: [none]

Requirements:
- Accept email and password in request body
- Validate credentials against user database
- Generate JWT token on success
- Return 401 on invalid credentials

Completion criteria:
- Endpoint responds to POST /api/auth/login
- Returns JWT token on valid credentials
- Returns appropriate error codes
- Unit and integration tests pass

Creating TASK-0015-implement-user-login-endpoint.md...
✓ Created spec/tasks/items/TASK-0015-implement-user-login-endpoint.md
✓ Updated spec/tasks/backlog.md
✓ Incremented next_task_id to TASK-0016

This task is ready for code generation:
- Priority: P1 (high)
- References: IMPL-0007 (for contracts and data models)
- Status: todo

Next steps:
- Use: specdocs-generator TASK-0015
- The generator will read IMPL-0007 for detailed contracts
- Update status to 'in-progress' when starting work
- Mark 'done' and set completed_at when finished
```

**Important notes:**
- Tasks are MANDATORY before code generation
- Tasks reference IMPL-#### for detailed contracts (don't duplicate contract info in task)
- Task describes WHAT to build and WHEN/WHY, IMPL describes HOW (contracts/data models)
- One-way links: tasks reference other tiers, but are not referenced back
- Validate all referenced IDs exist
- Arrays must be valid YAML/JSON format
- For simple implementations: one task is enough
- For complex implementations: break into multiple phased tasks with dependencies
- depends_on can include both TASK-#### (task must wait) and IMPL-#### (implementation must exist)
