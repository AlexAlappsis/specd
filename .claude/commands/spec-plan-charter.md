Plan or edit the Charter tier overview document cooperatively.

**Before starting:** Read [spec/agent-guide.md](../spec/agent-guide.md) for the Charter tier's role, ID conventions, and cross-tier traceability.

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

## Cooperative Planning Approach

1. **Get high-level context first** - Understand user's vision before diving into details
2. **Ask informed questions** - Use context to ask smart, specific questions (not scripted prompts)
3. **Go section by section** - Work through template systematically but allow natural flow
4. **Suggest additions** - Proactively suggest relevant sections beyond template
5. **Show and confirm** - Present drafted content frequently and ask for confirmation/refinement

## When Invoked

### Phase 1: Determine Mode

1. **Try to load existing charter:**
   - Open `spec/charter/system-charter.md` → **EDIT MODE**
   - Not found → **CREATE MODE**

2. **Try to load charter index:**
   - Open `spec/charter/index.md`
   - Not found → will initialize in CREATE mode

3. **If neither exists:**
   - Check for templates (`spec/charter/system-charter-template.md`, `spec/charter/index-template.md`)
   - If missing → inform user to run `install.sh`

### Phase 2A: CREATE MODE

1. **Initialize charter tier if needed:**
   ```
   Charter tier not initialized. Initializing...

   ✓ Created spec/charter/index.md
   ✓ Set next_feature_id: FEAT-0001
   ```

2. **Get high-level context:**
   ```
   Let's create your system charter. I'll work with you to fill in the details.

   Before we dive into specifics, help me understand the big picture:
   - What is the system name?
   - What problem does this system solve?
   - Who are the primary users?
   - What are the 2-3 most important capabilities it must provide?
   ```

3. **Work section by section through charter template:**

   Load `spec/charter/system-charter-template.md` for structure.

   **Section 1: Metadata (YAML)**
   - `id: SYS-CHARTER`
   - `status: draft`
   - `last_updated: YYYY-MM-DD` (today)

   **Section 2: System Overview**
   - Draft based on high-level context
   - Show and ask for confirmation/refinement
   - Ask informed follow-ups:
     - "You mentioned [problem] - any specific pain points this addresses?"
     - "For [users], what's their typical workflow this supports?"

   **Section 3: Feature Roadmap**
   - Draft initial roadmap from mentioned capabilities
   - Organize by priority or theme
   - Ask: "Does this capture the main capabilities? Any additions or changes?"

   **Section 4: Success Criteria**
   - Ask about metrics:
     - "How will you measure success?"
     - "Specific performance, adoption, or business metrics?"
   - Draft success criteria

   **Section 5: Constraints & Dependencies**
   - Ask about constraints:
     - "Technology constraints? (existing systems, integrations, compliance)"
     - "Timeline or budget constraints?"
   - Draft constraints

   **Section 6: Out of Scope**
   - Ask: "What will this system explicitly NOT do?"
   - Draft exclusions

4. **Suggest custom sections:**
   Based on domain/context, suggest relevant additions:
   - E-commerce: "Payment processing, order fulfillment?"
   - Compliance-heavy: "Regulatory requirements section?"
   - High-scale: "Performance and scalability targets?"

5. **Final review and save:**
   - Show complete structure
   - Ask for confirmation
   - Copy template → `spec/charter/system-charter.md`
   - Replace all {{placeholder}} values
   - Set status, last_updated
   - Save file

6. **Suggest next steps:**
   ```
   Charter overview complete! ✓

   Next steps:
   1. Define individual features: /spec-feature
   2. Check planning status: /spec-plan

   Suggested features based on your charter:
   - [Feature area 1 from Section 3]
   - [Feature area 2 from Section 3]
   - [Feature area 3 from Section 3]

   Ready to create the first feature?
   ```

### Phase 2B: EDIT MODE

