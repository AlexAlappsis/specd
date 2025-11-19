Plan or edit the Implementation tier overview document cooperatively.

**Before starting:** Read [spec/readme.md](../spec/readme.md) to understand the Implementation tier's role in the four-tier specification system.

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

1. **Check Charter and Architecture tiers are complete:**
   - Try to open `spec/charter/system-charter.md`
   - Try to open `spec/architecture/stack-overview.md`
   - If either not found or has {{placeholder}} values:
     ```
     Error: Charter and Architecture tiers must be complete before planning implementation.

     Current state:
     - Charter: [not started / incomplete / complete]
     - Architecture: [not started / incomplete / complete]

     Please complete both tiers first:
     - Run /spec-plan-charter to complete charter
     - Run /spec-plan-arch to complete architecture
     - Run /spec-plan to check status

     Then return here to plan your implementation.
     ```
     Exit without proceeding.

   - If both exist and are complete, continue

2. **Load charter and architecture for context:**
   - Parse charter to understand system goals
   - Parse architecture to understand components and tech stack
   - This context informs implementation questions

### Phase 2: Determine Repository Context

**Important:** Implementation overview is repo-specific. Multiple repositories have separate implementation overviews.

1. **Ask about repository structure:**
   ```
   Is this a single repository or multiple repositories?

   - Single repository: All components in one repo
   - Multiple repositories: Microservices, separate frontend/backend, etc.
   ```

2. **If single repository:**
   - Continue with single implementation overview
   - Repository name defaults to project name or ask user

3. **If multiple repositories:**
   ```
   Which repository do you want to plan implementation for?

   Based on your architecture, I see components:
   - [List components from architecture]

   Common repository patterns:
   - Backend API repository
   - Frontend application repository
   - Shared libraries repository

   Which repository are we planning?
   ```

   - Get repository name from user
   - Note: User will need to run `/spec-plan-impl` separately for each repository

### Phase 3: Determine Mode

1. **Try to load existing implementation overview:**
   - Try to open `spec/implementation/overview.md`
   - If found, check if it's for the correct repository (check `repo` field in front matter)
   - If repo matches, use **EDIT MODE**
   - If repo doesn't match or not found, use **CREATE MODE**

2. **Try to load implementation index:**
   - Try to open `spec/implementation/index.md`
   - If found, check if it's for correct repository
   - If not found or different repo, will need to initialize in CREATE mode

### Phase 4A: CREATE MODE - New Implementation Overview

If implementation doesn't exist for this repository, create it cooperatively:

1. **Initialize implementation tier if needed:**
   - If `spec/implementation/index.md` doesn't exist or is for different repo:
     ```
     Implementation tier not initialized for repo "{repo-name}". Initializing...

     ✓ Created spec/implementation/index.md
     ✓ Set repo: {repo-name}
     ✓ Set next_impl_id: IMPL-0001
     ```

2. **Get high-level context first:**
   ```
   Let's plan the implementation approach for repository: {repo-name}

   I've reviewed your architecture - [brief summary of components and tech stack].

   For repository "{repo-name}":
   - Which components (COMP-####) does this repo implement?
   - What's the internal structure? (folders, layers, modules)
   - What are the main implementation areas within this repo?
   ```

3. **Work section by section through the implementation template:**

   Load `spec/implementation/overview-template.md` to understand structure.

   **Section 1: Metadata** (YAML front matter)
   - Set `id: IMPL-OVERVIEW`
   - Set `repo: {repo-name}`
   - Set `status: draft`
   - Set `last_updated` to today's date (YYYY-MM-DD)
   - Set `components: []` - list of COMP-#### IDs this repo implements

   **Section 2: Repository Overview**
   - Based on components this repo implements, draft repository purpose
   - Reference architecture decisions
   - Show to user and ask for confirmation/refinement

   **Section 3: Implementation Structure**
   - Ask about internal organization:
     - "What's your folder/module structure?"
     - "How do you organize by layer (e.g., controllers, services, repositories)?"
     - "Any specific patterns (e.g., clean architecture, DDD)?"
   - Draft structure section with folder tree

   **Section 4: Data Models**
   - Based on components and charter features, ask:
     - "What are the main entities/models in this repo?"
     - "Any shared data schemas or domain models?"
   - Draft data models section

   **Section 5: External Integrations**
   - Reference architecture external integrations
   - Ask which ones this repo implements
   - Draft integrations section specific to this repo

   **Section 6: Testing Approach**
   - Reference architecture Section 7 (Testing Strategy) for framework choices
   - Ask about repo-specific testing:
     - "How is testing organized in this repo?"
     - "Test coverage targets?"
     - "Integration test approach?"
   - Draft testing approach section

