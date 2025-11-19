Cooperatively plan and refine system specifications across all tiers (Charter, Architecture, Implementation).

**Before starting:** Read [spec/readme.md](../spec/readme.md) to understand the four-tier specification system (Charter, Architecture, Implementation, Tasks), ID conventions, and how cross-tier traceability works.

**What this command does:**
1. Initializes tiers if needed (creates working files from templates)
2. Loads overview documents and indexes for all tiers
3. Determines which tiers need planning or updates
4. Works cooperatively with user to fill in sections tier-by-tier
5. Supports editing existing overviews and adding specifics
6. Maintains separation between tier planning (Charter → Architecture → Implementation)

**Prerequisites:**
- Run `install.sh` script first to copy templates and commands to project root
- The `spec/` directory with templates must exist

**Usage:**
```
/spec-plan
```

---

**Implementation instructions for Claude Code:**

## Overview: Cooperative Planning Philosophy

This command supports **cooperative planning** where you work with the user to thoughtfully fill in specification documents. The approach is:

1. **Get high-level context first** - Understand the user's overall vision before diving into details
2. **Ask informed questions** - Use context to ask smart, specific questions (not just reading from a script)
3. **Go section by section** - Work through templates systematically but allow natural conversation flow
4. **Suggest additions** - Proactively suggest relevant sections the template might not cover
5. **Tier separation** - Keep tiers well-defined; complete one tier before moving to the next
6. **Support iteration** - Allow editing and refinement at any stage

## When Invoked

### Phase 1: Load Context Progressively

Load context **by tier**, stopping when you find incomplete work:

