Plan or edit the Charter tier overview document cooperatively.

**Before starting:** Read [spec/agent-guide.md](../spec/agent-guide.md) for a quick reference to the Charter tier's role in the four-tier specification system.

**What this command does:**
1. Creates or loads the charter overview document (system-charter.md)
2. Works cooperatively with user to fill in or refine charter sections
3. Initializes charter index if needed
4. Suggests next steps (creating features with /spec-feature)

**Usage:**
```
/spec-plan-charter        # Create new or edit existing charter
```

---

**Implementation instructions for Claude Code:**

## Overview: Cooperative Planning Philosophy

This command supports **cooperative planning** for the Charter tier. The approach is:

1. **Get high-level context first** - Understand the user's overall vision before diving into details
2. **Ask informed questions** - Use context to ask smart, specific questions (not just reading from a script)
3. **Go section by section** - Work through charter template systematically but allow natural conversation flow
4. **Suggest additions** - Proactively suggest relevant sections the template might not cover
5. **Show and confirm** - Present drafted content frequently and ask for user confirmation/refinement

## When Invoked

### Phase 1: Determine Mode

1. **Try to load existing charter:**
   - Try to open `spec/charter/system-charter.md`
   - If found, use **EDIT MODE**
   - If not found, use **CREATE MODE**

2. **Try to load charter index:**
   - Try to open `spec/charter/index.md`
   - If not found, will need to initialize in CREATE mode

3. **If neither exists:**
   - Check for templates (`spec/charter/system-charter-template.md` and `spec/charter/index-template.md`)
   - If templates missing, inform user to run `install.sh` first

### Phase 2A: CREATE MODE - New Charter

If charter doesn't exist, create it cooperatively:

1. **Initialize charter tier if needed:**
   - If `spec/charter/index.md` doesn't exist:
     ```
     Charter tier not initialized. Initializing...

     ✓ Created spec/charter/index.md
     ✓ Set next_feature_id: FEAT-0001
     ```

2. **Get high-level context first:**
   ```
   Let's create your system charter. I'll work with you to fill in the details.

   Before we dive into specifics, help me understand the big picture:
   - What is the system name?
   - What problem does this system solve?
   - Who are the primary users?
   - What are the 2-3 most important capabilities it must provide?
   ```

3. **Work section by section through the charter template:**

   Load `spec/charter/system-charter-template.md` to understand the structure.

   **Section 1: Metadata** (YAML front matter)
   - Set `id: SYS-CHARTER`
   - Set `status: draft`
   - Set `last_updated` to today's date (YYYY-MM-DD)

   **Section 2: System Overview**
   - Based on high-level context, draft the system overview
   - Show to user and ask for confirmation/refinement
   - Ask informed questions like:
     - "You mentioned [problem] - are there any specific pain points this addresses?"
     - "For [users], what's their typical workflow that this system will support?"

   **Section 3: Feature Roadmap**
   - Based on capabilities mentioned in high-level context, draft initial feature roadmap
   - Organize by priority or theme
   - Show to user and ask: "Does this capture the main capabilities? Any additions or changes?"

   **Section 4: Success Criteria**
   - Ask about metrics and goals:
     - "How will you measure success for this system?"
     - "Are there specific performance, adoption, or business metrics you're targeting?"
   - Draft success criteria based on responses

   **Section 5: Constraints & Dependencies**
   - Ask about constraints:
     - "Are there technology constraints? (existing systems, required integrations, compliance)"
     - "Timeline or budget constraints we should document?"
   - Draft constraints section

   **Section 6: Out of Scope**
   - Based on what IS in scope, ask:
     - "What are things this system will explicitly NOT do?"
     - "Any common requests or features you want to exclude?"
   - Draft out-of-scope section

4. **Suggest custom sections:**
   ```
   The template covers the standard sections. Based on your [domain/approach],
   are there other aspects we should document? For example:
   - [Specific suggestion 1 based on context]
   - [Specific suggestion 2 based on context]
   ```

5. **Final review:**
   - Show complete charter structure
   - Ask for final confirmation before saving

6. **Save charter:**
   ```
   1. Copy spec/charter/system-charter-template.md → spec/charter/system-charter.md
   2. Replace all {{placeholder}} values with user-provided content
   3. Set status: draft
   4. Set last_updated to today's date
   5. Save the file

   ✓ Created spec/charter/system-charter.md
   ```

7. **Suggest next steps:**
   ```
   Charter overview complete! ✓

   Next steps:
   1. Define individual features for each capability area: /spec-feature
   2. Check planning status: /spec-plan

   Some suggested features based on your charter:
   - [Feature area 1 from Section 3]
   - [Feature area 2 from Section 3]
   - [Feature area 3 from Section 3]

   Ready to create the first feature?
   ```

### Phase 2B: EDIT MODE - Existing Charter

If charter exists, help user edit it:

1. **Load and show current charter:**
   ```
   Loaded spec/charter/system-charter.md

   Current charter:
   - System: [name]
   - Status: [status]
   - Last updated: [date]

   Sections:
   [List main section headings and brief content summary]

   What would you like to update?
   - Specific section (e.g., "Feature Roadmap", "Success Criteria")
   - Add new section
   - Update metadata (status, etc.)
   - Review and refine entire charter
   ```

