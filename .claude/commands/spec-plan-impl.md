Plan or edit the Implementation tier overview document cooperatively.

**Before starting:** If you haven't already in this conversation, read [spec/agent-guide.md](../spec/agent-guide.md) for the Implementation tier's role, repo-specific nature, and testing strategy.

**What this command does:**
1. Validates Charter and Architecture tiers are complete (prerequisites)
2. Determines repository context (single repo vs. multi-repo)
3. Creates or loads the implementation overview document (overview.md)
4. Works cooperatively with user to fill in or refine implementation sections
5. Initializes implementation index if needed
6. Suggests next steps (creating implementations with /spec-impl)

**Usage:**
```
/spec-plan-impl        # Create new or edit existing implementation overview
```

---

**Implementation instructions for Claude Code:**

## When Invoked

### Phase 1: Validate Prerequisites

1. **Check Charter and Architecture complete:**
   - Open `spec/charter/system-charter.md` and `spec/architecture/stack-overview.md`
   - If either missing or has {{placeholder}} values:
     ```
     Error: Charter and Architecture must be complete before planning implementation.

     Current state:
     - Charter: [not started / incomplete / complete]
     - Architecture: [not started / incomplete / complete]

     Complete both tiers first:
     - /spec-plan-charter
     - /spec-plan-arch
     - /spec-plan to check status
     ```
     Exit without proceeding.

2. **Load charter and architecture for context:**
   - Parse charter for system goals
   - Parse architecture for components and tech stack

3. **Load glossary if exists:**
   - Try to open `spec/glossary.md`
   - If found, use term definitions for consistency in questions and drafts
   - If not found, continue (glossary is optional)

### Phase 2: Determine Repository Context

**Note:** Implementation overview is repo-specific. Multi-repo projects need separate overviews.

1. **Ask about repository structure:**
   ```
   Is this a single repository or multiple repositories?
   ```

2. **If single:** Continue with single overview, ask for repo name
3. **If multiple:** Ask which repo to plan, list components from architecture

### Phase 3: Determine Mode

1. **Try to load existing:** Open `spec/implementation/overview.md`
   - Found, repo matches → **EDIT MODE**
   - Not found or different repo → **CREATE MODE**

2. **Try to load index:** Open `spec/implementation/index.md`
   - Will initialize if needed in CREATE mode

### Phase 4A: CREATE MODE

1. **Initialize if needed:**

   If `spec/implementation/index.md` doesn't exist for this repo, create it from template:
   - Copy `spec/implementation/index-template.md` → `spec/implementation/index.md`
   - Set `repo: {repo-name}` in front matter
   - Set `next_impl_id: IMPL-0001` in front matter
   - Set `last_updated` to today
   - **Remove example rows from implementation table** (leave table empty)
   - **Keep the permanent example rows below the table** (in blockquote)

   ```
   Implementation tier not initialized for repo "{repo-name}". Initializing...

   ✓ Created spec/implementation/index.md (empty table, ready for implementations)
   ✓ Set repo: {repo-name}
   ✓ Set next_impl_id: IMPL-0001
   ```

   **Important:** The index table should be empty after initialization. Implementations are added to the table only when individual IMPL-#### files are created using `/spec-impl`.

2. **Get high-level context:**
   ```
   Let's plan implementation for repository: {repo-name}

   I've reviewed your architecture - [brief summary of components and tech stack].

   For repository "{repo-name}":
   - Which components (COMP-####) does this repo implement?
   - What's the internal structure? (folders, layers, modules)
   - Main implementation areas within this repo?
   ```

3. **Work through implementation template:**

   Load `spec/implementation/overview-template.md` for structure.

   **Section 1: Metadata (YAML)**
   - `id: IMPL-OVERVIEW`
   - `repo: {repo-name}`
   - `status: draft`
   - `last_updated: YYYY-MM-DD` (today)
   - `components: []` - list of COMP-#### IDs

   **Section 2: Repository Overview**
   - Draft purpose based on components
   - Reference architecture decisions
   - Show and confirm

   **Section 3: Implementation Structure**
   - Ask about folder/module organization
   - Ask about layers (controllers, services, repositories)
   - Ask about patterns (clean architecture, DDD)
   - Draft structure with folder tree

   **Section 4: Data Models**
   - Based on components, ask about main entities/models
   - Ask about shared schemas
   - Draft data models

   **Section 5: External Integrations**
   - Reference architecture integrations
   - Ask which this repo implements
   - Draft repo-specific integrations

   **Section 6: Testing Approach**
   - Reference architecture Section 7 (Testing Strategy) for frameworks
   - Ask about repo-specific testing organization
   - Ask about coverage targets
   - Ask about integration test approach
   - Draft testing approach

