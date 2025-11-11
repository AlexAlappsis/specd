---
id: CHARTER-INDEX
title: System Charter Index
last_updated: 2025-11-10
description: Entry point for the system charter and high-level feature definitions.
---

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
| FEAT-0001 | _example feature name_      | proposed   | `features/FEAT-0001-example-feature-name.md`    |
| FEAT-0002 | _another example feature_   | approved   | `features/FEAT-0002-another-example-feature.md` |

> **Convention:**  
> - Add a row to this table for each feature document.  
> - Keep the table sorted by feature ID.  
> - Status is typically: `proposed`, `approved`, `implemented`.

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