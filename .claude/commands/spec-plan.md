Show current planning status across all tiers and route to appropriate tier-specific planning commands.

**Before starting:** Read [spec/agent-guide.md](../spec/agent-guide.md) for a quick reference to the four-tier specification system (Charter, Architecture, Implementation, Tasks), ID conventions, and cross-tier traceability.

**What this command does:**
1. Loads overview documents and indexes for all tiers
2. Runs reconciliation to check alignment between overviews and defined specs
3. Displays current status for each tier
4. Routes user to appropriate tier-specific planning commands

**Prerequisites:**
- Run `install.sh` script first to copy templates and commands to project root
- The `spec/` directory with templates must exist

**Usage:**
```
/spec-plan
```

---

**Implementation instructions for Claude Code:**

## When Invoked

### Phase 1: Load Context Progressively

Load context **by tier**, stopping at the first incomplete tier:

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

2. **If Charter overview exists, load Architecture tier:**
   - Try to open `spec/architecture/stack-overview.md`
   - If not found, try `spec/architecture/stack-overview-template.md`
   - Try to open `spec/architecture/index.md`
   - If not found, try `spec/architecture/index-template.md`
   - Parse index to see which components exist (count only)

3. **If Architecture overview exists, load Implementation tier:**
   - Try to open `spec/implementation/overview.md`
   - If not found, try `spec/implementation/overview-template.md`
   - Try to open `spec/implementation/index.md`
   - If not found, try `spec/implementation/index-template.md`
   - Parse index to see which implementations exist (count only)

**DO NOT load individual FEAT-####, COMP-####, IMPL-####, or TASK-#### files.**

### Phase 2: Determine Current State

Based on what you loaded, determine:

1. **Which overviews exist and are complete?**
   - A document is "complete" if it has no {{placeholder}} values
   - A document is "incomplete" if it has {{placeholder}} values or missing sections

