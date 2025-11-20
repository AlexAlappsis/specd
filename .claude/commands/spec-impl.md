Create a new implementation specification (IMPL-####) or edit an existing one.

> _New to the spec system? See [spec/agent-guide.md](../spec/agent-guide.md) for a quick reference to the four-tier structure and how implementations fit into the Implementation tier._

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
     - Copy `spec/implementation/index-template.md` → `spec/implementation/index.md`
     - Copy `spec/implementation/overview-template.md` → `spec/implementation/overview.md` (if template exists)
     - Set initial `next_impl_id: IMPL-0001`
     - Set `last_updated` to today's date (YYYY-MM-DD)
     - Remove any example rows from implementation table
     - Inform user: "Implementation tier initialized. Creating first implementation..."
   - Extract `next_impl_id` from front matter
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
   - Source code paths relative to component's repo_location (e.g., ["src/Api/Users", "src/Domain/UserManagement"])

4. **Review error handling & edge cases cooperatively:**
   - Based on the implementation description, draft potential edge cases for Section 5 across multiple categories:
     - Validation errors (invalid inputs, malformed data, constraint violations)
     - Error conditions (network failures, timeouts, dependency unavailable, permission denied)
     - Boundary values (empty collections, null/zero values, maximum limits)
     - Concurrent operations (race conditions, conflicting updates, deadlocks)
     - State transitions (invalid state changes, partial failures, rollback scenarios)
     - Data integrity (duplicate entries, orphaned records, referential integrity)
   - Present the drafted edge cases to the user
   - Ask the user:
     - "Are these error handling approaches and edge cases accurate and complete?"
     - "Are there additional edge cases I should include?"
     - "Should any of these be removed or modified?"
   - Incorporate user feedback before finalizing Section 5

5. **Review testing strategy cooperatively:**
   - Check `spec/implementation/overview.md` for the project's general testing approach
   - Based on the implementation details and project testing strategy, draft a testing strategy for Section 7:
     - **If tests are needed:**
       - Test types needed (unit, integration, contract, e2e, performance)
       - Test file locations relative to component's repo_location
       - Critical scenarios to cover (happy path, error cases, edge cases)
       - Test data and mocking requirements
       - Coverage requirements
     - **If no tests are needed:**
       - Explain why (e.g., "Testing handled at integration tier", "Simple pass-through layer", "Covered by component-level tests")
       - Reference where testing occurs instead
   - Present the draft testing strategy to the user
   - Ask the user:
     - "Does this testing strategy align with the project's approach?"
     - "Are tests needed for this implementation, or is testing handled elsewhere?"
     - "If tests are needed, does this cover all critical scenarios?"
     - "Are there additional test requirements or constraints?"
   - Incorporate user feedback before finalizing Section 7
   - **Note:** "No tests needed" is a valid strategy when justified

6. **Handle open questions cooperatively:**
   - Based on the discussion so far, draft 2-6 potential open questions for Section 8
   - Present these draft questions to the user
   - Ask the user:
     - "Do you have answers to any of these questions?"
     - "Should any be removed or rephrased?"
     - "Do you have additional open questions to add?"
   - Only include questions in the final document that the user confirms should remain open
   - If the user answers a question during this discussion, incorporate the answer into the appropriate section instead of leaving it as an open question

7. **Review auto-generated sections:**
   - Based on the implementation context, draft content for Section 6 (Performance & Constraints):
     - Typical and worst-case usage patterns
     - Constraints like timeouts, max sizes, or rate limits
   - Present this section to the user for confirmation
   - Ask: "I've drafted performance and constraints based on our discussion. Are these accurate, or should anything be added/removed?"
   - Incorporate user feedback before finalizing

8. **Generate implementation slug:**
   - Convert name to kebab-case
   - Create filename: `IMPL-####-{slug}.md`

9. **Create implementation file:**
   - Copy `spec/implementation/contracts/impl-item-template.md`
   - Save to `spec/implementation/contracts/IMPL-####-{slug}.md`
   - Replace all {{placeholder}} values:
     - `{{id}}` → assigned IMPL-#### ID
     - `{{title}}` → user-provided name
     - `{{summary}}` → user-provided summary
     - `{{status}}` → "draft"
     - `{{last_updated}}` → today's date
     - `{{features}}` → array of selected FEAT-#### IDs
     - `{{components}}` → array of selected COMP-#### IDs
     - `{{source_paths}}` → user-provided source paths array (relative to component's repo_location)
     - `{{notes}}` → ""
   - Fill in Section 5 (Error Handling & Edge Cases) with user-confirmed edge cases
   - Fill in Section 6 (Performance & Constraints) with user-confirmed content
   - Fill in Section 7 (Testing Strategy) with user-confirmed testing strategy
   - Fill in Section 8 (Open Questions & TODOs) with only the questions user confirmed should remain open

10. **Update implementation index:**
   - Add new row to implementation table
   - Use primary component in "Primary Component" column
   - List features in "Primary Features" column
   - Keep sorted by ID
   - Increment `next_impl_id`
   - Update `last_updated`

11. **Update feature backlinks (CRITICAL):**
   - For each FEAT-#### in implementations features[] array:
     - Open `spec/charter/features/FEAT-####-*.md`
     - Add this IMPL-#### to implementations[] array in front matter
     - Update `last_updated`

12. **Update component backlinks (CRITICAL):**
   - For each COMP-#### in implementations components[] array:
     - Open `spec/architecture/components/COMP-####-*.md`
     - Add this IMPL-#### to implementations[] array in front matter
     - Update `last_updated`

13. **Report completion:**
    - Display created file path
    - Show assigned IMPL-#### ID
    - List updated feature and component files (backlinks)
    - Suggest next steps:
      - "Edit the implementation file to define contracts, APIs, and data models"
      - "Fill in Section 7 (Testing Strategy) to define test requirements"
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
   - Features: ["FEAT-0002", "FEAT-0005"]
   - Components: ["COMP-0003"]
   - Source paths: ["src/Api/Users", "src/Controllers/AuthController"] (relative to COMP-0003's repo_location)

   What would you like to update? (You can update multiple fields)
   ```

3. **Prompt for changes:**
   - Ask what the user wants to change
   - For array fields (features, components, source_paths):
     - Ask if they want to add or remove IDs/paths
     - Validate IDs exist before adding
   - For content sections (including Section 7 - Testing Strategy), ask if they want to replace or append

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

Creating IMPL-0007-user-api-endpoints.md...
✓ Created spec/implementation/contracts/IMPL-0007-user-api-endpoints.md
✓ Updated spec/implementation/index.md
✓ Updated spec/charter/features/FEAT-0002-user-management.md (added IMPL-0007)
✓ Updated spec/charter/features/FEAT-0005-user-authentication.md (added IMPL-0007)
✓ Updated spec/architecture/components/COMP-0003-user-service.md (added IMPL-0007)
✓ Incremented next_impl_id to IMPL-0008

Next steps:
- Edit spec/implementation/contracts/IMPL-0007-user-api-endpoints.md to define:
  - Public contracts (APIs, interfaces)
  - Data models and types
  - Business rules and invariants
  - Testing strategy (Section 7)
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
- source_paths should be relative to the component's repo_location field
- No duplicates in backlink arrays
- Testing strategy is documented inline in Section 7 of each IMPL spec
- Testing hierarchy: architecture/stack-overview.md → implementation/overview.md → IMPL-#### (Section 7)