1. **Load Charter tier:**
   - Try to open `spec/charter/system-charter.md`
   - If not found, try `spec/charter/system-charter-template.md`
   - **If template not found:** Inform user to run `install.sh` first and exit with error message:
     ```
     Error: Templates not found. Please run the install script first:

     bash .specdocs/install.sh

     This will copy templates to your project's spec/ directory.
     ```
   - Try to open `spec/charter/index.md`
   - If not found, try `spec/charter/index-template.md`
   - **If template not found:** Same error message as above
   - Parse index to see which features exist (count only, don't load individual files)

2. **If Charter exists, load Architecture tier:**
   - Try to open `spec/architecture/stack-overview.md`
   - If not found, try `spec/architecture/stack-overview-template.md`
   - Try to open `spec/architecture/index.md`
   - If not found, try `spec/architecture/index-template.md`
   - Parse index to see which components exist (count only)

3. **If Architecture exists, load Implementation tier:**
   - Try to open `spec/implementation/overview.md`
   - If not found, try `spec/implementation/overview-template.md`
   - Try to open `spec/implementation/index.md`
   - If not found, try `spec/implementation/index-template.md`
   - Parse index to see which implementations exist (count only)

**DO NOT load individual FEAT-####, COMP-####, IMPL-####, or IMPL-####-TESTS files unless specifically needed for editing.**

### Phase 2: Determine Current State

Based on what you loaded, determine:

1. **Which overviews exist and are complete?**
   - A document is "complete" if it has no {{placeholder}} values
   - A document is "incomplete" if it has {{placeholder}} values or missing sections

2. **What's the current tier status?**
   - Charter: not started | incomplete | complete
   - Architecture: not started | incomplete | complete
   - Implementation: not started | incomplete | complete

3. **What specifics exist?**
   - X features (FEAT-####) defined
   - Y components (COMP-####) defined
   - Z implementations (IMPL-####) defined
   - W tests (TEST-####) defined

4. **Reconcile overviews with indexes:**

   For each tier where an overview exists, check if the overview and index are aligned:

   **Charter reconciliation:**
   - Parse the charter overview (`system-charter.md`) for mentions of planned features/capabilities:
     - Look in Section 2 (System Overview) for capability areas
     - Look in Section 3 (Feature Roadmap) for planned features
     - Look in Section 4 (Success Criteria) for feature-related metrics
   - Extract feature areas/capabilities mentioned in the text
   - Compare to actual features listed in `spec/charter/index.md`
   - Identify discrepancies:
     - **Mentioned but not defined:** Feature areas described in charter but no FEAT-#### exists
     - **Defined but not mentioned:** FEAT-#### exists but not referenced in charter overview
   - If discrepancies found, mark Charter as "incomplete (specifics)" even if overview has no placeholders

   **Architecture reconciliation:**
   - Parse the architecture overview (`stack-overview.md`) for mentions of components:
     - Look in Section 2 (Architecture Overview) for component descriptions
     - Look in Section 3 (Components) for component listings
     - Look in Section 4 (Data Storage) for data-related components
     - Look in Section 5 (External Integrations) for integration components
   - Extract component names/areas mentioned in the text
   - Compare to actual components listed in `spec/architecture/index.md`
   - Identify discrepancies:
     - **Mentioned but not defined:** Components described in overview but no COMP-#### exists
     - **Defined but not mentioned:** COMP-#### exists but not referenced in overview
   - If discrepancies found, mark Architecture as "incomplete (specifics)"

   **Implementation reconciliation:**
   - Parse the implementation overview (`overview.md`) for mentions of implementations:
     - Look in Section 2 (Architecture Overview) for implementation areas
     - Look in Section 3 (Implementation Structure) for specific implementations
     - Look in Section 4 (Data Models) for data-related implementations
     - Look in Section 5 (External Integrations) for integration implementations
   - Extract implementation areas mentioned in the text
   - Compare to actual implementations listed in `spec/implementation/index.md`
   - Identify discrepancies:
     - **Mentioned but not defined:** Implementation areas described but no IMPL-#### exists
     - **Defined but not mentioned:** IMPL-#### exists but not referenced in overview
   - If discrepancies found, mark Implementation as "incomplete (specifics)"

5. **Determine tier completeness status:**

   For each tier, the status is:
   - **not started:** No overview document exists
   - **incomplete (overview):** Overview exists but has {{placeholder}} values
   - **incomplete (specifics):** Overview complete but reconciliation found discrepancies
   - **complete:** Overview exists, no placeholders, and aligned with index

### Phase 3: Interactive Planning Dialog

Based on current state, engage the user:

#### Scenario A: Charter Incomplete or Missing

If charter doesn't exist at all, **initialize the charter tier first**:

```
Charter tier not found. Initializing...

[Initialize charter tier:]
1. Copy spec/charter/index-template.md → spec/charter/index.md
2. Set next_feature_id: FEAT-0001
3. Set last_updated to today's date
4. Remove example rows from feature table

✓ Charter tier initialized
```

Then proceed with cooperative planning:

```
Let's create your system charter. I'll work with you to fill in the details.

I'd like to start with some high-level questions to understand your vision:
- What is the system name?
- What problem does this system solve?
- Who are the primary users?
- What are the 2-3 most important capabilities it must provide?

[After high-level context, work section by section through the charter template]
[Use the high-level context to ask informed, specific questions]
[Suggest additional sections if relevant to this specific project]

[After completing a section, show it to the user and ask for confirmation/refinement]

[When charter sections are complete:]
1. Copy spec/charter/system-charter-template.md → spec/charter/system-charter.md
2. Replace all {{placeholder}} values with user-provided content
3. Set status: draft
4. Set last_updated to today's date
5. Save the file

✓ Created spec/charter/system-charter.md

Does the charter capture everything we need for now? Should we add any custom sections specific to your project?

[When charter is confirmed complete:]
We've completed the charter overview. Now let's define features for each capability area. Some suggested features: Market Data Management, Recipe & Production Analysis, or Scenario Testing.

To create a feature, use: `/spec-feature`
```

**If charter overview is complete but has incomplete specifics:**

```
Your charter overview is complete! ✓

However, I noticed some discrepancies between the overview and defined features:

[If features mentioned but not defined:]
✗ Feature areas mentioned in charter but not yet defined:
  - Market Data Ingestion (mentioned in Section 2.1)
  - Recipe & Production Analysis (mentioned in Section 3.2)
  - Scenario Testing (mentioned in Section 3.4)

[If features defined but not mentioned:]
✗ Features defined but not mentioned in charter overview:
  - FEAT-0003: Portfolio Risk Analysis
  - FEAT-0005: Real-time Alerting

Current state: {X} features defined, but charter mentions {Y} capability areas.

What would you like to do?
1. Create the missing features using /spec-feature
2. Update charter overview to add/remove feature areas
3. Review existing features to see which are still needed

[Based on user choice:]
- Guide to /spec-feature for creating missing features
- Or load charter for editing to align with defined features
```

#### Scenario B: Charter Complete, Architecture Incomplete or Missing

**If charter is fully complete (overview + specifics aligned):**

```
Your charter looks good! ✓

Current state: {X} features defined and aligned with charter overview.

Let's move on to architecture planning.
```

**If charter overview complete but specifics incomplete:**

First address the charter discrepancies (see Scenario A for handling), then return here once charter is complete.

**Once charter is complete,** if architecture tier doesn't exist at all, **initialize it first**:

```
Architecture tier not found. Initializing...

[Initialize architecture tier:]
1. Copy spec/architecture/index-template.md → spec/architecture/index.md
2. Set next_component_id: COMP-0001
3. Set last_updated to today's date
4. Remove example rows from component table

✓ Architecture tier initialized
```

Then proceed with cooperative planning:

```
Let's plan your system architecture. I'll work with you to define the technical approach.

Let me understand your architectural vision:
- What's the overall architectural style? (monolith, microservices, modular, etc.)
- What are the main technology choices? (languages, frameworks, databases)
- What are the major components or system boundaries?

[Work section by section through architecture template]
[Reference charter features when discussing component responsibilities]
[Suggest architectural patterns relevant to their domain]

[When architecture sections are complete:]
1. Copy spec/architecture/stack-overview-template.md → spec/architecture/stack-overview.md
2. Replace all {{placeholder}} values with user-provided content
3. Set status: draft
4. Set last_updated to today's date
5. Save the file

✓ Created spec/architecture/stack-overview.md

[When architecture is confirmed complete:]
We've completed the architecture stack overview. Now let's define components for the planned features. Some suggested components: Authentication, Database Layer, User interface screens.

To create a component, use: `/spec-component`
```

**If architecture overview is complete but has incomplete specifics:**

```
Your architecture overview is complete! ✓

However, I noticed some discrepancies between the overview and defined components:

[If components mentioned but not defined:]
✗ Components mentioned in architecture but not yet defined:
  - API Gateway (mentioned in Section 2)
  - User Service (mentioned in Section 3)
  - Analytics Engine (mentioned in Section 3)
  - PostgreSQL Database Layer (mentioned in Section 4)

[If components defined but not mentioned:]
✗ Components defined but not mentioned in architecture overview:
  - COMP-0005: Email Notification Service
  - COMP-0008: Cache Manager

Current state: {Y} components defined, but architecture mentions {Z} component areas.

What would you like to do?
1. Create the missing components using /spec-component
2. Update architecture overview to add/remove components
3. Review existing components to see which are still needed

[Based on user choice:]
- Guide to /spec-component for creating missing components
- Or load architecture for editing to align with defined components
```

#### Scenario C: Architecture Complete, Implementation Incomplete or Missing

**If charter and architecture are fully complete (overviews + specifics aligned):**

```
Charter and architecture are complete! ✓

Current state:
- {X} features defined and aligned with charter
- {Y} components defined and aligned with architecture

Let's move on to implementation planning.
```

**If architecture overview complete but specifics incomplete:**

First address the architecture discrepancies (see Scenario B for handling), then return here once architecture is complete.

**Once charter and architecture are complete,** note that implementation overview is repo-specific. Ask first:

```
Is this a single repository or multiple repositories?
- [If single] We'll create one implementation overview
- [If multiple] Which repository do you want to plan implementation for?
```

If implementation tier doesn't exist for this repo, **initialize it first**:

```
Implementation tier not found for repo "{repo-name}". Initializing...

[Initialize implementation tier:]
1. Copy spec/implementation/index-template.md → spec/implementation/index.md
2. Set next_impl_id: IMPL-0001
3. Set repo: {repo-name}
4. Set last_updated to today's date
5. Remove example rows from implementation table

✓ Implementation tier initialized for repo: {repo-name}
```

Then proceed with cooperative planning:

```
Let's plan the implementation approach for {repo-name}.

For repository "{repo-name}":
- What components (COMP-####) does this repo implement?
- What's the internal structure? (folders, layers, modules)
- What are the main implementation areas within this repo?

[Work through implementation overview template]
[Reference components and features from previous tiers]

[When implementation sections are complete:]
1. Copy spec/implementation/overview-template.md → spec/implementation/overview.md
2. Replace all {{placeholder}} values including {{repo}}
3. Set status: draft
4. Set last_updated to today's date
5. Save the file

✓ Created spec/implementation/overview.md

[When overview is confirmed complete:]
We've completed the implementation overview. Now let's add implementations for the components. Some suggested implementations: Entity Framework Context, Domain Services, API endpoints.

To create an implementation, use: `/spec-impl`
```

**If implementation overview is complete but has incomplete specifics:**

```
Your implementation overview is complete! ✓

However, I noticed some discrepancies between the overview and defined implementations:

[If implementations mentioned but not defined:]
✗ Implementation areas mentioned in overview but not yet defined:
  - User Entity Model (mentioned in Section 4.1)
  - Authentication Service (mentioned in Section 3.2)
  - REST API Endpoints (mentioned in Section 3.3)

[If implementations defined but not mentioned:]
✗ Implementations defined but not mentioned in overview:
  - IMPL-0007: Email Template Engine
  - IMPL-0012: Background Job Processor

Current state: {Z} implementations defined, but overview mentions {W} implementation areas.

What would you like to do?
1. Create the missing implementations using /spec-impl
2. Update implementation overview to add/remove implementation areas
3. Review existing implementations to see which are still needed

[Based on user choice:]
- Guide to /spec-impl for creating missing implementations
- Or load implementation overview for editing to align with defined implementations
```

#### Scenario D: All Overviews Complete

**If all tiers are fully complete (overviews + specifics aligned):**

```
All tiers are complete! ✓

Current state:
- Charter: ✓ Complete ({X} features defined and aligned)
- Architecture: ✓ Complete ({Y} components defined and aligned)
- Implementation: ✓ Complete ({Z} implementations defined and aligned)

Your specification system is fully aligned. What would you like to do?

1. Edit/update an overview document (Charter, Architecture, or Implementation)
2. Add more features (FEAT-####)
3. Add more components (COMP-####)
4. Add more implementations (IMPL-####)
5. Review and refine existing specifics
6. Create tasks (TASK-####) for implementation work

[Based on user choice, either:]
- Load the relevant overview for editing
- Redirect to appropriate command (/spec-feature, /spec-component, /spec-impl, /spec-task)
- Load requested spec by ID for review
```

**If overviews are complete but any tier has incomplete specifics:**

```
All overview documents are complete! ✓

However, some tiers have discrepancies between overviews and defined specifics:

[For each tier with discrepancies, show status:]
- Charter: ⚠ Incomplete (specifics) - {details from reconciliation}
- Architecture: ⚠ Incomplete (specifics) - {details from reconciliation}
- Implementation: ⚠ Incomplete (specifics) - {details from reconciliation}

I recommend completing each tier's specifics before moving forward. Which tier would you like to address first?

[Based on user choice:]
- Show detailed discrepancy report for selected tier (as in Scenarios A/B/C)
- Guide to appropriate /spec-* command for creating missing specs
- Or offer to load overview for editing to align with defined specs
```

### Phase 4: Cooperative Section-by-Section Planning

When filling in a new or incomplete overview:

1. **Get high-level context first:**
   ```
   Before we dive into details, help me understand the big picture:
   - [2-3 high-level questions about overall vision/approach]

   [User responds with context]

   Great! That gives me good context. Let's work through each section.
   ```

2. **Work section by section:**
   - Read the template section prompt
   - Use high-level context to ask informed questions
   - Don't just read template prompts verbatim - synthesize smart questions
   - Allow natural conversation flow (don't be rigid about order)

3. **Show and confirm:**
   - After filling each major section, show what you wrote
   - Ask: "Does this capture it correctly? Any changes?"

4. **Suggest additions:**
   - After covering template sections, ask:
   ```
   The template covers [list main sections]. Based on your [domain/approach/technology],
   are there other aspects we should document? For example:
   - [Specific suggestion 1 based on context]
   - [Specific suggestion 2 based on context]
   ```

5. **Final review:**
   - Show complete document structure
   - Ask for final confirmation before saving

### Phase 5: Save and Update

When saving a newly completed or updated overview:

1. **Save the overview document:**
   - Remove `-template` suffix if creating new file
   - Replace all {{placeholder}} values
   - Set `status: draft` for new documents
   - Set `last_updated` to today's date (YYYY-MM-DD format)
   - Preserve any existing content when editing

2. **Initialize index if needed:**
   - If index doesn't exist, create from index-template
   - Set initial `next_*_id` values
   - Set `last_updated`

3. **Report completion:**
   - Confirm what was created/updated
   - Show file paths
   - Suggest logical next steps

### Smart Editing Support

When user mentions a specific ID (e.g., "I need to update FEAT-0002"):

1. **Detect editing intent:**
   - Pattern match for ID mentions: FEAT-####, COMP-####, IMPL-####, TEST-####
   - Or phrases like "update the charter", "edit architecture", etc.

2. **Load and edit:**
   - Load the specified document
   - Show current values
   - Ask what the user wants to change
   - Work cooperatively to make changes
   - Update `last_updated`
   - Update cross-tier links if IDs change

3. **Suggest follow-on actions:**
   ```
   Updated {ID}. This change might affect:
   - [Related specs that reference this ID]

   Should we update those as well, or run /spec-sync to validate consistency?
   ```

## Important Notes

**Context Loading:**
- Load ONLY overview documents and index files
- DO NOT load individual spec files unless editing them
- Index files show counts and summaries - enough context without loading everything

**Tier Separation:**
- Charter defines WHAT (features, goals, vision)
- Architecture defines HOW (components, tech stack, structure)
- Implementation defines CONTRACTS (APIs, data models, invariants)
- Keep these concerns separate and well-defined

**Cooperative Approach:**
- Ask informed questions based on context, not scripted prompts
- Suggest relevant additions beyond the template
- Show work frequently and ask for confirmation
- Allow natural conversation flow
- Be helpful but not presumptuous

**Editing vs. Creating:**
- When editing, preserve existing content and only change what user specifies
- When creating new, start from template
- Always update `last_updated` date
- Maintain cross-tier link consistency

**Smart Suggestions:**
- Based on domain (e.g., e-commerce, SaaS, data pipeline), suggest relevant sections
- Based on tech choices (e.g., microservices), suggest architectural patterns
- Based on scale (e.g., "millions of users"), suggest performance/scalability sections

**Workflow Guidance:**
After completing an overview, suggest:
- Adding specifics (features, components, implementations)
- Moving to next tier if the specifics are complete
- Running /spec-sync to validate consistency
- Using /spec-feature, /spec-component, /spec-impl commands

## Example Interactions

### Example 1: Incomplete overview (has placeholders)

```
User: /spec-plan

Claude: I'll help you plan your system specifications.

Let me check what's already defined...

✓ Loaded spec/charter/system-charter.md
✓ Loaded spec/charter/index.md (5 features defined)
✓ Loaded spec/architecture/stack-overview.md (has {{placeholder}} values in sections 2.2, 4, 5)
✓ Loaded spec/architecture/index.md (3 components defined)

Current state:
- Charter: ✓ Complete (5 features defined and aligned)
- Architecture: ⚠ Incomplete (overview) - missing data storage, integrations, cross-cutting concerns
- Implementation: Not started

Your architecture document needs completion. Let's fill in the missing sections.

I see you have 3 components already defined (COMP-0001: API Gateway, COMP-0002: User Service, COMP-0003: Analytics Engine). Let me ask about your data storage strategy:

Looking at your components, I'd expect at least a primary database for user data and possibly something for analytics. What are you using?
- Primary database: [user provides: PostgreSQL]
- Any caching layer? [user provides: Redis for session management]
- Message queue or event bus? [user provides: RabbitMQ for async processing]

Great! Let me also ask about your analytics storage since you have an Analytics Engine component:
[conversation continues section by section...]

[After completing all sections:]

Here's your completed architecture overview:
[Shows summary of filled sections]

Does this look correct? Any changes or additions?

[User confirms]

✓ Updated spec/architecture/stack-overview.md
✓ Updated spec/architecture/index.md (last_updated)
✓ Architecture overview is now complete

Checking alignment between overview and defined components...
✓ All 3 components are mentioned in the overview
✓ Architecture tier is now fully complete

Ready to move on to implementation planning, or would you like to add more components (COMP-####) first?
```

### Example 2: Incomplete specifics (overview complete but missing specs)

```
User: /spec-plan

Claude: I'll help you plan your system specifications.

Let me check what's already defined...

✓ Loaded spec/charter/system-charter.md
✓ Loaded spec/charter/index.md (3 features defined)

Reconciling charter overview with defined features...

Current state:
- Charter: ⚠ Incomplete (specifics)

Your charter overview is complete! ✓

However, I noticed some discrepancies between the overview and defined features:

✗ Feature areas mentioned in charter but not yet defined:
  - Market Data Ingestion (mentioned in Section 2.1: "real-time market data ingestion")
  - Scenario Testing (mentioned in Section 3.2: "what-if scenario modeling")

✓ Features already defined:
  - FEAT-0001: Recipe & Production Analysis
  - FEAT-0002: Portfolio Risk Analysis
  - FEAT-0003: Real-time Alerting

Current state: 3 features defined, but charter mentions 5 capability areas.

What would you like to do?
1. Create the missing features using /spec-feature
2. Update charter overview to remove these feature areas
3. Review the charter to see what else needs features

User: Let's create the missing features

Claude: Great! Let's create FEAT-0004 for Market Data Ingestion first.

Based on the charter (Section 2.1), this feature should provide real-time market data ingestion capabilities. Let me ask some questions to flesh this out...

[Proceeds with /spec-feature workflow for each missing feature]
```

---

**Remember:** This is a cooperative planning tool. Your job is to help the user think through their system design thoughtfully, not just fill in forms. Ask good questions, make smart suggestions, and create clear documentation.

## Related Commands

- **`/spec-feature`** - Create or edit individual feature specifications (FEAT-####)
- **`/spec-component`** - Create architecture components (use after charter complete)
- **`/spec-impl`** - Create implementation specs (use after architecture complete)

Use these commands instead of creating spec files directly.