2. **Cooperative editing:**
   - If user wants to update specific section:
     - Show current content
     - Ask what changes they want
     - Work cooperatively to refine
     - Update `last_updated` date

   - If user wants to add section:
     - Ask about section purpose and content
     - Draft section
     - Show and confirm
     - Insert in appropriate location

   - If user wants to review/refine entire charter:
     - Go section by section
     - For each section, show current content and ask if changes needed
     - Apply changes cooperatively

3. **Save updates:**
   ```
   ✓ Updated spec/charter/system-charter.md
   ✓ Updated last_updated to [today's date]

   [If content significantly changed:]
   Note: Your charter has been updated. Run /spec-plan to check if
   any feature discrepancies were introduced or resolved.
   ```

## Important Notes

**Context Management:**
- Load ONLY the charter overview and index
- DO NOT load individual FEAT-#### files unless user specifically requests editing one
- Keep focus on the overview document

**Cooperative Approach:**
- Ask informed questions based on context, not scripted prompts
- Suggest relevant additions beyond the template based on domain/industry
- Show work frequently and ask for confirmation
- Allow natural conversation flow - don't be rigid about section order

**Smart Suggestions:**
- Based on domain (e.g., e-commerce, SaaS, data pipeline), suggest relevant sections
- Based on scale (e.g., "millions of users"), suggest performance/scalability criteria
- Based on compliance mentions (e.g., HIPAA, GDPR), suggest security/privacy sections

**After Completion:**
- Always suggest creating individual features with /spec-feature
- Suggest running /spec-plan to check overall status
- Provide 2-3 concrete feature suggestions based on charter content

## Example Interaction - CREATE MODE

```
User: /spec-plan-charter

Claude: Let's create your system charter. I'll work with you to fill in the details.

Before we dive into specifics, help me understand the big picture:
- What is the system name?
- What problem does this system solve?
- Who are the primary users?
- What are the 2-3 most important capabilities it must provide?

User: It's called "RecipeFlow". Food manufacturers need to analyze recipes,
production costs, and run what-if scenarios. Users are product managers
and operations teams. Main capabilities: recipe management, cost analysis,
and scenario testing.

Claude: Great context! So RecipeFlow helps food manufacturers optimize their
recipes and production through analysis and modeling.

Let me draft Section 2 (System Overview) based on what you shared:

---
## 2. System Overview

RecipeFlow is a recipe and production analysis system designed for food
manufacturing organizations. It enables product managers and operations
teams to manage recipes, analyze production costs, and model what-if
scenarios to optimize product formulations and manufacturing efficiency.

**Problem Statement:** Food manufacturers currently lack integrated tools
to analyze recipe costs, model ingredient substitutions, and evaluate
production scenarios in a unified system.

**Target Users:**
- Product Managers: Recipe optimization and cost analysis
- Operations Teams: Production planning and scenario modeling
---

Does this capture it correctly? Any changes?

[User confirms or refines]

Claude: Excellent! Now let's talk about your feature roadmap...

[Continues section by section...]

[After all sections complete:]

Here's your complete charter structure:
- Section 2: System Overview ✓
- Section 3: Feature Roadmap (3 capability areas) ✓
- Section 4: Success Criteria (5 metrics) ✓
- Section 5: Constraints (tech stack, timeline) ✓
- Section 6: Out of Scope (retail sales, mobile apps) ✓

Ready to save this?

[User confirms]

✓ Created spec/charter/system-charter.md
✓ Charter tier initialized

Charter overview complete! ✓

Next steps:
1. Define individual features: /spec-feature
2. Check planning status: /spec-plan

Suggested features based on your charter:
- Recipe Management & Versioning
- Production Cost Analysis
- What-If Scenario Modeling

Ready to create the first feature?
```

## Example Interaction - EDIT MODE

```
User: /spec-plan-charter

Claude: Loaded spec/charter/system-charter.md

Current charter:
- System: RecipeFlow
- Status: draft
- Last updated: 2025-11-15

Sections:
- System Overview: Food manufacturing recipe and cost analysis system
- Feature Roadmap: 3 capability areas defined
- Success Criteria: 5 metrics (adoption, performance, cost savings)
- Constraints: Tech stack (Python, PostgreSQL), 6-month timeline
- Out of Scope: Retail sales, mobile apps

What would you like to update?

User: Add a section about compliance requirements - we need FDA 21 CFR Part 11

Claude: Good catch - that's important for food manufacturing systems.
Let me draft a Compliance & Regulatory section:

---
## 7. Compliance & Regulatory Requirements

**FDA 21 CFR Part 11:**
The system must comply with FDA 21 CFR Part 11 requirements for electronic
records and electronic signatures, including:
- Audit trails for all recipe and formulation changes
- User authentication and access controls
- Data integrity and validation
- Secure electronic signatures for recipe approvals

**Additional Considerations:**
- All recipe versions must be retained with complete audit history
- Changes to approved recipes require re-validation workflow
---

Does this capture your compliance requirements? Any other regulations to add?

[User confirms or refines]

✓ Added Section 7: Compliance & Regulatory Requirements
✓ Updated spec/charter/system-charter.md
✓ Updated last_updated to 2025-11-19

Note: This may affect your feature roadmap. Consider adding:
- Audit Trail & Compliance Logging feature
- Electronic Signature Workflow feature

Run /spec-plan to check overall status.
```

## Related Commands

- **`/spec-plan`** - Check overall planning status across all tiers
- **`/spec-feature`** - Create individual feature specifications based on charter
- **`/spec-plan-arch`** - Plan architecture overview (after charter complete)
