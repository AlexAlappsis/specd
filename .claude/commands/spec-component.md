Create a new architecture component specification (COMP-####) or edit an existing one.

> _New to the spec system? See [spec/readme.md](../spec/readme.md) for an overview of the four-tier structure and how components fit into the Architecture tier._

**What this command does:**
1. **Create mode:** Auto-assigns next COMP-#### ID and creates new component from template
2. **Edit mode:** Loads existing component by ID and cooperatively updates it
3. Updates architecture index and maintains cross-tier links

**Usage:**
```
/spec-component              # Create new component
/spec-component COMP-0003    # Edit existing component
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

## Mode Detection

First, determine if this is CREATE or EDIT mode:

1. **Check for ID argument:**
   - If user provides COMP-#### ID (e.g., `/spec-component COMP-0003`), use EDIT mode
   - If no argument provided, use CREATE mode

2. **In EDIT mode:**
   - Validate ID format (COMP-NNNN)
   - Search for file matching pattern `spec/architecture/components/COMP-####-*.md`
   - If not found, inform user and ask if they want to create a new component instead
   - If found, proceed with editing workflow

## CREATE Mode Workflow

1. **Load architecture index (initialize if needed):**
   - Try to open `spec/architecture/index.md`
   - If file not found:
     - Try to open `spec/architecture/index-template.md`
     - If template not found, inform user to run `install.sh` first and exit
     - Copy `spec/architecture/index-template.md` → `spec/architecture/index.md`
     - Copy `spec/architecture/stack-overview-template.md` → `spec/architecture/stack-overview.md` (if template exists)
     - Set initial `next_component_id: COMP-0001`
     - Set `last_updated` to today's date (YYYY-MM-DD)
     - Remove any example rows from component table
     - Inform user: "Architecture tier initialized. Creating first component..."
   - Extract `next_component_id` from front matter
   - Parse existing component table

2. **Read available features:**
   - Try to open `spec/charter/index.md`
   - If found, list available FEAT-#### IDs for user to select from
   - If not found, inform user that no features exist yet (they can create one with /spec-feature later)

3. **Prompt user for component details:**
   - Component name (e.g., "User Service", "Web App")
   - Component type (service | web-app | worker | library | database | external-system)
   - Brief summary (one-line description)
   - Repository or location (e.g., "user-service-repo" or "frontend/web")
   - Features this component implements (select from available FEAT-#### list, can be multiple)
   - Dependencies on other components (optional, select from existing COMP-####)

4. **Handle open questions cooperatively:**
   - Based on the discussion so far, draft 2-6 potential open questions for Section 8
   - Present these draft questions to the user
   - Ask the user:
     - "Do you have answers to any of these questions?"
     - "Should any be removed or rephrased?"
     - "Do you have additional open questions to add?"
   - Only include questions in the final document that the user confirms should remain open
   - If the user answers a question during this discussion, incorporate the answer into the appropriate section instead of leaving it as an open question

5. **Review auto-generated sections:**
   - Based on the architecture context and component discussion, draft content for sections not explicitly discussed:
     - Section 5 (Operational Concerns) - deployment, scaling, failure modes
     - Section 6 (Security & Access) - auth/authz, data sensitivity, audit requirements
   - Present these sections to the user for confirmation
   - Ask: "I've drafted the following sections based on our discussion. Are these accurate, or should anything be added/removed?"
   - Incorporate user feedback before finalizing

6. **Generate component slug:**
   - Convert name to kebab-case
   - Create filename: `COMP-####-{slug}.md`

7. **Create component file:**
   - Copy `spec/architecture/components/component-template.md`
   - Save to `spec/architecture/components/COMP-####-{slug}.md`
   - Replace all {{placeholder}} values:
     - `{{id}}` → assigned COMP-#### ID
     - `{{title}}` → user-provided name
     - `{{type}}` → user-provided type
     - `{{summary}}` → user-provided summary
     - `{{status}}` → "draft"
     - `{{last_updated}}` → today's date
     - `{{repo_location}}` → user-provided repo/location
     - `{{features}}` → array of selected FEAT-#### IDs (e.g., ["FEAT-0001", "FEAT-0003"])
     - `{{depends_on_components}}` → array of dependent COMP-#### IDs or []
     - `{{implementations}}` → [] (will be filled when IMPL specs are created)
     - `{{notes}}` → ""
   - Fill in Section 5 (Operational Concerns) with user-confirmed content
   - Fill in Section 6 (Security & Access) with user-confirmed content
   - Fill in Section 8 (Open Questions & Future Work) with only the questions user confirmed should remain open

8. **Update architecture index:**
   - Add new row to component table
   - Keep sorted by ID
   - Increment `next_component_id`
   - Update `last_updated`

9. **Update feature backlinks (CRITICAL):**
   - For each FEAT-#### in the component's features[] array:
     - Open `spec/charter/features/FEAT-####-*.md`
     - Find the `components:` array in front matter
     - Add this COMP-#### ID if not already present
     - Ensure array is valid YAML format
     - Update `last_updated` field
   - This creates bidirectional links: FEAT ↔ COMP

10. **Report completion:**
   - Display created file path
   - Show assigned COMP-#### ID
   - List updated feature files (backlinks)
   - Suggest next steps:
     - "Use /spec-impl to create implementation specs for this component"
     - "Run /spec-sync to validate all cross-tier links"

## EDIT Mode Workflow

When editing an existing component:

1. **Load the component file:**
   - Open `spec/architecture/components/COMP-####-*.md`
   - Parse front matter and content
   - Show current values to user

2. **Cooperative editing:**
   ```
   Loaded COMP-0003: User Service

   Current values:
   - Title: User Service
   - Type: service
   - Status: draft
   - Summary: Backend service handling user management and authentication
   - Repository: services/user-service
   - Features: ["FEAT-0002", "FEAT-0005"]
   - Depends on: []
   - Implementations: ["IMPL-0007"]

   What would you like to update? (You can update multiple fields)
   ```

3. **Prompt for changes:**
   - Ask what the user wants to change
   - For array fields (features, depends_on_components, implementations):
     - Ask if they want to add or remove IDs
     - Validate IDs exist before adding
   - For content sections, ask if they want to replace or append

4. **Update cross-tier links if needed:**
   - If features[] array changes:
     - If adding FEAT-####: Add this COMP-#### to that feature's components[] array
     - If removing FEAT-####: Remove this COMP-#### from that feature's components[] array
   - If implementations[] array changes:
     - If adding IMPL-####: Add this COMP-#### to that implementation's components[] array
     - If removing IMPL-####: Remove this COMP-#### from that implementation's components[] array
   - Always update `last_updated` in modified files

5. **Update index if needed:**
   - If title, type, or status changes, update the architecture index table row
   - Update `last_updated` in index

6. **Report changes:**
   - Show what was updated
   - List any cross-tier link updates
   - Suggest running /spec-sync to validate consistency

**Example interactions:**

### CREATE mode:
```
User: /spec-component

Claude: I'll help you create a new component specification.

Available features:
- FEAT-0001: Core Platform
- FEAT-0002: User Management
- FEAT-0005: User Authentication

Component name: User Service
Type: service
Summary: Backend service handling user management and authentication
Repository: services/user-service
Features (select IDs): FEAT-0002, FEAT-0005
Dependencies (optional): [none]

Creating COMP-0003-user-service.md...
✓ Created spec/architecture/components/COMP-0003-user-service.md
✓ Updated spec/architecture/index.md
✓ Updated spec/charter/features/FEAT-0002-user-management.md (added COMP-0003 to components[])
✓ Updated spec/charter/features/FEAT-0005-user-authentication.md (added COMP-0003 to components[])
✓ Incremented next_component_id to COMP-0004

Next steps:
- Use /spec-impl to create implementation specifications
- Run /spec-sync to validate cross-tier links
```

### EDIT mode:
```
User: /spec-component COMP-0003

Claude: Loaded COMP-0003: User Service

Current values:
- Title: User Service
- Type: service
- Status: draft
- Features: ["FEAT-0002", "FEAT-0005"]
- Implementations: []

What would you like to update?

User: Change status to active and add IMPL-0007

Claude: Updating COMP-0003...
✓ Updated status: draft → active
✓ Added IMPL-0007 to implementations array
✓ Updated spec/architecture/components/COMP-0003-user-service.md
✓ Updated spec/implementation/contracts/IMPL-0007-user-api-endpoints.md (added COMP-0003 to components[])
✓ Updated spec/architecture/index.md

Completed! Run /spec-sync to validate all cross-tier links.
```

**Important notes:**
- MUST update feature backlinks to maintain bidirectional consistency
- Validate that all referenced FEAT-#### IDs exist before creating links
- Validate that all referenced COMP-#### dependencies exist
- Arrays must be valid YAML/JSON format (use square brackets and quotes)
- If a feature file already has this COMP-#### in its components array, skip it (no duplicates)