4. **Suggest custom sections:**
   ```
   Based on your [technology/patterns], are there other aspects to document?
   For example:
   - [Specific suggestion based on context]
   ```

5. **Final review:**
   - Show complete implementation overview structure
   - Ask for final confirmation before saving

6. **Save implementation overview:**
   ```
   ✓ Created spec/implementation/overview.md
   ✓ Set repo: {repo-name}
   ```

7. **Suggest next steps:**
   ```
   Implementation overview complete for {repo-name}! ✓

   Next steps:
   1. Define individual implementations: /spec-impl
   2. Check planning status: /spec-plan

   Suggested implementations based on your overview:
   - [Implementation area 1 from Section 3/4]
   - [Implementation area 2 from Section 3/4]
   - [Implementation area 3 from Section 3/4]

   Ready to create the first implementation?
   ```

### Phase 4B: EDIT MODE - Existing Implementation Overview

If implementation overview exists for this repo, help user edit it:

1. **Load and show current implementation:**
   ```
   Loaded spec/implementation/overview.md

   Repository: {repo-name}
   Components: [list of COMP-####]
   Status: [status]
   Last updated: [date]

   Sections:
   [List main section headings and brief content summary]

   What would you like to update?
   - Specific section (e.g., "Implementation Structure", "Data Models")
   - Add new section
   - Update metadata (status, components, etc.)
   - Review and refine entire overview
   ```

2. **Cooperative editing:**
   - Similar to charter/architecture edit mode
   - Work section by section as user requests
   - Update `last_updated` date
   - If components[] array changes, note this may affect cross-tier links

3. **Save updates:**
   ```
   ✓ Updated spec/implementation/overview.md
   ✓ Updated last_updated to [today's date]

   [If implementation areas changed:]
   Note: Implementation areas updated. Run /spec-plan to check if any
   implementation discrepancies were introduced or resolved.
   ```

## Important Notes

**Multi-Repository Support:**
- Each repository has its own implementation overview
- If user has multiple repos, they run `/spec-plan-impl` multiple times
- Each implementation overview has `repo` field in front matter
- Implementation index files can be separate per repo or combined

**Architecture Context:**
- Always load and reference architecture when planning implementation
- Ask implementation questions informed by architecture components and tech stack
- Suggest implementation areas that map to architecture components

**Tier Separation:**
- Implementation defines CONTRACTS (APIs, data models, invariants, test strategy)
- Stay at interface/contract level, not detailed code implementation
- Focus on WHAT needs to be implemented, not HOW to implement it

**Smart Suggestions:**
- Based on tech stack (e.g., FastAPI), suggest structure (routers, services, schemas)
- Based on components (e.g., Database Layer), suggest implementations (ORM models, migrations)
- Based on architecture patterns (e.g., DDD), suggest structure (entities, aggregates, repositories)

**Testing Integration:**
- Reference architecture Section 7 for testing philosophy and frameworks
- Implementation overview Section 6 focuses on how testing is organized in THIS repo
- Individual IMPL-#### specs (Section 7) define test strategy for specific implementations

## Example Interaction - CREATE MODE (Single Repo)

