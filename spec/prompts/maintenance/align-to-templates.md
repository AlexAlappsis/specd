# Align Existing Specs to Updated Templates

> You are helping migrate existing specification documents to match the current template structure.
>
> This is a one-time migration operation performed when templates have been updated but existing specs were created with older template versions.

## When to Use This Prompt

Use this prompt when:
- Templates have been updated with new sections or structure
- You have existing specs that don't match current template format
- You want to ensure consistency across all specs
- You need to migrate to new template features (like glossary support)

## Migration Process

### Phase 1: Discovery and Selection

1. **Ask which specs to migrate:**
   ```
   Which specification documents would you like to align to current templates?

   Available options:
   - Charter overview (spec/charter/system-charter.md)
   - Charter index (spec/charter/index.md)
   - Charter features (individual FEAT-#### files)
   - Architecture overview (spec/architecture/stack-overview.md)
   - Architecture index (spec/architecture/index.md)
   - Architecture components (individual COMP-#### files)
   - Implementation overview (spec/implementation/overview.md)
   - Implementation index (spec/implementation/index.md)
   - Implementation specs (individual IMPL-#### files)
   - Task backlog (spec/tasks/backlog.md)
   - Task index (spec/tasks/index.md)
   - Task items (individual TASK-#### files)
   - Glossary (spec/glossary.md)

   You can specify:
   - Specific documents: "charter overview, architecture overview"
   - Entire tiers: "all charter tier", "all architecture tier"
   - Individual specs: "FEAT-0001, COMP-0003"
   - Everything: "all specs"
   ```

2. **Confirm scope:**
   - List the files to be migrated
   - Estimate number of files affected
   - Ask for confirmation before proceeding

### Phase 2: Template Analysis

For each selected document type:

1. **Load current template:**
   - Read the corresponding `-template.md` file
   - Parse YAML front matter structure
   - Identify all sections and their expected structure

2. **Load existing spec:**
   - Read the user's current spec file
   - Parse existing YAML front matter
   - Identify existing sections

3. **Compare and identify changes:**
   - New fields in YAML front matter
   - Removed or renamed fields
   - New sections added to template
   - Reordered sections
   - Changed section headings or structure

4. **Show comparison summary:**
   ```
   spec/charter/system-charter.md vs. system-charter-template.md

   YAML Front Matter Changes:
   + notes: "" (new field for decision rationale)

   Section Changes:
   + Section 7: Glossary References (new section)
   ~ Section 4: Success Criteria (heading changed from "Metrics")

   No fields removed or incompatible changes detected.
   ```

### Phase 3: Content Migration

For each document:

1. **Create migration plan:**
   - Map existing content to new template structure
   - Identify any content that needs to be preserved but doesn't fit new structure
   - Note any new required fields that need user input

2. **Show proposed migration:**
   ```
   Proposed migration for spec/charter/system-charter.md:

   YAML Front Matter:
   ---
   id: SYS-CHARTER
   title: RecipeFlow System Charter
   status: draft
   last_updated: 2025-11-19  # Will update to today
   + notes: ""  # New field - will add empty
   ---

   Section 1: System Overview
   [Content preserved as-is]

   Section 2: Feature Roadmap
   [Content preserved as-is]

   ...

   + Section 7: Glossary References
   [New section - will add with placeholder text]

   Does this migration look correct?
   ```

3. **Ask for confirmation:**
   - Show complete migrated content if document is small
   - Show summary of changes if document is large
   - Ask: "Should I proceed with this migration?"

4. **Apply migration:**
   - Update YAML front matter
   - Reorganize sections to match template
   - Add new sections with appropriate placeholder text
   - Preserve all existing content
   - Update `last_updated` to today
   - Save file

### Phase 4: Glossary Extraction (Optional)

After migrating overview documents:

1. **Scan for domain-specific terms:**
   - Review migrated charter overview for domain terms
   - Review migrated architecture overview for technical terms
   - Review migrated implementation overview for technical terms

2. **Suggest glossary creation:**
   ```
   I noticed these domain/technical terms in your migrated specs:

   From Charter:
   - Recipe, Formulation, Batch, SKU, Yield

   From Architecture:
   - Modular Monolith, CQRS, Event Sourcing

   Would you like to create a glossary and define these terms?
   (You can use /spec-glossary add [term] for each)
   ```