4. **Suggest custom sections by tech stack:**
   - **FastAPI:** Routers, services, schemas organization?
   - **DDD:** Entities, aggregates, repositories?
   - **Microservices:** Service mesh, discovery, config?

5. **Final review and save:**
   - Show complete structure
   - Confirm
   - Copy template → `spec/implementation/overview.md`
   - Replace {{placeholder}} values
   - Set metadata
   - Save

6. **Suggest next steps:**
   ```
   Implementation overview complete for {repo-name}! ✓

   [If technical/domain terms detected and glossary doesn't exist:]
   I noticed technical terms in your implementation ([list 2-3 key terms]).
   Consider adding them to the glossary: /spec-glossary add [term]

   Next steps:
   1. Define glossary terms (optional): /spec-glossary
   2. Define individual implementations: /spec-impl
   3. Check planning status: /spec-plan

   Suggested implementations:
   - [Area 1 from Section 3/4]
   - [Area 2 from Section 3/4]
   - [Area 3 from Section 3/4]

   Ready to create the first implementation?
   ```

### Phase 4B: EDIT MODE

1. **Load and show:**
   ```
   Loaded spec/implementation/overview.md

   Repository: {repo-name}
   Components: [COMP-####, ...]
   Status: [status]
   Last updated: [date]

   Sections:
   [List main headings with brief summary]

   What to update?
   - Specific section
   - Add new section
   - Update metadata
   - Review entire overview
   ```

2. **Cooperative editing:**
   - **Update section:** Show → ask changes → refine → update `last_updated`
   - **Add section:** Ask purpose → draft → confirm → insert
   - **Review entire:** Section by section → show → ask → apply
   - If components[] changes, note may affect cross-tier links

3. **Save updates:**
   ```
   ✓ Updated spec/implementation/overview.md
   ✓ Updated last_updated to [today]

   [If significantly changed:]
   Note: Implementation areas updated. Run /spec-plan to check for discrepancies.
   ```

## Smart Suggestions by Tech Stack

- **Python/FastAPI:** `/api` routers, `/core` business logic, `/db` models, `/schemas` Pydantic
- **Node/Express:** `/routes`, `/controllers`, `/services`, `/models`
- **Java/Spring:** Package structure, controllers, services, repositories, entities
- **React:** Components, hooks, contexts, services, utils
- **.NET:** Controllers, services, repositories, entities, DTOs
- **Go:** Handlers, services, repositories, models

## Example - CREATE MODE (Single Repo)

```
User: /spec-plan-impl

Claude: Is this a single repository or multiple repositories?

User: Single repository

Claude: What should we name this repository?

User: recipeflow-monolith

Claude: For repository "recipeflow-monolith":
Which components does this implement?

Looking at your architecture: Recipe Management Module, Analytics Engine Module,
Scenario Modeling Module, Web API Layer, Database Layer, Authentication Service,
Frontend Application

User: All except Frontend - that's separate

Claude: Got it! Backend components only.

What's the internal folder structure?

User: /app with /api, /core, /db, /services, /schemas, /tests

Claude: Section 3 (Implementation Structure) draft:

```
recipeflow-monolith/
├── app/
│   ├── api/              # FastAPI routers
│   │   ├── recipes/
│   │   ├── analytics/
│   │   └── scenarios/
│   ├── core/             # Business logic
│   │   ├── recipes/
│   │   ├── analytics/
│   │   └── scenarios/
│   ├── db/               # Database
│   │   ├── models/       # SQLAlchemy ORM
│   │   └── migrations/   # Alembic
│   ├── services/         # Service layer
│   │   ├── auth.py
│   │   └── audit.py
│   ├── schemas/          # Pydantic schemas
│   └── tests/
│       ├── unit/
│       ├── integration/
│       └── e2e/
```

Each module (recipes, analytics, scenarios) has:
- API routes in /api/{module}/
- Business logic in /core/{module}/
- Models in /db/models/
- Schemas in /schemas/

Does this match?

[Continues through sections...]

✓ Created spec/implementation/overview.md
✓ Set repo: recipeflow-monolith

Suggested implementations:
- Recipe ORM Models
- Recipe API Endpoints
- Analytics Calculation Service
- Scenario Comparison Engine
- Authentication & Authorization

Ready for /spec-impl?
```

## Related Commands

- `/spec-plan` - Check overall status
- `/spec-plan-arch` - Edit architecture if approach changes
- `/spec-impl` - Create individual implementations
- `/spec-task` - Create tasks for work