2. **What specifics exist?**
   - X features (FEAT-####) defined
   - Y components (COMP-####) defined
   - Z implementations (IMPL-####) defined

3. **Reconcile overviews with indexes:**

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

4. **Determine tier completeness status:**

   For each tier, the status is:
   - **not started:** No overview document exists
   - **incomplete (overview):** Overview exists but has {{placeholder}} values
   - **incomplete (specifics):** Overview complete but reconciliation found discrepancies
   - **complete:** Overview exists, no placeholders, and aligned with index

### Phase 3: Display Status and Route

Based on current state, display status and route to appropriate command:

#### Scenario A: Charter Not Started

```
Planning Status
===============

Charter:        ⚠ Not started
Architecture:   - Not started
Implementation: - Not started

Next step: Create your system charter overview

Run: /spec-plan-charter
```

#### Scenario B: Charter Incomplete (Overview)

```
Planning Status
===============

Charter:        ⚠ Incomplete (overview)
                Missing sections: [list sections with {{placeholder}} values]
Architecture:   - Not started
Implementation: - Not started

Next step: Complete your charter overview

Run: /spec-plan-charter
```

#### Scenario C: Charter Incomplete (Specifics)

```
Planning Status
===============

Charter:        ⚠ Incomplete (specifics)
                {X} features defined, charter mentions {Y} capability areas

Missing features:
  ✗ Market Data Ingestion (mentioned in Section 2.1)
  ✗ Scenario Testing (mentioned in Section 3.2)

[If applicable] Features not mentioned in charter:
  ✗ FEAT-0005: Real-time Alerting

Architecture:   - Not started
Implementation: - Not started

Next steps (choose one):
1. Create missing features: /spec-feature
2. Update charter overview: /spec-plan-charter
```

#### Scenario D: Charter Complete, Architecture Not Started

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ⚠ Not started
Implementation: - Not started

Next step: Plan your system architecture

Run: /spec-plan-arch
```

#### Scenario E: Charter Complete, Architecture Incomplete (Overview)

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ⚠ Incomplete (overview)
                Missing sections: [list sections with {{placeholder}} values]
Implementation: - Not started

Next step: Complete your architecture overview

Run: /spec-plan-arch
```

#### Scenario F: Charter Complete, Architecture Incomplete (Specifics)

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ⚠ Incomplete (specifics)
                {Y} components defined, architecture mentions {Z} component areas

Missing components:
  ✗ API Gateway (mentioned in Section 2)
  ✗ PostgreSQL Database Layer (mentioned in Section 4)

[If applicable] Components not mentioned in architecture:
  ✗ COMP-0008: Cache Manager

Implementation: - Not started

Next steps (choose one):
1. Create missing components: /spec-component
2. Update architecture overview: /spec-plan-arch
```

#### Scenario G: Charter & Architecture Complete, Implementation Not Started

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ✓ Complete ({Y} components defined and aligned)
Implementation: ⚠ Not started

Next step: Plan your implementation approach

Run: /spec-plan-impl
```

#### Scenario H: Charter & Architecture Complete, Implementation Incomplete (Overview)

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ✓ Complete ({Y} components defined and aligned)
Implementation: ⚠ Incomplete (overview)
                Missing sections: [list sections with {{placeholder}} values]

Next step: Complete your implementation overview

Run: /spec-plan-impl
```

#### Scenario I: Charter & Architecture Complete, Implementation Incomplete (Specifics)

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ✓ Complete ({Y} components defined and aligned)
Implementation: ⚠ Incomplete (specifics)
                {Z} implementations defined, overview mentions {W} implementation areas

Missing implementations:
  ✗ User Entity Model (mentioned in Section 4.1)
  ✗ Authentication Service (mentioned in Section 3.2)

[If applicable] Implementations not mentioned in overview:
  ✗ IMPL-0012: Background Job Processor

Next steps (choose one):
1. Create missing implementations: /spec-impl
2. Update implementation overview: /spec-plan-impl
```

#### Scenario J: All Tiers Complete

```
Planning Status
===============

Charter:        ✓ Complete ({X} features defined and aligned)
Architecture:   ✓ Complete ({Y} components defined and aligned)
Implementation: ✓ Complete ({Z} implementations defined and aligned)

All tiers are complete! ✓

What would you like to do?
1. Add more features: /spec-feature
2. Add more components: /spec-component
3. Add more implementations: /spec-impl
4. Create tasks for implementation work: /spec-task
5. Edit charter overview: /spec-plan-charter
6. Edit architecture overview: /spec-plan-arch
7. Edit implementation overview: /spec-plan-impl
8. Validate cross-tier consistency: /spec-sync
```

## Important Notes

**Context Loading:**
- Load ONLY overview documents and index files
- DO NOT load individual spec files
- Index files provide counts and summaries - enough context without loading everything

**Tier Separation:**
- Charter defines WHAT (features, goals, vision)
- Architecture defines HOW (components, tech stack, structure)
- Implementation defines CONTRACTS (APIs, data models, invariants)
- Keep these concerns separate and well-defined

**Routing Strategy:**
- This command is a status dashboard and router
- All actual planning work happens in tier-specific commands
- Keep output focused on current status and clear next steps
- Don't try to do planning work in this command

## Related Commands

- **`/spec-plan-charter`** - Plan or edit charter overview (use when charter is incomplete)
- **`/spec-plan-arch`** - Plan or edit architecture overview (use when architecture is incomplete)
- **`/spec-plan-impl`** - Plan or edit implementation overview (use when implementation is incomplete)
- **`/spec-feature`** - Create or edit individual feature specifications (FEAT-####)
- **`/spec-component`** - Create or edit architecture components (COMP-####)
- **`/spec-impl`** - Create or edit implementation specs (IMPL-####)
- **`/spec-task`** - Create tasks for implementation work (TASK-####)
- **`/spec-sync`** - Validate cross-tier consistency
