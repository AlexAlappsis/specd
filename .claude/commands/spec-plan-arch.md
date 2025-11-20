Plan or edit the Architecture tier overview document cooperatively.

**Before starting:** Read [spec/agent-guide.md](../spec/agent-guide.md) for a quick reference to the Architecture tier's role in the four-tier specification system.

**What this command does:**
1. Validates Charter tier is complete (prerequisite)
2. Creates or loads the architecture overview document (stack-overview.md)
3. Works cooperatively with user to fill in or refine architecture sections
4. Initializes architecture index if needed
5. Suggests next steps (creating components with /spec-component)

**Usage:**
```
/spec-plan-arch        # Create new or edit existing architecture overview
```

---

**Implementation instructions for Claude Code:**

## When Invoked

### Phase 1: Validate Prerequisites

1. **Check Charter tier is complete:**
   - Try to open `spec/charter/system-charter.md`
   - If not found or has {{placeholder}} values:
     ```
     Error: Charter tier must be complete before planning architecture.

     Current state: Charter is [not started / incomplete]

     Please complete the charter first:
     - Run /spec-plan-charter to create/complete charter overview
     - Run /spec-feature to define features
     - Run /spec-plan to check status

     Then return here to plan your architecture.
     ```
     Exit without proceeding.

   - If charter exists and is complete, continue

2. **Load charter for context:**
   - Parse charter to understand system goals and features
   - This context informs architecture questions

### Phase 2: Determine Mode

1. **Try to load existing architecture:**
   - Try to open `spec/architecture/stack-overview.md`
   - If found, use **EDIT MODE**
   - If not found, use **CREATE MODE**

2. **Try to load architecture index:**
   - Try to open `spec/architecture/index.md`
   - If not found, will need to initialize in CREATE mode

3. **If neither exists:**
   - Check for templates
   - If templates missing, inform user to run `install.sh` first

### Phase 3A: CREATE MODE - New Architecture

If architecture doesn't exist, create it cooperatively:

1. **Initialize architecture tier if needed:**
   - If `spec/architecture/index.md` doesn't exist:
     ```
     Architecture tier not initialized. Initializing...

     ✓ Created spec/architecture/index.md
     ✓ Set next_component_id: COMP-0001
     ```

2. **Get high-level context first:**
   ```
   Let's plan your system architecture. I'll work with you to define the technical approach.

   I've reviewed your charter - [brief summary of key features/goals from charter].

   Let me understand your architectural vision:
   - What's the overall architectural style? (monolith, microservices, modular monolith, etc.)
   - What are the main technology choices? (languages, frameworks, databases)
   - What are the major components or system boundaries you envision?
   ```

3. **Work section by section through the architecture template:**

   Load `spec/architecture/stack-overview-template.md` to understand structure.

   **Section 1: Metadata** (YAML front matter)
   - Set `id: ARCH-STACK`
   - Set `status: draft`
   - Set `last_updated` to today's date (YYYY-MM-DD)

   **Section 2: Architecture Overview**
   - Based on high-level context and charter features, draft architecture approach
   - Show to user and ask for confirmation/refinement
   - Ask informed questions referencing charter features:
     - "For [feature from charter], I'm thinking [architectural approach] - does that align with your vision?"
     - "You mentioned [technology] - how does that integrate with [charter requirement]?"

   **Section 3: Components**
   - Based on charter features and architecture style, draft component list
   - For each major component, briefly describe responsibility
   - Show to user: "Here are the major components I'm envisioning - any missing or need changes?"

   **Section 4: Data Storage**
   - Ask about data storage strategy:
     - "What's your primary database choice and why?"
     - "Any caching, message queues, or event streams?"
     - "Looking at [charter feature], what data persistence needs do you see?"
   - Draft data storage section

   **Section 5: External Integrations**
   - Ask about external systems:
     - "Are there external systems to integrate with?"
     - "Any third-party APIs or services?"
   - Draft integrations section

   **Section 6: Cross-Cutting Concerns**
   - Ask about non-functional requirements:
     - "Authentication/authorization approach?"
     - "Logging, monitoring, observability?"
     - "Error handling and resilience patterns?"
   - Draft cross-cutting concerns section

   **Section 7: Testing Strategy**
   - Ask about testing philosophy:
     - "What testing frameworks and approaches?"
     - "Unit test coverage targets?"
     - "Integration and E2E testing strategy?"
   - Draft testing strategy section

4. **Suggest custom sections:**
   ```
   Based on your [architectural style/technology choices], are there other
   aspects we should document? For example:
   - [Specific suggestion based on context]
   ```

5. **Final review:**
   - Show complete architecture structure
   - Ask for final confirmation before saving

6. **Save architecture:**
   ```
   ✓ Created spec/architecture/stack-overview.md
   ```

7. **Suggest next steps:**
   ```
   Architecture overview complete! ✓

   Next steps:
   1. Define individual components: /spec-component
   2. Check planning status: /spec-plan

   Suggested components based on your architecture:
   - [Component 1 from Section 3]
   - [Component 2 from Section 3]
   - [Component 3 from Section 3]

   Ready to create the first component?
   ```

### Phase 3B: EDIT MODE - Existing Architecture

If architecture exists, help user edit it:

1. **Load and show current architecture:**
   ```
   Loaded spec/architecture/stack-overview.md

   Current architecture:
   - Architectural style: [style]
   - Status: [status]
   - Last updated: [date]

   Sections:
   [List main section headings and brief content summary]

   What would you like to update?
   - Specific section (e.g., "Components", "Data Storage")
   - Add new section
   - Update metadata (status, etc.)
   - Review and refine entire architecture
   ```