```
User: /spec-plan-impl

Claude: Is this a single repository or multiple repositories?

User: Single repository

Claude: Let's plan the implementation approach for your repository.

I've reviewed your architecture - modular monolith with Python/FastAPI backend,
PostgreSQL database, and React frontend. Three core modules: Recipe Management,
Analytics Engine, Scenario Modeling.

What should we name this repository?

User: recipeflow-monolith

Claude: For repository "recipeflow-monolith":
- Which components does this repo implement? (Looking at your architecture,
  I see: Recipe Management Module, Analytics Engine Module, Scenario Modeling
  Module, Web API Layer, Database Layer, Authentication Service, Frontend Application)
- All of them, or a subset?

User: All except Frontend Application - that's a separate repo we'll plan later

Claude: Got it! So recipeflow-monolith implements the backend components.

What's the internal folder structure? For FastAPI projects, I typically see
something like:

/app
  /api          # API routes/endpoints
  /core         # Core business logic
  /db           # Database models and migrations
  /services     # Service layer
  /schemas      # Pydantic schemas
  /tests        # Test suites

Does this match your structure, or do you organize differently?

[User provides structure]

Let me draft Section 3 (Implementation Structure):

---
## 3. Implementation Structure

Repository follows a layered architecture pattern organized by feature modules:

```
recipeflow-monolith/
├── app/
│   ├── api/                    # FastAPI routers
│   │   ├── recipes/            # Recipe Management endpoints
│   │   ├── analytics/          # Analytics endpoints
│   │   └── scenarios/          # Scenario endpoints
│   ├── core/                   # Business logic
│   │   ├── recipes/            # Recipe domain logic
│   │   ├── analytics/          # Analytics calculations
│   │   └── scenarios/          # Scenario modeling
│   ├── db/                     # Database layer
│   │   ├── models/             # SQLAlchemy ORM models
│   │   └── migrations/         # Alembic migrations
│   ├── services/               # Service layer
│   │   ├── auth.py             # Authentication service
│   │   └── audit.py            # Audit logging (FDA compliance)
│   ├── schemas/                # Pydantic request/response schemas
│   └── tests/                  # Test suites
│       ├── unit/
│       ├── integration/
│       └── e2e/
└── requirements.txt
```

**Module Organization:**
Each feature module (recipes, analytics, scenarios) contains:
- API routes in `/api/{module}/`
- Business logic in `/core/{module}/`
- Database models in `/db/models/{module}_models.py`
- Pydantic schemas in `/schemas/{module}_schemas.py`
---

Does this structure look right?

[Continues through remaining sections...]

✓ Created spec/implementation/overview.md
✓ Set repo: recipeflow-monolith
✓ Set components: [COMP-0001, COMP-0002, COMP-0003, COMP-0004, COMP-0005]

Implementation overview complete for recipeflow-monolith! ✓

Suggested implementations to create:
- Recipe ORM Models (database layer for recipes)
- Recipe API Endpoints (REST API for recipe management)
- Analytics Calculation Service (cost analysis business logic)
- Scenario Comparison Engine (what-if modeling)
- Authentication & Authorization (auth service)

Ready to define these implementations with /spec-impl?
```

## Example Interaction - EDIT MODE

```
User: /spec-plan-impl

Claude: Loaded spec/implementation/overview.md

Repository: recipeflow-monolith
Components: COMP-0001, COMP-0002, COMP-0003, COMP-0004, COMP-0005
Status: draft
Last updated: 2025-11-15

Sections:
- Repository Overview: Backend monolith implementing all backend components
- Implementation Structure: Layered architecture by feature modules
- Data Models: Recipe, Ingredient, Scenario, User entities
- External Integrations: Market Data API client
- Testing Approach: Pytest, 80% coverage target, integration tests with TestClient

What would you like to update?

User: Need to add caching layer implementation details

Claude: Good addition! Where should we document the caching details?
I see a few options:

1. Add to Section 3 (Implementation Structure) - show where cache code lives
2. Add to Section 4 (Data Models) - document cached data models
3. Add new Section: Caching Strategy - comprehensive caching approach

Which makes most sense for your needs?

User: New section for caching strategy

Claude: Let me draft a new Section 7: Caching Strategy:

---
## 7. Caching Strategy

**Cache Layer Implementation:**
- **Technology:** Redis 7+ for distributed caching
- **Use Cases:**
  - Market data pricing (1-hour TTL)
  - Recipe calculations (cache-aside pattern)
  - User session data
  - API rate limiting

**Implementation Details:**
- Redis client in `/app/services/cache.py`
- Cache decorators for service methods
- Cache invalidation on data updates
- Distributed lock for cache stampede prevention

**Data Cached:**
- Ingredient pricing from market data API
- Computed recipe costs and analytics
- Scenario comparison results

**Configuration:**
- Connection pooling (max 10 connections)
- Serialization: JSON for simple types, pickle for complex objects
- Monitoring: Cache hit/miss rates logged to observability platform
---

Does this capture your caching approach? Any other details to add?

[User confirms or refines]

✓ Added Section 7: Caching Strategy
✓ Updated spec/implementation/overview.md
✓ Updated last_updated to 2025-11-19

This caching implementation may warrant specific IMPL-#### specs:
- Redis Cache Service implementation
- Cache-aside pattern decorators
- Cache invalidation hooks

Consider creating these with /spec-impl.
```

## Related Commands

- **`/spec-plan`** - Check overall planning status across all tiers
- **`/spec-plan-arch`** - Edit architecture if implementation approach changes
- **`/spec-impl`** - Create individual implementation specifications
- **`/spec-task`** - Create tasks for implementation work
