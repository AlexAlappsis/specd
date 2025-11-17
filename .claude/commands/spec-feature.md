Create a new feature specification (FEAT-####) in the Charter tier.

**What this command does:**
1. Auto-assigns next available FEAT-#### ID
2. Creates new feature file from template
3. Updates charter index with new entry
4. Increments next_feature_id

**Usage:**
```
/spec-feature
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Check if charter tier is initialized:**
   - Check if `spec/charter/index.md` exists (working file, not template)
   - If exists, proceed to step 3 (tier already initialized)
   - If not exists, proceed to step 2 (initialize tier)

2. **Initialize charter tier (if needed):**
   - Check if `spec/` directory exists; if not, inform user to run `install.sh` first and exit
   - Check for `spec/charter/index-template.md`; if missing, inform user to run `install.sh` first and exit
   - Copy `spec/charter/index-template.md` → `spec/charter/index.md`
   - Set initial `next_feature_id: FEAT-0001`
   - Set `last_updated` to today's date (YYYY-MM-DD)
   - Remove any example rows from feature table
   - Inform user: "Charter tier initialized. Creating first feature..."

3. **Read charter index:**
   - Open `spec/charter/index.md`
   - Extract `next_feature_id` from front matter (e.g., `FEAT-0005`)
   - Parse existing feature table to understand current features

4. **Prompt user for feature details:**
   - Feature title (short, descriptive name)
   - Brief summary (one-line description)
   - Detailed description (what does this feature do?)
   - User stories or use cases (optional)
   - Success metrics (optional)

5. **Generate feature slug:**
   - Convert title to kebab-case (e.g., "User Authentication" → "user-authentication")
   - Create filename: `FEAT-####-{slug}.md`

6. **Create feature file:**
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

7. **Update charter index:**
   - Open `spec/charter/index.md`
   - Add new row to feature table:
     ```
     | FEAT-#### | Title | Status | File path |
     ```
   - Keep table sorted by ID
   - Increment `next_feature_id` in front matter (e.g., FEAT-0005 → FEAT-0006)
   - Update `last_updated` field to today

8. **Report completion:**
   - Display created file path
   - Show assigned FEAT-#### ID
   - Suggest next steps:
     - "Edit the feature file to add more details"
     - "Use /spec-component to create architecture components for this feature"
     - "Link related features by editing the related_features array"

**Example interaction:**
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

**Important notes:**
- Always read from `./spec/` templates (copied during /spec-init)
- Write to `./spec/` working directory
- Validate ID format matches FEAT-NNNN (4 digits with leading zeros)
- Ensure all arrays are valid YAML/JSON format
- Keep table sorted by ID in index file