2. **Cooperative editing:**
   - Similar to charter edit mode
   - Work section by section as user requests
   - Update `last_updated` date

3. **Save updates:**
   ```
   ✓ Updated spec/architecture/stack-overview.md
   ✓ Updated last_updated to [today's date]

   [If component list changed:]
   Note: Component list updated. Run /spec-plan to check if any
   component discrepancies were introduced or resolved.
   ```

## Important Notes

**Charter Context:**
- Always load and reference charter when planning architecture
- Ask architecture questions informed by charter features and goals
- Suggest components that map to charter capabilities

**Tier Separation:**
- Architecture defines HOW (technical approach, components, stack)
- Don't dive into implementation details (that's Implementation tier)
- Stay at component/system level, not class/function level

**Smart Suggestions:**
- Based on architectural style (e.g., microservices), suggest patterns (API gateway, service mesh)
- Based on charter scale (e.g., "millions of users"), suggest scalability components (cache, load balancer)
- Based on charter compliance (e.g., HIPAA), suggest security components (encryption, audit logging)

**Component Guidance:**
- Components in Section 3 should map to charter features
- Each component should have clear responsibility
- Suggest dependency relationships between components

## Example Interaction - CREATE MODE

```
User: /spec-plan-arch

Claude: Let's plan your system architecture.

I've reviewed your charter - RecipeFlow is a recipe and production analysis
system with 3 main capabilities: recipe management, cost analysis, and
scenario modeling.

Let me understand your architectural vision:
- What's the overall architectural style?
- What are the main technology choices?
- What are the major components you envision?

User: Modular monolith using Python/FastAPI, PostgreSQL database, and
React frontend. Want clean separation between recipe management, analytics,
and scenario modules.

Claude: Great! Modular monolith with clear module boundaries. That gives you
flexibility to extract modules to services later if needed.

Let me draft Section 2 (Architecture Overview):

---
## 2. Architecture Overview

RecipeFlow is architected as a modular monolith with three primary modules:
Recipe Management, Analytics Engine, and Scenario Modeling. This approach
provides clean separation of concerns while maintaining deployment simplicity.

**Technology Stack:**
- Backend: Python 3.11+ with FastAPI framework
- Database: PostgreSQL 15+ for relational data and JSONB for flexible schema
- Frontend: React 18+ with TypeScript
- API: RESTful API with OpenAPI documentation

**Architectural Principles:**
- Module independence: Each module has clear boundaries and responsibilities
- Shared data layer: Common database with module-specific schemas
- API-first: All module interactions via well-defined APIs
---

Does this capture your vision? Any changes?

[Continues section by section...]

For Section 3 (Components), based on your modules and charter features,
I'm thinking:

**Core Modules:**
- Recipe Management Module: Recipe CRUD, versioning, ingredient management
- Analytics Engine Module: Cost calculations, production analysis
- Scenario Modeling Module: What-if scenarios, comparison tools

**Supporting Components:**
- Web API Layer: FastAPI endpoints for all modules
- Database Layer: PostgreSQL with SQLAlchemy ORM
- Frontend Application: React SPA

**Cross-Module:**
- Authentication Service: User auth and authorization
- Audit Logger: FDA 21 CFR Part 11 compliance tracking

Does this component structure work for you? Any missing pieces?

[User confirms or refines]

[After all sections complete:]

✓ Created spec/architecture/stack-overview.md
✓ Architecture tier initialized

Architecture overview complete! ✓

Suggested components to create:
- Recipe Management Module
- Analytics Engine Module
- Scenario Modeling Module
- Authentication Service
- Database Layer

Ready to define these components with /spec-component?
```

## Example Interaction - EDIT MODE

```
User: /spec-plan-arch

Claude: Loaded spec/architecture/stack-overview.md

Current architecture:
- Architectural style: Modular monolith
- Primary stack: Python/FastAPI, PostgreSQL, React
- Status: draft
- Last updated: 2025-11-15

Sections:
- Architecture Overview: Modular monolith with 3 core modules
- Components: 5 major components defined
- Data Storage: PostgreSQL primary, Redis cache
- External Integrations: None currently
- Cross-Cutting Concerns: Auth, logging, error handling
- Testing Strategy: Pytest, coverage targets

What would you like to update?

User: Need to add integration with market data API for ingredient pricing

Claude: Good addition! Let me update Section 5 (External Integrations):

Current Section 5 shows no external integrations. Adding market data API:

---
## 5. External Integrations

**Market Data API Integration:**
- **Purpose:** Real-time ingredient pricing for cost analysis
- **Provider:** [Which market data provider?]
- **Integration Pattern:** RESTful API with caching
- **Data Flow:** Analytics Engine queries pricing data, caches for 1 hour
- **Error Handling:** Fallback to last known prices if API unavailable

**Technical Details:**
- API client library in Analytics Engine module
- Redis cache for pricing data
- Scheduled background updates every hour
---

Which market data provider are you integrating with? Any specific
requirements for the integration?

[User provides details, Claude refines]

✓ Updated Section 5: External Integrations
✓ Updated spec/architecture/stack-overview.md
✓ Updated last_updated to 2025-11-19

This integration affects your Analytics Engine component. You may want to:
1. Update COMP-#### (Analytics Engine) to document this integration
2. Create new IMPL-#### for the market data API client
3. Add error handling and caching to testing strategy

Run /spec-plan to check overall status.
```

## Related Commands

- **`/spec-plan`** - Check overall planning status across all tiers
- **`/spec-plan-charter`** - Edit charter overview if architecture needs change
- **`/spec-component`** - Create individual component specifications
- **`/spec-plan-impl`** - Plan implementation overview (after architecture complete)
