Plan or edit the Architecture tier overview document cooperatively.

**Before starting:** Read [spec/agent-guide.md](../spec/agent-guide.md) for the Architecture tier's role, component definitions, and testing strategy.

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

1. **Check Charter complete:**
   - Open `spec/charter/system-charter.md`
   - If missing or has {{placeholder}} values:
     ```
     Error: Charter must be complete before planning architecture.

     Current state: Charter is [not started / incomplete]

     Complete charter first:
     - /spec-plan-charter
     - /spec-feature to define features
     - /spec-plan to check status
     ```
     Exit without proceeding.

2. **Load charter for context:**
   - Parse charter for system goals and features

### Phase 2: Determine Mode

1. **Try to load existing:** Open `spec/architecture/stack-overview.md`
   - Found → **EDIT MODE**
   - Not found → **CREATE MODE**

2. **Try to load index:** Open `spec/architecture/index.md`
   - Will initialize if needed in CREATE mode

### Phase 3A: CREATE MODE

1. **Initialize if needed:**
   ```
   Architecture tier not initialized. Initializing...

   ✓ Created spec/architecture/index.md
   ✓ Set next_component_id: COMP-0001
   ```

2. **Get high-level context:**
   ```
   Let's plan your system architecture.

   I've reviewed your charter - [brief summary of key features/goals].

   Let me understand your architectural vision:
   - Overall architectural style? (monolith, microservices, modular, etc.)
   - Main technology choices? (languages, frameworks, databases)
   - Major components or system boundaries?
   ```

3. **Work through architecture template:**

   Load `spec/architecture/stack-overview-template.md` for structure.

   **Section 1: Metadata (YAML)**
   - `id: ARCH-STACK`
   - `status: draft`
   - `last_updated: YYYY-MM-DD` (today)

   **Section 2: Architecture Overview**
   - Draft approach based on context and charter features
   - Show and confirm
   - Ask informed follow-ups referencing charter:
     - "For [charter feature], I'm thinking [architectural approach] - align with your vision?"
     - "You mentioned [technology] - how does it integrate with [charter requirement]?"

   **Section 3: Components**
   - Draft component list based on charter features and architecture style
   - For each component, brief responsibility
   - Show: "Here are the major components - any missing or changes needed?"

   **Section 4: Data Storage**
   - Ask about data strategy:
     - "Primary database choice and why?"
     - "Caching, message queues, event streams?"
     - "Looking at [charter feature], what data persistence needs?"
   - Draft data storage

   **Section 5: External Integrations**
   - Ask about external systems:
     - "External systems to integrate?"
     - "Third-party APIs or services?"
   - Draft integrations

   **Section 6: Cross-Cutting Concerns**
   - Ask about non-functionals:
     - "Authentication/authorization approach?"
     - "Logging, monitoring, observability?"
     - "Error handling and resilience?"
   - Draft cross-cutting concerns

   **Section 7: Testing Strategy**
   - Ask about testing philosophy:
     - "Testing frameworks and approaches?"
     - "Unit test coverage targets?"
     - "Integration and E2E strategy?"
   - Draft testing strategy

4. **Suggest additions by context:**
   - Microservices → Service mesh, API gateway, discovery?
   - High-scale → Performance targets, caching, load balancing?
   - Compliance → Security architecture, audit logging?

5. **Final review and save:**
   - Show complete structure
   - Confirm
   - Copy template → `spec/architecture/stack-overview.md`
   - Replace {{placeholder}} values
   - Set metadata
   - Save

6. **Suggest next steps:**
   ```
   Architecture overview complete! ✓

   Next steps:
   1. Define individual components: /spec-component
   2. Check planning status: /spec-plan

   Suggested components:
   - [Component 1 from Section 3]
   - [Component 2 from Section 3]
   - [Component 3 from Section 3]

   Ready to create the first component?
   ```

### Phase 3B: EDIT MODE

1. **Load and show:**
   ```
   Loaded spec/architecture/stack-overview.md

   Current architecture:
   - Style: [style]
   - Status: [status]
   - Last updated: [date]

   Sections:
   [List main headings with brief summary]

   What to update?
   - Specific section
   - Add new section
   - Update metadata
   - Review entire architecture
   ```

2. **Cooperative editing:**
   - **Update section:** Show → ask changes → refine → update `last_updated`
   - **Add section:** Ask purpose → draft → confirm → insert
   - **Review entire:** Section by section → show → ask → apply

3. **Save updates:**
   ```
   ✓ Updated spec/architecture/stack-overview.md
   ✓ Updated last_updated to [today]

   [If component list changed:]
   Note: Component list updated. Run /spec-plan to check for discrepancies.
   ```

## Smart Suggestions by Style/Scale

- **Microservices:** API gateway, service discovery, config server, message bus
- **Monolith:** Module boundaries, internal APIs, shared libraries
- **High-scale:** Caching (Redis/Memcached), CDN, load balancers, horizontal scaling
- **Event-driven:** Event store, message broker, CQRS/ES patterns
- **Compliance (HIPAA/GDPR):** Encryption at rest/transit, audit logging, access controls

## Example - CREATE MODE

```
User: /spec-plan-arch

Claude: Let's plan your system architecture.

I've reviewed your charter - RecipeFlow with recipe management, cost analysis,
and scenario modeling capabilities.

Your architectural vision:
- Overall style?
- Technology choices?
- Major components?

User: Modular monolith, Python/FastAPI, PostgreSQL, React frontend.
Clean separation between recipe, analytics, and scenario modules.

Claude: Modular monolith with clear boundaries - nice! Flexibility to
extract modules later if needed.

Section 2 (Architecture Overview) draft:

---
RecipeFlow: Modular monolith with three primary modules - Recipe Management,
Analytics Engine, Scenario Modeling. Clean separation of concerns with
deployment simplicity.

**Tech Stack:**
- Backend: Python 3.11+ / FastAPI
- Database: PostgreSQL 15+ (relational + JSONB)
- Frontend: React 18+ / TypeScript
- API: RESTful with OpenAPI docs

**Principles:**
- Module independence with clear boundaries
- Shared data layer, module-specific schemas
- API-first module interactions
---

Capture your vision? Changes?

[User confirms]

Claude: Excellent! Section 3 (Components)...

Based on modules and charter features:

**Core Modules:**
- Recipe Management Module: CRUD, versioning, ingredients
- Analytics Engine Module: Cost calculations, production analysis
- Scenario Modeling Module: What-if scenarios, comparisons

**Supporting:**
- Web API Layer: FastAPI endpoints for all modules
- Database Layer: PostgreSQL / SQLAlchemy ORM
- Authentication Service: User auth/authorization
- Audit Logger: FDA 21 CFR Part 11 compliance

Structure work?

[Continues...]

✓ Created spec/architecture/stack-overview.md

Suggested components to create:
- Recipe Management Module
- Analytics Engine Module
- Scenario Modeling Module
- Authentication Service
- Database Layer

Ready for /spec-component?
```

## Related Commands

- `/spec-plan` - Check overall status
- `/spec-plan-charter` - Edit charter if architecture needs change
- `/spec-component` - Create components
- `/spec-plan-impl` - Plan implementation (after architecture complete)
