Create a new feature specification (FEAT-####) or edit an existing one.

> _New to the spec system? If you haven't already in this conversation, see [spec/agent-guide.md](../spec/agent-guide.md) for a quick reference to the four-tier structure and how features fit into the Charter tier._

**What this command does:**
1. **Create mode:** Auto-assigns next FEAT-#### ID and creates new feature from template
2. **Edit mode:** Loads existing feature by ID and cooperatively updates it
3. Updates charter index and maintains cross-tier links

**Usage:**
```
/spec-feature              # Create new feature
/spec-feature FEAT-0005    # Edit existing feature
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

## Mode Detection

First, determine if this is CREATE or EDIT mode:

1. **Check for ID argument:**
   - If user provides FEAT-#### ID (e.g., `/spec-feature FEAT-0005`), use EDIT mode
   - If no argument provided, use CREATE mode

2. **In EDIT mode:**
   - Validate ID format (FEAT-NNNN)
   - Search for file matching pattern `spec/charter/features/FEAT-####-*.md`
   - If not found, inform user and ask if they want to create a new feature instead
   - If found, proceed with editing workflow

## CREATE Mode Workflow

1. **Load charter index:**
   - Try to open `spec/charter/index.md`
   - If file not found:
     - Inform user: "Charter tier not found. Please run /spec-plan first to set up your system charter and create the charter index before creating individual features."
     - Exit without creating anything
   - Extract `next_feature_id` from front matter (e.g., `FEAT-0005`)
   - Parse existing feature table to understand current features

2. **Prompt user for feature details:**
   - Feature title (short, descriptive name)
   - Brief summary (one-line description)
   - Detailed description (what does this feature do?)
   - User stories or use cases (optional)
   - Success metrics (optional)

3. **Review edge cases cooperatively:**
   - Based on the feature description, draft potential edge cases across multiple categories:
     - Validation/Constraints (empty inputs, invalid formats, size limits)
     - Error Conditions (network failures, timeouts, missing dependencies)
     - Boundary Values (first/last item, zero/negative values, maximum limits)
     - Concurrent Operations (simultaneous edits, race conditions)
     - State Transitions (feature disabled mid-operation, data deleted while in use)
     - Data Integrity (partial updates, orphaned records, duplicates)
   - Present the drafted edge cases to the user
   - Ask the user:
     - "Are these edge cases accurate and complete?"
     - "Are there additional edge cases I should include?"
     - "Should any of these be removed or modified?"
   - Incorporate user feedback before finalizing Section 3.2

4. **Handle open questions cooperatively:**
   - Based on the discussion so far, draft 2-6 potential open questions
   - Present these draft questions to the user
   - Ask the user:
     - "Do you have answers to any of these questions?"
     - "Should any be removed or rephrased?"
     - "Do you have additional open questions to add?"
   - Only include questions in the final document that the user confirms should remain open
   - If the user answers a question during this discussion, incorporate the answer into the appropriate section instead of leaving it as an open question

5. **Review auto-generated sections:**
   - Based on the charter context and feature discussion, draft content for sections not explicitly discussed:
     - Section 5 (Dependencies & Interactions) - related features, external integrations
     - Section 6 (Non-Goals / Exclusions) - what's explicitly out of scope
   - Present these sections to the user for confirmation
   - Ask: "I've drafted the following sections based on our discussion. Are these accurate, or should anything be added/removed?"
   - Incorporate user feedback before finalizing

6. **Generate feature slug:**
   - Convert title to kebab-case (e.g., "User Authentication" → "user-authentication")
   - Create filename: `FEAT-####-{slug}.md`

7. **Create feature file:**
   - Copy `spec/charter/features/feature-template.md`
   - Save to `spec/charter/features/FEAT-####-{slug}.md`
   - Replace all {{placeholder}} values:
     - `{{id}}` → assigned FEAT-#### ID
     - `{{title}}` → user-provided title
     - `{{summary}}` → user-provided summary
     - `{{status}}` → "draft"
     - `{{last_updated}}` → today's date (YYYY-MM-DD)
     - `{{notes}}` → "" (empty, user can fill later)
     - `{{related_features}}` → [] (empty array)
     - `{{components}}` → [] (empty array, will be filled when components are created)
     - `{{implementations}}` → [] (empty array, will be filled when implementations are created)
   - Fill in description, user stories, and success metrics from user prompts
   - Fill in Section 3.2 (Edge Cases & Exceptions) with user-confirmed edge cases
   - Fill in Section 5 (Dependencies & Interactions) with user-confirmed content
   - Fill in Section 6 (Non-Goals / Exclusions) with user-confirmed content
   - Fill in Section 7 (Open Questions) with only the questions user confirmed should remain open

8. **Update charter index:**
   - Open `spec/charter/index.md`
   - Add new row to feature table:
     ```
     | FEAT-#### | Title | Status | File path |
     ```
   - Keep table sorted by ID
   - Increment `next_feature_id` in front matter (e.g., FEAT-0005 → FEAT-0006)
   - Update `last_updated` field to today

9. **Report completion:**
   - Display created file path
   - Show assigned FEAT-#### ID
   - Suggest next steps:
     - "Edit the feature file to add more details"
     - "Use /spec-component to create architecture components for this feature"
     - "Link related features by editing the related_features array"

## EDIT Mode Workflow

When editing an existing feature:

1. **Load the feature file:**
   - Open `spec/charter/features/FEAT-####-*.md`
   - Parse front matter and content
   - Show current values to user

2. **Cooperative editing:**
   ```
   Loaded FEAT-0005: User Authentication

   Current values:
   - Title: User Authentication
   - Status: draft
   - Summary: Allow users to securely log in and manage their accounts
   - Related features: ["FEAT-0001"]
   - Components: ["COMP-0003", "COMP-0007"]
   - Implementations: ["IMPL-0008"]

   What would you like to update? (You can update multiple fields)
   - title
   - summary
   - status (draft | active)
   - description/content
   - related_features (add/remove FEAT-#### links)
   - Any other field
   ```

3. **Prompt for changes:**
   - Ask what the user wants to change
   - For array fields (related_features, components, implementations):
     - Ask if they want to add or remove IDs
     - Validate IDs exist before adding
   - For content sections, ask if they want to replace or append

4. **Update cross-tier links if needed:**
   - If components[] array changes:
     - If adding COMP-####: Add this FEAT-#### to that component's features[] array
     - If removing COMP-####: Remove this FEAT-#### from that component's features[] array
   - If implementations[] array changes:
     - If adding IMPL-####: Add this FEAT-#### to that implementation's features[] array
     - If removing IMPL-####: Remove this FEAT-#### from that implementation's features[] array
   - Always update `last_updated` in modified files

5. **Update index if needed:**
   - If title changes, update the charter index table row
   - If status changes, update the charter index table row
   - Update `last_updated` in index

6. **Report changes:**
   - Show what was updated
   - List any cross-tier link updates
   - Suggest running /spec-sync to validate consistency

**Example interactions:**

### CREATE mode:
```
User: /spec-feature

Claude: I'll help you create a new feature specification.

Feature title: User Authentication
Summary: Allow users to securely log in and manage their accounts
Description: [prompts for detailed description]
User stories: [prompts for user stories]

Creating FEAT-0005-user-authentication.md...
✓ Created spec/charter/features/FEAT-0005-user-authentication.md
✓ Updated spec/charter/index.md
✓ Incremented next_feature_id to FEAT-0006

Next steps:
- Review and edit the feature file
- Use /spec-component to define components implementing this feature
```

### EDIT mode:
```
User: /spec-feature FEAT-0005

Claude: Loaded FEAT-0005: User Authentication

Current values:
- Title: User Authentication
- Status: draft
- Summary: Allow users to securely log in and manage their accounts
- Components: ["COMP-0003"]

What would you like to update?

User: Change status to active and add COMP-0007 to components

Claude: Updating FEAT-0005...
✓ Updated status: draft → active
✓ Added COMP-0007 to components array
✓ Updated spec/charter/features/FEAT-0005-user-authentication.md
✓ Updated spec/architecture/components/COMP-0007-auth-gateway.md (added FEAT-0005 to features[])
✓ Updated spec/charter/index.md

Completed! Run /spec-sync to validate all cross-tier links.
```

**Important notes:**
- Validate ID format matches FEAT-NNNN (4 digits with leading zeros)
- Ensure all arrays are valid YAML/JSON format
- Keep table sorted by ID in index file
