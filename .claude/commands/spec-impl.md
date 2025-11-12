Create a new implementation specification (IMPL-####) and update cross-tier links.

**What this command does:**
1. Auto-assigns next available IMPL-#### ID
2. Creates new implementation file from template
3. Updates implementation index with new entry
4. Updates referenced feature and component files with bidirectional links
5. Increments next_impl_id

**Usage:**
```
/spec-impl
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Verify spec system exists:**
   - Check if `spec/implementation/index.md` exists
   - If not, prompt user to run `/spec-init` first

2. **Read implementation index:**
   - Open `spec/implementation/index.md`
   - Extract `next_impl_id` and `repo` from front matter
   - Parse existing implementation table

3. **Read available features and components:**
   - Open `spec/charter/index.md` for FEAT-#### list
   - Open `spec/architecture/index.md` for COMP-#### list

4. **Prompt user for implementation details:**
   - Implementation name (e.g., "User API Endpoints", "Authentication Module")
   - Brief summary (one-line description)
   - Features this implements (select from FEAT-#### list, can be multiple)
   - Components this belongs to (select from COMP-#### list, can be multiple, but one is primary)
   - Primary component (if multiple selected)
   - Source code paths (e.g., ["src/Api/Users", "src/Domain/UserManagement"])

5. **Generate implementation slug:**
   - Convert name to kebab-case
   - Create filename: `IMPL-####-{slug}.md`

6. **Create implementation file:**
   - Copy `.specdocs/spec/implementation/contracts/impl-item-template.md`
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

7. **Update implementation index:**
   - Add new row to implementation table
   - Use primary component in "Main Component" column
   - List features in "Primary Features" column
   - Keep sorted by ID
   - Increment `next_impl_id`
   - Update `last_updated`

8. **Update feature backlinks (CRITICAL):**
   - For each FEAT-#### in implementations features[] array:
     - Open `spec/charter/features/FEAT-####-*.md`
     - Add this IMPL-#### to implementations[] array in front matter
     - Update `last_updated`

9. **Update component backlinks (CRITICAL):**
   - For each COMP-#### in implementations components[] array:
     - Open `spec/architecture/components/COMP-####-*.md`
     - Add this IMPL-#### to implementations[] array in front matter
     - Update `last_updated`

10. **Report completion:**
    - Display created file path
    - Show assigned IMPL-#### ID
    - List updated feature and component files (backlinks)
    - Suggest next steps:
      - "Edit the implementation file to define contracts, APIs, and data models"
      - "Use /spec-task to create tasks for implementing this specification"
      - "Run /spec-sync to validate all cross-tier links"

**Example interaction:**
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

Creating IMPL-0007-user-api-endpoints.md...
✓ Created spec/implementation/contracts/IMPL-0007-user-api-endpoints.md
✓ Updated spec/implementation/index.md
✓ Updated spec/charter/features/FEAT-0002-user-management.md (added IMPL-0007)
✓ Updated spec/charter/features/FEAT-0005-user-authentication.md (added IMPL-0007)
✓ Updated spec/architecture/components/COMP-0003-user-service.md (added IMPL-0007)
✓ Incremented next_impl_id to IMPL-0008

Next steps:
- Edit the implementation file to define:
  - Public contracts (APIs, interfaces)
  - Data models and types
  - Business rules and invariants
- Use /spec-task to create execution tasks
- Run /spec-sync to validate links
```

**Important notes:**
- MUST update both feature AND component backlinks for bidirectional consistency
- Validate all referenced FEAT-#### and COMP-#### IDs exist
- If selecting multiple components, ask which is primary for the index table
- Arrays must be valid YAML/JSON format
- source_paths should be relative to repository root
- No duplicates in backlink arrays
