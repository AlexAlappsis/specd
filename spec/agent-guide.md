# Specification System Agent Guide

Quick reference for LLM agents working with the four-tier specification system.

## Four-Tier Structure

| Tier | Path | Scope | Purpose | Key Files |
|------|------|-------|---------|-----------|
| **Charter** | `spec/charter/` | System-level | Goals, vision, features (FEAT-####) | `system-charter.md`, `index.md`, `features/FEAT-####-*.md` |
| **Architecture** | `spec/architecture/` | System-level | Tech stack, components (COMP-####), system design | `stack-overview.md`, `index.md`, `components/COMP-####-*.md` |
| **Implementation** | `spec/implementation/` | Repo-level | Interfaces, contracts, data models (IMPL-####), inline test strategy | `overview.md`, `index.md`, `contracts/IMPL-####-*.md` |
| **Tasks** | `spec/tasks/` | Repo-level | Work items (TASK-####), execution planning | `backlog.md`, `index.md`, `items/TASK-####-*.md` |

## ID Conventions

- `SYS-CHARTER` - System charter document (one per system)
- `FEAT-####` - Features (Charter tier) - format: FEAT-0001, FEAT-0002, etc.
- `COMP-####` - Components (Architecture tier) - format: COMP-0001, COMP-0002, etc.
- `IMPL-####` - Implementations (Implementation tier) - format: IMPL-0001, IMPL-0002, etc.
- `TASK-####` - Tasks (Tasks tier) - format: TASK-0001, TASK-0002, etc.
- `GLOSSARY` - System glossary (optional)

IDs use four-digit format with leading zeros (e.g., FEAT-0001, not FEAT-1 or FEAT-####).

## Cross-Tier Traceability

**Bidirectional links** (redundant storage for efficient navigation):

**Features** track:
- `components: []` - Which components implement this feature
- `implementations: []` - Which implementations support this feature

**Components** track:
- `features: []` - Which features this component implements
- `implementations: []` - Which implementations belong to this component
- `depends_on_components: []` - Other components this depends on

**Implementations** track:
- `features: []` - Which features this implementation supports
- `components: []` - Which components this implementation belongs to

**Tasks** track (one-way, points upward):
- `features: []`, `components: []`, `implementations: []` - Related specs
- `depends_on: []` - Task or implementation dependencies

**Mandatory workflow:**
```
FEAT → COMP → IMPL → TASK → Code generation
```

Tasks are **mandatory** - separate "what to build" (IMPL) from "when/how to build it" (TASK).

## Code Location Strategy

Components define `repo_location`, implementations define `source_paths`:

**Component YAML:**
```yaml
repo_location: "services/user-api"  # or "frontend/web" or "backend"
```

**Implementation YAML:**
```yaml
source_paths:
  - "src/models/user.py"
  - "src/api/users.py"
```

**Full path** = component's `repo_location` + implementation's `source_paths`

This supports single repos, monorepos, and multi-repo systems flexibly.

## Testing Strategy (Three Levels)

Testing is documented **inline**, not in separate test specs:

1. **System-level:** `spec/architecture/stack-overview.md` Section 7 - Testing philosophy, frameworks, coverage targets
2. **Repo-level:** `spec/implementation/overview.md` Section 6 - Test organization, framework usage for this repo
3. **Spec-level:** Each `IMPL-####` Section 7 - Test strategy for that specific implementation

When generating code from TASK-####, read the referenced IMPL-#### Section 7 for test requirements.

## Status Vocabularies

- **Charter/Architecture/Implementation:** `draft | active`
- **Tasks:** `todo | in-progress | blocked | done`

## Index Files and Auto-ID Assignment

Each tier has an `index.md` with `next_*_id` field for auto-assigning IDs:

- `spec/charter/index.md` → `next_feature_id: FEAT-0005`
- `spec/architecture/index.md` → `next_component_id: COMP-0012`
- `spec/implementation/index.md` → `next_impl_id: IMPL-0027`
- `spec/tasks/index.md` → `next_task_id: TASK-0100`

When creating new specs:
1. Read `next_*_id` from index
2. Use that ID for the new spec
3. Increment `next_*_id` in index
4. Update index table with new row

## YAML Front Matter Structure

All specs use YAML front matter:

```yaml
---
id: FEAT-0001
title: Example Feature
status: draft
last_updated: 2025-11-19
summary: Brief one-line description
related_features: []
components: ["COMP-0003"]
implementations: ["IMPL-0012"]
notes: "Optional notes field for rationale, assumptions, trade-offs"
---
```

## Planning Workflow

**Complete planning workflow:**
1. Plan charter overview (`SYS-CHARTER`) - cooperative, iterative
2. Define features (`FEAT-####`) - one per capability area
3. Plan architecture overview (`ARCH-STACK`) - includes testing strategy
4. Define components (`COMP-####`) - one per major system boundary
5. Plan implementation overview (`IMPL-OVERVIEW`) - repo-specific
6. Define implementations (`IMPL-####`) - includes inline test strategy (Section 7)
7. Create tasks (`TASK-####`) - at least one per implementation

**Code generation workflow:**
1. Read `TASK-####` to understand priority and what to build
2. Follow `implementations: []` link to get `IMPL-####`
3. Read IMPL-#### for contracts, data models, invariants, test strategy (Section 7)
4. Generate code and tests according to IMPL spec
5. Update TASK status to `in-progress` → `done`

## Multi-Repository Support

**Implementation tier is repo-specific:**
- Single repo: One `spec/implementation/overview.md`
- Multi-repo: Multiple overview files, each with `repo` field in front matter
- Each implementation overview lists which components it implements

**Task tier is also repo-specific:**
- Tasks reference implementations from their repo
- Cross-repo dependencies documented in task `depends_on: []`

## Living Documents Philosophy

- No deprecated/cancelled states - **delete specs** when no longer needed
- History lives in git, not in document status
- Specs evolve with system through atomic updates (code change + spec change)
- Bidirectional links must be symmetric (if FEAT lists COMP, COMP must list FEAT)

## Template Files

Templates end in `-template.md`:
- `spec/charter/system-charter-template.md`
- `spec/charter/features/feature-template.md`
- `spec/architecture/stack-overview-template.md`
- `spec/architecture/components/component-template.md`
- `spec/implementation/overview-template.md`
- `spec/implementation/contracts/implementation-template.md`
- `spec/tasks/backlog-template.md`
- `spec/tasks/items/task-template.md`

**Copy template (not modify) when instantiating new specs.** Remove `-template` suffix.

## Validation Rules (from template HTML comments)

**Charter:**
- Status: `draft | active`
- Features array must reference valid FEAT-#### IDs
- Components array must reference valid COMP-#### IDs

**Architecture:**
- Status: `draft | active`
- Features array must reference valid FEAT-#### IDs
- Implementations array must reference valid IMPL-#### IDs
- Components can depend on other components via `depends_on_components: []`

**Implementation:**
- Status: `draft | active`
- Features array must reference valid FEAT-#### IDs
- Components array must reference valid COMP-#### IDs
- Source paths relative to component's `repo_location`
- Section 7 must define test strategy

**Tasks:**
- Status: `todo | in-progress | blocked | done`
- Priority: `P0 | P1 | P2 | P3` (P0 = highest)
- Must reference at least one IMPL-####
- Dependencies can be other TASKs or IMPLs

## Quick Command Reference

When working with this system, use these slash commands (if available):

- `/spec-plan` - Show planning status across all tiers, route to next step
- `/spec-plan-charter` - Plan/edit charter overview cooperatively
- `/spec-plan-arch` - Plan/edit architecture overview cooperatively
- `/spec-plan-impl` - Plan/edit implementation overview cooperatively
- `/spec-feature` - Create/edit individual feature (FEAT-####)
- `/spec-component` - Create/edit component (COMP-####)
- `/spec-impl` - Create/edit implementation (IMPL-####) with inline test strategy
- `/spec-task` - Create task (TASK-####)
- `/spec-sync` - Validate cross-tier consistency

## Key Differences from Traditional Documentation

1. **Four tiers, not three** - Tasks tier separates planning from specification
2. **Inline testing** - No separate TEST-#### specs, testing documented in IMPL Section 7
3. **Bidirectional links** - Same links stored in multiple places for navigation
4. **Mandatory tasks** - Code generation requires TASK → IMPL flow
5. **Machine-readable IDs** - All entities have unique IDs for traceability
6. **Living documents** - Delete when obsolete, don't mark as deprecated
7. **Repo-aware** - Implementation and Tasks tiers are repository-specific

## Reading Priority for Agents

**For planning:**
1. Charter overview (`system-charter.md`)
2. Architecture overview (`stack-overview.md`)
3. Implementation overview (`overview.md`)
4. Relevant index files for counts/summaries

**For code generation:**
1. Task spec (`TASK-####`)
2. Implementation spec (`IMPL-####`) - especially Section 7 for tests
3. Component spec (`COMP-####`) for context
4. Feature spec (`FEAT-####`) for business context

**Do NOT load all specs** - use index files for summaries, load specifics only when needed.
