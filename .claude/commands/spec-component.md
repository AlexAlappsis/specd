Create a new architecture component specification (COMP-####) and update cross-tier links.

**What this command does:**
1. Auto-assigns next available COMP-#### ID
2. Creates new component file from template
3. Updates architecture index with new entry
4. Updates referenced feature files with bidirectional links
5. Increments next_component_id

**Usage:**
```
/spec-component
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

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

4. **Generate component slug:**
   - Convert name to kebab-case
   - Create filename: `COMP-####-{slug}.md`

5. **Create component file:**
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

6. **Update architecture index:**
   - Add new row to component table
   - Keep sorted by ID
   - Increment `next_component_id`
   - Update `last_updated`

7. **Update feature backlinks (CRITICAL):**
   - For each FEAT-#### in the component's features[] array:
     - Open `spec/charter/features/FEAT-####-*.md`
     - Find the `components:` array in front matter
     - Add this COMP-#### ID if not already present
     - Ensure array is valid YAML format
     - Update `last_updated` field
   - This creates bidirectional links: FEAT ↔ COMP

8. **Report completion:**
   - Display created file path
   - Show assigned COMP-#### ID
   - List updated feature files (backlinks)
   - Suggest next steps:
     - "Use /spec-impl to create implementation specs for this component"
     - "Run /spec-sync to validate all cross-tier links"

**Example interaction:**
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

**Important notes:**
- MUST update feature backlinks to maintain bidirectional consistency
- Validate that all referenced FEAT-#### IDs exist before creating links
- Validate that all referenced COMP-#### dependencies exist
- Arrays must be valid YAML/JSON format (use square brackets and quotes)
- If a feature file already has this COMP-#### in its components array, skip it (no duplicates)