1. **Load and show current charter:**
   ```
   Loaded spec/charter/system-charter.md

   Current charter:
   - System: [name]
   - Status: [status]
   - Last updated: [date]

   Sections:
   [List main headings with brief summary]

   What would you like to update?
   - Specific section (e.g., "Feature Roadmap", "Success Criteria")
   - Add new section
   - Update metadata (status, etc.)
   - Review and refine entire charter
   ```

2. **Cooperative editing:**
   - **Update section:** Show current → ask changes → refine → update `last_updated`
   - **Add section:** Ask purpose/content → draft → confirm → insert
   - **Review entire:** Go section by section → show → ask changes → apply

3. **Save updates:**
   ```
   ✓ Updated spec/charter/system-charter.md
   ✓ Updated last_updated to [today]

   [If significantly changed:]
   Note: Charter updated. Run /spec-plan to check for feature discrepancies.
   ```

## Context Management

- Load ONLY charter overview and index
- DO NOT load individual FEAT-#### files unless user specifically requests
- Focus on overview document

## Smart Suggestions by Domain

- **E-commerce/SaaS:** Payment, user management, subscription features
- **Data pipeline:** Data sources, transformations, scheduling
- **High-scale systems:** Performance criteria, caching, scalability
- **Compliance (HIPAA/GDPR/FDA):** Security, privacy, audit sections
- **Manufacturing:** Quality, traceability, regulatory requirements

## Example - CREATE MODE

```
User: /spec-plan-charter

Claude: Let's create your system charter.

Before we dive in:
- What is the system name?
- What problem does it solve?
- Who are the primary users?
- What are the 2-3 most important capabilities?

User: RecipeFlow. Food manufacturers need to analyze recipes, costs,
and run scenarios. Users: product managers and operations. Main capabilities:
recipe management, cost analysis, scenario testing.

Claude: Great! RecipeFlow for food manufacturing optimization.

Section 2 (System Overview) draft:

---
RecipeFlow is a recipe and production analysis system for food manufacturers.
Enables product managers and operations teams to manage recipes, analyze costs,
and model what-if scenarios to optimize formulations and efficiency.

**Problem:** Food manufacturers lack integrated tools to analyze recipe costs,
model substitutions, and evaluate production scenarios.

**Users:**
- Product Managers: Recipe optimization and cost analysis
- Operations Teams: Production planning and scenario modeling
---

Does this capture it? Any changes?

[User confirms]

Claude: Excellent! Now Section 3 (Feature Roadmap)...

[Continues sections...]

[After completion:]

✓ Created spec/charter/system-charter.md

Suggested features:
- Recipe Management & Versioning
- Production Cost Analysis
- What-If Scenario Modeling

Ready to create features with /spec-feature?
```

## Example - EDIT MODE

```
User: /spec-plan-charter

Claude: Loaded spec/charter/system-charter.md

Current: RecipeFlow, draft, last updated 2025-11-15

Sections:
- System Overview: Food manufacturing recipe/cost analysis
- Feature Roadmap: 3 capability areas
- Success Criteria: 5 metrics
- Constraints: Python/PostgreSQL, 6-month timeline
- Out of Scope: Retail sales, mobile apps

What to update?

User: Add FDA 21 CFR Part 11 compliance section

Claude: Important for food manufacturing! Draft:

---
## 7. Compliance & Regulatory

**FDA 21 CFR Part 11:**
- Audit trails for recipe changes
- User auth and access controls
- Data integrity and validation
- Electronic signatures for approvals

**Retention:**
- All recipe versions with complete audit history
- Re-validation workflow for approved recipe changes
---

Capture your requirements? Other regulations?

[User confirms]

✓ Added Section 7
✓ Updated spec/charter/system-charter.md
✓ Updated last_updated to 2025-11-19

Consider adding features:
- Audit Trail & Compliance Logging
- Electronic Signature Workflow

Run /spec-plan to check status.
```

## Related Commands

- `/spec-plan` - Check overall planning status
- `/spec-feature` - Create individual features
- `/spec-plan-arch` - Plan architecture (after charter complete)
