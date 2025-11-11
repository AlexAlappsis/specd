---
id: IMPL-INDEX
title: Implementation Index (Repo-Level)
last_updated: 2025-11-10
description: Entry point for implementation specs (contracts, modules, and data models) for this repository.
repo: your-repo-name-or-path
---

# Implementation Index (Repo-Level)

This directory defines **implementation-level specs** for this repository.

It answers:

- What implementation areas (IMPL-####) exist in this repo.
- Which features (`FEAT-####`) and components (`COMP-####`) they support.
- Where to find the detailed contracts and data models.

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

| ID        | Name                              | Main Component (`COMP-####`) | Primary Features (`FEAT-####`)      | File path                                                   |
|-----------|-----------------------------------|------------------------------|-------------------------------------|-------------------------------------------------------------|
| IMPL-0001 | _example implementation area_     | `COMP-0001`                  | `FEAT-0001`, `FEAT-0002`            | `contracts/IMPL-0001-example-impl.md`                       |
| IMPL-0002 | _another implementation area_     | `COMP-0002`                  | `FEAT-0003`                         | `contracts/IMPL-0002-another-impl.md`                       |

> **Convention:**  
> - Add a row for each `IMPL-####` document.  
> - Keep the table sorted by implementation ID.  
> - If an implementation item spans multiple components, list the primary one here and detail the rest in the IMPL doc.

### Tests (Optional)

Tests can be documented per implementation item.

- Folder: `tests/`
- Typical file: `tests/IMPL-0001-*-tests.md`

Use these docs to:

- Capture test strategy and important scenarios.  
- Map features (`FEAT-####`) and implementation items (`IMPL-####`) to test coverage.

## ID Conventions

- **Implementation index (this file):** `IMPL-INDEX`.  
- **Implementation overview:** `IMPL-OVERVIEW` (inside `overview.md`).  
- **Implementation items:** `IMPL-####` (e.g., `IMPL-0001`).

## Relationships to Other Tiers

- **Charter (System) – `FEAT-####`:**
  - Implementation items exist to realize specific features.
- **Architecture – `COMP-####`:**
  - Each implementation item belongs primarily to one component, even if it interacts with others.
- **Tasks – `TASK-####`:**
  - Concrete work items reference implementation IDs.

## Usage Notes (for Agents)

When implementing or modifying code in this repo:

1. Read `overview.md` to understand the repo’s role and main implementation areas.  
2. Use the table above to find the `IMPL-####` entry that matches the feature (`FEAT-####`) and component (`COMP-####`) you’re working on.  
3. Open the corresponding `contracts/IMPL-####-*.md` document for detailed contracts, data models, and invariants.  
4. After implementing or changing behavior, update the relevant IMPL doc and, if applicable, add or adjust the corresponding tests doc in `tests/`.