## Migration Strategy by Document Type

### Overview Documents (system-charter.md, stack-overview.md, overview.md)

- **Priority:** HIGH - These are foundational
- **Approach:** Careful section-by-section migration
- **Validation:** Ensure all template sections present

### Index Documents (index.md files)

- **Priority:** MEDIUM - Structure is critical for commands
- **Approach:**
  - Migrate YAML front matter
  - Ensure table structure matches template
  - Preserve all existing rows
  - Add permanent example rows below table (if new in template)
- **Validation:** Verify `next_*_id` field is correct

### Individual Specs (FEAT-####, COMP-####, IMPL-####, TASK-####)

- **Priority:** MEDIUM - These accumulate over time
- **Approach:**
  - Batch process similar specs together
  - Show first example migration for approval
  - Apply same pattern to remaining specs
- **Validation:** Ensure cross-tier links preserved

### Glossary

- **Priority:** LOW - Optional but helpful
- **Approach:**
  - If doesn't exist, suggest creating after migration
  - If exists, ensure format matches template
  - Verify alphabetical sorting

## Important Safeguards

1. **Never delete content:**
   - If content doesn't fit new structure, preserve it in notes or comments
   - Ask user where to place orphaned content

2. **Preserve IDs and links:**
   - Never change ID values
   - Never remove cross-tier link arrays
   - Verify all links still valid after migration

3. **Confirm before saving:**
   - Always show proposed changes
   - Always wait for user approval
   - Never batch-apply without showing first example

4. **Update timestamps:**
   - Update `last_updated` to today's date
   - Don't modify other metadata unless necessary

## Example Interaction

```
User: I need to migrate my charter and architecture overviews to the new templates

Agent: I'll help you align your existing specs to the current templates.

Let me check what you have:
- spec/charter/system-charter.md ✓ (exists)
- spec/architecture/stack-overview.md ✓ (exists)

Would you also like to migrate:
- Charter index (spec/charter/index.md)?
- Architecture index (spec/architecture/index.md)?
- Individual features or components?

User: Just the two overviews for now

Agent: Perfect. Let me analyze the current templates and your existing specs.

[Reads system-charter-template.md and system-charter.md]
[Reads stack-overview-template.md and stack-overview.md]

### Charter Overview Migration

Comparison: spec/charter/system-charter.md vs. system-charter-template.md

YAML Changes:
+ notes: "" (new field for decision rationale)

Section Changes:
No structural changes - your charter already matches template structure!

Minor updates:
- Will update last_updated to 2025-11-19
- Will add empty notes field

### Architecture Overview Migration

Comparison: spec/architecture/stack-overview.md vs. stack-overview-template.md

YAML Changes:
+ notes: "" (new field)

Section Changes:
+ Section 8: Related Documentation (new section)

Migration plan:
- Add notes field to YAML
- Add new Section 8 with links to related specs
- Update last_updated to 2025-11-19

Does this look correct? Should I proceed?

User: Yes

Agent:
✓ Migrated spec/charter/system-charter.md
✓ Migrated spec/architecture/stack-overview.md

Both files now match current template structure.

I noticed these domain terms in your specs:
- Recipe, Batch, Formulation, SKU (from charter)
- Modular Monolith, FastAPI, SQLAlchemy (from architecture)

Would you like to create a glossary to define these terms?
You can use: /spec-glossary add Recipe
```

## Agent Notes

- **Be systematic:** Process each document thoroughly
- **Preserve content:** Never lose user's existing work
- **Show changes:** Always display what will change before applying
- **Respect structure:** Match template exactly, but preserve semantic content
- **Suggest improvements:** After migration, suggest glossary creation if terms found
- **Batch carefully:** When migrating multiple specs, show first example before continuing
- **Validate links:** After migration, remind user to run `/spec-sync`

## Related Operations

After migration:
- Run `/spec-sync` to validate cross-tier links
- Use `/spec-glossary` to define domain terms
- Use `/spec-plan` to check overall status
- Consider creating any missing indexes if templates now require them