# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

specd is a **specification documentation framework** for organizing system documentation across four hierarchical tiers. This is a **template repository**, not a runtime application. It provides reusable Markdown templates and LLM prompts for structured specification management.

## Four-Tier Architecture

The specification system is organized into four tiers with strict cross-tier traceability:

| Tier | Path | Scope | Purpose |
|------|------|-------|---------|
| **Charter** | `/spec/charter/` | System-level | Business goals, vision, and features (FEAT-####) |
| **Architecture** | `/spec/architecture/` | System-level | Tech stack, components, and system design (COMP-####) |
| **Implementation** | `/spec/implementation/` | Repo-level | Interfaces, contracts, and data models (IMPL-####) |
| **Tasks** | `/spec/tasks/` | Repo-level | Work items and execution planning (TASK-####) |

## ID Conventions

All specification entities use unique machine-readable IDs:

- `SYS-CHARTER` - System charter document
- `FEAT-####` - Individual features (Charter tier)
- `COMP-####` - Architecture components (Architecture tier)
- `IMPL-####` - Implementation specifications (Implementation tier, includes inline test strategy)
- `TASK-####` - Work items (Tasks tier)
- `GLOSSARY` - System glossary (optional)

IDs use format NNNN (e.g., FEAT-0001, not FEAT-####). IDs do not need to be consecutive.

Cross-tier linking example: `FEAT-0002 ↔ COMP-0004 ↔ IMPL-0012 ↔ TASK-0045`

## Key Files

- [spec/readme.md](spec/readme.md) - Human-friendly guide to the 4-tier system
- [spec/agent-guide.md](spec/agent-guide.md) - Quick reference for LLM agents working with the spec system
- [spec/spec-manifest.md](spec/spec-manifest.md) - Complete manifest of all templates
- [spec/index.md](spec/index.md) - Quick-reference navigational index
- [spec/prompts/readme.md](spec/prompts/readme.md) - Guide to LLM prompt templates
- [spec/glossary-template.md](spec/glossary-template.md) - Template for shared terminology

## Template Structure

All templates use YAML front matter followed by structured Markdown sections:

```yaml
---
id: FEAT-0001
title: Example Feature Name
status: proposed
last_updated: 2025-11-10
summary: Brief one-line description
related_features: []
components: []
implementations: []
notes: "Use this field to capture decision rationale, key assumptions, or design trade-offs"
---
```

### Key Template Features

1. **Validation Rules**: Every template has HTML comment blocks with required fields, status values, ID formats, and traceability rules
2. **Cross-Tier Consistency**: Bidirectional links must be symmetric (e.g., if FEAT lists COMP, COMP must list FEAT)
3. **Template Usage Notes**: Clear instructions on replacing {{placeholder}} values
4. **Component Dependencies**: Components can depend on other components via `depends_on_components: []`
5. **Living Documents**: No deprecated/cancelled states - delete specs when no longer needed
6. **Code Location Strategy**:
   - Components define `repo_location` (e.g., "services/user-api" or "frontend/web")
   - Implementations define `source_paths` arrays relative to their component's `repo_location`
   - Full path = component's `repo_location` + implementation's `source_paths`
   - This supports single repos, monorepos, and multi-repo systems flexibly

Templates always end in `-template.md` and should be copied (not modified) when instantiating new specs.

## Status Vocabularies

- **Charter/Architecture/Implementation**: `draft | active`
- **Tasks**: `todo | in-progress | blocked | done`

## ID Tracking

Index templates include `next_*_id` fields for auto-assigning IDs:
- `next_feature_id` in charter/index-template.md
- `next_component_id` in architecture/index-template.md
- `next_impl_id` in implementation/index-template.md
- `next_task_id` in tasks/index-template.md

## Testing Strategy

Testing is documented inline within specification files rather than in separate test specs:

- **System-level:** `spec/architecture/stack-overview.md` (Section 7) defines testing philosophy, frameworks, and coverage targets
- **Implementation-level:** `spec/implementation/overview.md` (Section 6) defines test organization and framework usage
- **Spec-level:** Each `IMPL-####` spec (Section 7) defines test strategy for that specific implementation

This approach keeps test requirements co-located with the contracts they verify, providing maximum flexibility for different testing approaches.

## Workflow Guidance

When working with this repository:

1. **Understanding the system**: Start with [spec/agent-guide.md](spec/agent-guide.md) for quick reference (or [spec/readme.md](spec/readme.md) for comprehensive guide)
2. **Finding templates**: Use [spec/spec-manifest.md](spec/spec-manifest.md)
3. **Creating new specs**:
   - Copy relevant template from the appropriate tier
   - Remove `-template` suffix
   - Fill in YAML front matter with unique ID from `next_*_id`
   - Replace all {{placeholder}} values with actual data
   - Follow the structured sections in the template
   - Update corresponding index table
   - Increment `next_*_id` in the index
   - Update cross-tier backlinks in related specs

4. **Using prompts**: Reference [spec/prompts/](spec/prompts/) for creation and maintenance workflows
   - Creation prompts guide new spec generation
   - Maintenance prompts guide updates after code/design changes
   - Cross-tier sync prompt ensures consistency

### Task Tier: Execution Planning Layer

The Task tier (TASK-####) is **mandatory** and serves as the execution planning layer:

**Purpose:**
- Translate implementation specs into actionable work items
- Define execution order through priorities and dependencies
- Track progress and completion status
- Separate "what to build" (IMPL) from "when/how to build it" (TASK)

**Task Scope:**
- **Simple implementations**: Create one task that references the IMPL
- **Complex implementations**: Break into multiple phased tasks with dependencies

**Workflow:**
- `FEAT → COMP → IMPL → TASK → Code generation`
- Tasks always reference IMPL specs for detailed contracts
- Code generation always reads from TASK-#### (which points to IMPL-#### for details)

## Cross-Tier Traceability

The system uses redundant bidirectional links for efficient navigation:

**Features** track:
- `components: []` - Components implementing this feature
- `implementations: []` - Implementation specs for this feature

**Components** track:
- `features: []` - Features this component implements
- `implementations: []` - Implementation specs for this component
- `depends_on_components: []` - Other components this depends on

**Implementations** track:
- `features: []` - Features this implementation supports
- `components: []` - Components this implementation belongs to

**Tasks** track (one-way):
- `features: []`, `components: []`, `implementations: []` - Related specs
- `depends_on: []` - Task or implementation dependencies

## LLM/Agent Prompts

The `/spec/prompts/` directory contains reusable prompt templates:

- **Creation prompts** (`/prompts/creation/`): Guide agents through creating new spec files
- **Maintenance prompts** (`/prompts/maintenance/`): Guide updates to existing specs
- **Cross-tier sync**: Ensure consistency across all four tiers

These prompts include clarifying questions and confirmation steps to prevent accidental overwrites.

## Philosophy

- **Living documents**: Specs evolve with the system; history lives in git
- **Atomic updates**: Code changes paired with spec changes
- **Minimal enforcement**: Lightweight conventions, flexible workflows
- **LLM-friendly**: Designed with agents in mind (structured IDs, YAML front matter, consistent templates)
- **Redundant traceability**: Optimizes for reads over writes - same links stored in multiple places

## Slash Commands (Implemented)

### Installation Process

**First-time setup:**
1. Add as submodule: `git submodule add <url> .specdocs`
2. Run install script: `bash .specdocs/install.sh`
   - Copies templates from `.specdocs/spec/` → `./spec/`
   - Copies commands from `.specdocs/.claude/commands/` → `./.claude/commands/`
3. Plan your system: `/spec-plan` guides cooperative planning and initializes tiers as needed

### Available Commands
These are copied to `/.claude/commands/` by install.sh:

**Planning & Overview:**
- `/spec-plan` - Cooperative planning for Charter, Architecture, and Implementation overviews
  - Initializes tiers if needed (creates working files from templates)
  - Works tier-by-tier with intelligent context loading
  - Supports editing existing overviews and adding specifics
  - Asks informed questions based on high-level context

**Creating & Editing Specifics:**
- `/spec-feature [FEAT-####]` - Create new or edit existing feature specification
- `/spec-component [COMP-####]` - Create new or edit existing component specification
- `/spec-impl [IMPL-####]` - Create new or edit existing implementation specification (includes inline test strategy)
- `/spec-task` - Create new TASK-#### with traceability links

**Validation:**
- `/spec-sync` - Validate cross-tier consistency and fix broken links

### How Commands Work

**Template Source:**
- After installation, commands read from `./spec/*-template.md` (working copies)
- `/spec-plan` creates working files from templates when initializing tiers
- Users can customize templates per-project in `./spec/`
- Original templates in `.specdocs/spec/` remain pristine

**Auto-ID Assignment:**
- Commands read `next_*_id` from index files (e.g., `next_feature_id: FEAT-0005`)
- Auto-assign next ID and increment counter
- IDs use NNNN format with leading zeros

**Cross-Tier Linking:**
- Commands automatically update bidirectional links
- Example: Creating COMP-0003 for FEAT-0002:
  1. Creates `COMP-0003-*.md` with `features: ["FEAT-0002"]`
  2. Opens `FEAT-0002-*.md` and adds `"COMP-0003"` to `components: []`
  3. Both files now have bidirectional links

### Skills (Cross-Project Reusable)
These will be implemented as Claude skills:

- `specdocs-analyst` - Analyze existing codebase and generate draft specs
- `specdocs-generator` - Generate code from TASK-#### (reads referenced IMPL-#### for contracts)
- `specdocs-validator` - Comprehensive validation of spec consistency

### Example Workflows

**Complete planning workflow:**
```
1. /spec-plan → Cooperatively fill in system charter (SYS-CHARTER)
2. /spec-plan → Cooperatively plan architecture overview (ARCH-STACK) including testing strategy
3. /spec-plan → Cooperatively plan implementation overview (IMPL-OVERVIEW) including test organization
4. /spec-feature → Create individual features (FEAT-####)
5. /spec-component → Create individual components (COMP-####)
6. /spec-impl → Create implementations with inline test strategy (IMPL-####)
7. /spec-task → Create execution tasks (TASK-####)
8. /spec-sync → Validate consistency
```

**Simple implementation (single task):**
```
1. /spec-feature → Creates FEAT-0010.md
2. /spec-component → Creates COMP-0015.md, links to FEAT-0010, updates both specs
3. /spec-impl → Creates IMPL-0042.md (includes Section 7 for test strategy)
   - Links to FEAT-0010 and COMP-0015, updates all
4. /spec-task → Creates TASK-0100.md, references IMPL-0042, priority P2
5. specdocs-generator TASK-0100 → Generates code and tests (reads IMPL-0042 for contracts and test requirements)
6. /spec-sync → Validates all links are bidirectional and consistent
```

**Complex implementation (multi-phase tasks):**
```
1. /spec-feature → Creates FEAT-0010.md
2. /spec-component → Creates COMP-0015.md, links to FEAT-0010
3. /spec-impl → Creates IMPL-0042.md (large/complex implementation with comprehensive test strategy in Section 7)
4. /spec-task → Creates TASK-0100.md (Phase 1: Data models, priority P0, references IMPL-0042)
5. /spec-task → Creates TASK-0101.md (Phase 2: Business logic, priority P1, depends on TASK-0100)
6. /spec-task → Creates TASK-0102.md (Phase 3: API endpoints, priority P1, depends on TASK-0101)
7. specdocs-generator TASK-0100 → Generates data models and tests (reads IMPL-0042 for schemas and test requirements)
8. specdocs-generator TASK-0101 → Generates business logic and tests (reads IMPL-0042 for invariants and test scenarios)
9. specdocs-generator TASK-0102 → Generates API layer and tests (reads IMPL-0042 for endpoints and test cases)
10. /spec-sync → Validates consistency
```

## Version Control

This is a git repository. No build process, runtime code, or testing framework exists—this is purely documentation and templates.
