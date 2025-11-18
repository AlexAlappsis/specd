---
id: IMPL-INDEX
title: Implementation Index
status: active
last_updated: 2025-11-10
summary: Entry point for implementation specs (contracts, modules, and data models).
next_impl_id: IMPL-0001
notes: ""
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, next_impl_id
- Status values: draft | active
- next_impl_id: The next available IMPL-#### ID to assign
-->

# Implementation Index

This directory defines **implementation-level specs** for the system.

It answers:

- What implementation areas (IMPL-####) exist.
- Which features (`FEAT-####`) and components (`COMP-####`) they support.
- Where to find the detailed contracts and data models.
- Where the source code lives (via `source_paths` relative to component's `repo_location`).

## Documents

### Implementation Overview

- **File:** `overview.md`  
- **Describes:** Repo-level role, mapping to architecture components, and high-level breakdown of implementation areas.

### Implementation Items (IMPL-####)

Each implementation item has its own document with a unique ID (`IMPL-####`). Implementation items typically correspond to:

- Modules or bounded contexts within the repo
- API surfaces (e.g., a set of endpoints around a domain concept)
- Core workflows or pipelines
- Shared libraries within the repo

| ID        | Name                              | Status | Primary Component | Primary Features        | File path                                                   |
|-----------|-----------------------------------|--------|-------------------|-------------------------|-------------------------------------------------------------|
| IMPL-0001 | _example implementation area_     | active | `COMP-0001`       | `FEAT-0001`, `FEAT-0002`| `contracts/IMPL-0001-example-impl.md`                       |
| IMPL-0002 | _another implementation area_     | active | `COMP-0002`       | `FEAT-0005`             | `contracts/IMPL-0002-another-impl.md`                       |
| IMPL-0008 | _third implementation area_       | draft  | `COMP-0007`       | `FEAT-0001`             | `contracts/IMPL-0008-third-impl.md`                         |

> **Convention:**
> - Add a row for each `IMPL-####` document.
> - Keep the table sorted by implementation ID.
> - Status values: `draft | active`
> - If an implementation item spans multiple components, list the primary one here and detail the rest in the IMPL doc.
> - When an implementation is no longer needed, delete its file and remove this row.
> - Update `next_impl_id` in the front matter when adding new implementations.

### Testing

Testing strategy is documented inline within each implementation spec:

- **Architecture-level:** `../architecture/stack-overview.md` (Section 7) defines system-wide testing philosophy
- **Implementation-level:** `overview.md` (Section 6) defines testing approach and organization
- **Spec-level:** Each `IMPL-####` spec (Section 7) defines test strategy for that implementation

This approach keeps test requirements co-located with the contracts they verify.

## ID Conventions

- **Implementation index (this file):** `IMPL-INDEX`.  
- **Implementation overview:** `IMPL-OVERVIEW` (inside `overview.md`).
- **Implementation items:** `IMPL-####` (e.g., `IMPL-0001`).

## Relationships to Other Tiers

- **Charter (System) – `FEAT-####`:**
  - Implementation items exist to realize specific features.
- **Architecture – `COMP-####`:**
  - Each implementation item belongs primarily to one component, even if it interacts with others.
  - The component's `repo_location` field defines where the code lives.
  - Implementation `source_paths` are relative to the component's `repo_location`.
- **Tasks – `TASK-####`:**
  - Concrete work items reference implementation IDs.

## Usage Notes (for Agents)

When implementing or modifying code:

1. Read `overview.md` to understand the main implementation areas.
2. Use the table above to find the `IMPL-####` entry that matches the feature (`FEAT-####`) and component (`COMP-####`) you're working on.
3. Open the corresponding `contracts/IMPL-####-*.md` document for detailed contracts, data models, invariants, and test strategy.
4. Check the component's `repo_location` to know where the code lives.
5. Use the implementation's `source_paths` (relative to component's `repo_location`) to locate specific files.
6. Review Section 7 (Testing Strategy) of the IMPL spec for test requirements.
7. After implementing or changing behavior, update the relevant IMPL doc including test strategy as needed.
8. When creating a new implementation, use `next_impl_id` from the front matter, then increment it.

---

> **Agent note:**
> This index is the entry point for all implementation-level documentation.
> Always update this table when adding or removing implementation specs.
> Keep the table sorted by ID for easy scanning.
> Source code locations are defined by: component's `repo_location` + implementation's `source_paths`.