Create a new implementation specification (IMPL-####) or edit an existing one.

**What this command does:**
1. **Create mode:** Auto-assigns next IMPL-#### ID and creates new implementation from template
2. **Edit mode:** Loads existing implementation by ID and cooperatively updates it
3. Updates implementation index and maintains cross-tier links
4. Optionally creates associated test specifications

**Usage:**
```
/spec-impl              # Create new implementation
/spec-impl IMPL-0007    # Edit existing implementation
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

## Mode Detection

First, determine if this is CREATE or EDIT mode:

1. **Check for ID argument:**
   - If user provides IMPL-#### ID (e.g., `/spec-impl IMPL-0007`), use EDIT mode
   - If no argument provided, use CREATE mode

2. **In EDIT mode:**
   - Validate ID format (IMPL-NNNN)
   - Search for file matching pattern `spec/implementation/contracts/IMPL-####-*.md`
   - If not found, inform user and ask if they want to create a new implementation instead
   - If found, proceed with editing workflow

## CREATE Mode Workflow

1. **Load implementation index (initialize if needed):**
   - Try to open `spec/implementation/index.md`
   - If file not found:
     - Try to open `spec/implementation/index-template.md`
     - If template not found, inform user to run `install.sh` first and exit
     - Prompt user for repository name (needed for tier initialization)
     - Copy `spec/implementation/index-template.md` → `spec/implementation/index.md`
     - Copy `spec/implementation/overview-template.md` → `spec/implementation/overview.md` (if template exists)
     - Replace {{repo}} placeholder with user-provided repository name in both files
     - Set initial `next_impl_id: IMPL-0001`
     - Set `last_updated` to today's date (YYYY-MM-DD)
     - Remove any example rows from implementation table
     - Inform user: "Implementation tier initialized for repo: {repo}. Creating first implementation..."
   - Extract `next_impl_id` and `repo` from front matter
   - Parse existing implementation table

2. **Read available features and components:**
   - Try to open `spec/charter/index.md` for FEAT-#### list (optional)
   - Try to open `spec/architecture/index.md` for COMP-#### list (optional)
   - If neither found, inform user they can create features/components later with /spec-feature and /spec-component

3. **Prompt user for implementation details:**
   - Implementation name (e.g., "User API Endpoints", "Authentication Module")
   - Brief summary (one-line description)
   - Features this implements (select from FEAT-#### list, can be multiple)
   - Components this belongs to (select from COMP-#### list, can be multiple, but one is primary)
   - Primary component (if multiple selected)
   - Source code paths (e.g., ["src/Api/Users", "src/Domain/UserManagement"])
   - **Does this implementation need test specifications?** (y/n)
     - If yes, ask for test details (defer creation until after IMPL is created)

4. **Generate implementation slug:**
   - Convert name to kebab-case
   - Create filename: `IMPL-####-{slug}.md`

5. **Create implementation file:**
   - Copy `spec/implementation/contracts/impl-item-template.md`
   - Save to `spec/implementation/contracts/IMPL-####-{slug}.md`
   - Replace all {{placeholder}} values:
     - `{{id}}` → assigned IMPL-#### ID
     - `{{title}}` → user-provided name
     - `{{summary}}` → user-provided summary
     - `{{status}}` → "draft"
     - `{{last_updated}}` → today's date
     - `{{repo}}` → from implementation index front matter
     - `{{features}}` → array of selected FEAT-#### IDs
     - `{{components}}` → array of selected COMP-#### IDs
     - `{{source_paths}}` → user-provided source paths array
     - `{{notes}}` → ""

6. **Update implementation index:**
   - Add new row to implementation table
   - Use primary component in "Primary Component" column
   - List features in "Primary Features" column
   - Keep sorted by ID
   - Increment `next_impl_id`
   - Update `last_updated`

7. **Update feature backlinks (CRITICAL):**
   - For each FEAT-#### in implementations features[] array:
     - Open `spec/charter/features/FEAT-####-*.md`
     - Add this IMPL-#### to implementations[] array in front matter
     - Update `last_updated`

8. **Update component backlinks (CRITICAL):**
   - For each COMP-#### in implementations components[] array:
     - Open `spec/architecture/components/COMP-####-*.md`
     - Add this IMPL-#### to implementations[] array in front matter
     - Update `last_updated`

9. **Create test documentation (if user requested):**
   - Prompt for:
     - Test type (unit | integration | e2e | contract | performance | mixed)
       - Use "mixed" if covering multiple test types in one document
     - Brief summary of test strategy
   - Copy `spec/implementation/tests/impl-tests-template.md`
   - Save to `spec/implementation/tests/IMPL-####-TESTS.md`
   - Replace all {{placeholder}} values:
     - `{{id}}` → IMPL-####-TESTS (using same IMPL-#### ID)
     - `{{title}}` → "Tests for [implementation name]"
     - `{{test_type}}` → user-provided type
     - `{{status}}` → "draft"
     - `{{last_updated}}` → today's date
     - `{{summary}}` → user-provided summary
     - `{{impl_id}}` → this IMPL-#### ID
     - `{{repo}}` → from implementation index
     - `{{features}}` → copy from IMPL spec
     - `{{components}}` → copy from IMPL spec

10. **Report completion:**
    - Display created file path
    - Show assigned IMPL-#### ID
    - List updated feature and component files (backlinks)
    - If test doc created, show test file path
    - Suggest next steps:
      - "Edit the implementation file to define contracts, APIs, and data models"
      - If test doc created: "Edit tests/IMPL-####-TESTS.md to define test scenarios and coverage requirements"
      - "Use /spec-task to create tasks for implementing this specification"
      - "Run /spec-sync to validate all cross-tier links"

## EDIT Mode Workflow

When editing an existing implementation:

1. **Load the implementation file:**
   - Open `spec/implementation/contracts/IMPL-####-*.md`
   - Parse front matter and content
   - Show current values to user

2. **Cooperative editing:**
   ```
   Loaded IMPL-0007: User API Endpoints

   Current values:
   - Title: User API Endpoints
   - Status: draft
   - Summary: REST API endpoints for user CRUD operations and authentication
   - Repository: main-api-repo
   - Features: ["FEAT-0002", "FEAT-0005"]
   - Components: ["COMP-0003"]
   - Source paths: ["src/Api/Users", "src/Controllers/AuthController"]
   - Test doc: tests/IMPL-0007-TESTS.md (exists)

   What would you like to update? (You can update multiple fields)
   ```

3. **Prompt for changes:**
   - Ask what the user wants to change
   - For array fields (features, components, source_paths):
     - Ask if they want to add or remove IDs/paths
     - Validate IDs exist before adding
   - For content sections, ask if they want to replace or append
   - Special handling for test documentation:
     - If no test doc exists, offer to create tests/IMPL-####-TESTS.md
     - If test doc exists, user can edit it separately

4. **Update cross-tier links if needed:**
   - If features[] array changes:
     - If adding FEAT-####: Add this IMPL-#### to that feature's implementations[] array
     - If removing FEAT-####: Remove this IMPL-#### from that feature's implementations[] array
   - If components[] array changes:
     - If adding COMP-####: Add this IMPL-#### to that component's implementations[] array
     - If removing COMP-####: Remove this IMPL-#### from that component's implementations[] array
   - Always update `last_updated` in modified files

5. **Update index if needed:**
   - If title, status, or other key fields change, update the implementation index table row
   - Update `last_updated` in index

6. **Report changes:**
   - Show what was updated
   - List any cross-tier link updates
   - Suggest running /spec-sync to validate consistency

**Example interactions:**

### CREATE mode:
```
User: /spec-impl

Claude: I'll help you create a new implementation specification.

Available features:
- FEAT-0002: User Management
- FEAT-0005: User Authentication

Available components:
- COMP-0003: User Service

Implementation name: User API Endpoints
Summary: REST API endpoints for user CRUD operations and authentication
Features: FEAT-0002, FEAT-0005
Components: COMP-0003
Source paths: ["src/Api/Users", "src/Controllers/AuthController"]
Does this implementation need test documentation? (y/n): y

Test type (unit | integration | e2e | contract | performance | mixed): unit
Summary: Unit tests for user API endpoints covering CRUD operations and validation

Creating IMPL-0007-user-api-endpoints.md...
✓ Created spec/implementation/contracts/IMPL-0007-user-api-endpoints.md
✓ Updated spec/implementation/index.md
✓ Updated spec/charter/features/FEAT-0002-user-management.md (added IMPL-0007)
✓ Updated spec/charter/features/FEAT-0005-user-authentication.md (added IMPL-0007)
✓ Updated spec/architecture/components/COMP-0003-user-service.md (added IMPL-0007)

Creating test documentation...
✓ Created spec/implementation/tests/IMPL-0007-TESTS.md
✓ Incremented next_impl_id to IMPL-0008

Next steps:
- Edit spec/implementation/contracts/IMPL-0007-user-api-endpoints.md to define:
  - Public contracts (APIs, interfaces)
  - Data models and types
  - Business rules and invariants
- Edit spec/implementation/tests/IMPL-0007-TESTS.md to define:
  - Test scenarios and coverage requirements
  - Critical test cases and edge conditions
- Use /spec-task to create execution tasks
- Run /spec-sync to validate links
```

### EDIT mode:
```
User: /spec-impl IMPL-0007

Claude: Loaded IMPL-0007: User API Endpoints

Current values:
- Title: User API Endpoints
- Status: draft
- Features: ["FEAT-0002", "FEAT-0005"]
- Components: ["COMP-0003"]
- Test doc: tests/IMPL-0007-TESTS.md (exists)

What would you like to update?

User: Change status to active

Claude: Updating IMPL-0007...
✓ Updated status: draft → active
✓ Updated spec/implementation/contracts/IMPL-0007-user-api-endpoints.md
✓ Updated spec/implementation/index.md

Completed! Run /spec-sync to validate all cross-tier links.
```

**Important notes:**
- MUST update both feature AND component backlinks for bidirectional consistency
- Validate all referenced FEAT-#### and COMP-#### IDs exist
- If selecting multiple components, ask which is primary for the index table
- Arrays must be valid YAML/JSON format
- source_paths should be relative to repository root
- No duplicates in backlink arrays
- Test documentation is optional but recommended for systematic test planning
- Test docs use IMPL-####-TESTS format (1:1 with implementation) and live in `spec/implementation/tests/`
