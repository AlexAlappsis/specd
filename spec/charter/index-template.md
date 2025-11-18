---
id: CHARTER-INDEX
title: System Charter Index
status: active
last_updated: 2025-11-10
summary: Entry point for the system charter and high-level feature definitions.
next_feature_id: FEAT-0001
notes: ""
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, next_feature_id
- Status values: draft | active
- next_feature_id: The next available FEAT-#### ID to assign
-->

# System Charter Index

This directory defines the **product charter** for this system.

It answers:

- What problem this system solves.
- Who it serves.
- The major features and capabilities (by ID).
- Any major constraints or non-goals.

## Documents

### System Charter

- **File:** `system-charter.md`  
- **Describes:** Overall purpose, scope, stakeholders, high-level capabilities, non-goals.

### Features

Each feature has its own document with a unique ID (`FEAT-####`).

| ID        | Name                        | Status     | File path                                       |
|-----------|-----------------------------|------------|-------------------------------------------------|
| FEAT-0001 | _example feature name_      | active     | `features/FEAT-0001-example-feature-name.md`    |
| FEAT-0002 | _another example feature_   | draft      | `features/FEAT-0002-another-example-feature.md` |
| FEAT-0005 | _third feature example_     | draft      | `features/FEAT-0005-third-feature-example.md`   |

> **Convention:**
> - Add a row to this table for each feature document.
> - Keep the table sorted by feature ID.
> - Status values: `draft | active`
> - When a feature is no longer needed, delete its file and remove this row.
> - Update `next_feature_id` in the front matter when adding new features.

## ID Conventions

- **System charter:** `SYS-CHARTER` (inside `system-charter.md`).  
- **Features:** `FEAT-####` (e.g., `FEAT-0001`).

## Usage Notes (for Agents)

When reasoning about this system:

1. Read `system-charter.md` first to understand the overall product.
2. Find relevant features in the table above by searching for:
   - Feature ID (e.g., `FEAT-0001`), or
   - Keywords in the feature name.
3. Open the corresponding feature document before planning architecture or implementation.
4. When creating a new feature, use `next_feature_id` from the front matter, then increment it.

---

> **Agent note:**
> This index is the entry point for all charter-level documentation.
> Always update this table when adding or removing features.
> Keep the table sorted by ID for easy scanning.