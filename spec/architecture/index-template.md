---
id: ARCH-INDEX
title: System Architecture Index
status: active
last_updated: 2025-11-10
summary: Entry point for the system architecture, tech stack, and components.
next_component_id: COMP-0001
notes: ""
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, next_component_id
- Status values: draft | active
- next_component_id: The next available COMP-#### ID to assign
-->

# System Architecture Index

This directory defines the **architecture** of the system described in the Charter.

It answers:

- What technologies are used (languages, frameworks, databases, cloud services).
- How the system is broken into components, services, and repos.
- How components interact with each other and with external systems.

## Documents

### Stack Overview

- **File:** `stack-overview.md`  
- **Describes:** System-wide architecture, key technologies, deployment model, and cross-cutting concerns.

### Components

Each component has its own document with a unique ID (`COMP-####`). Components typically correspond to:

- Services or microservices
- Applications (web app, mobile app, background worker)
- Shared libraries or packages
- Data stores treated as architectural elements

| ID        | Name                        | Type        | Status | Repo / Location            | File path                                               |
|-----------|-----------------------------|-------------|--------|----------------------------|---------------------------------------------------------|
| COMP-0001 | _example service_           | service     | active | `repo-name`                | `components/COMP-0001-example-service.md`              |
| COMP-0002 | _example web app_           | web-app     | active | `repo-or-subfolder-name`   | `components/COMP-0002-example-web-app.md`              |
| COMP-0007 | _background worker_         | worker      | draft  | `repo-name`                | `components/COMP-0007-background-worker.md`            |

> **Convention:**
> - Add a row to this table for each component document.
> - Keep the table sorted by component ID.
> - Type examples: `web-app`, `service`, `worker`, `library`, `database`, `external-system`
> - Status values: `draft | active`
> - When a component is no longer needed, delete its file and remove this row.
> - Update `next_component_id` in the front matter when adding new components.

## ID Conventions

- **Architecture index:** `ARCH-INDEX` (this file).  
- **Stack overview:** `ARCH-STACK` (inside `stack-overview.md`).  
- **Components:** `COMP-####` (e.g., `COMP-0001`).

These IDs connect tiers together:

- **Charter (FEAT-####):** Which features does each component help implement?
- **Implementation (IMPL-####):** Implementation items will reference both `FEAT-####` and `COMP-####`.
- **Tasks (TASK-####):** Tasks can attach to specific components and features.

## Usage Notes (for Agents)

When planning or modifying implementation:

1. Read `stack-overview.md` to understand the overall architecture and tech choices.
2. Use the table above to find the `COMP-####` component(s) relevant to given features (`FEAT-####`) or repos.
3. Open the corresponding component document(s) before changing code or creating new components.
4. When creating a new component, use `next_component_id` from the front matter, then increment it.

---

> **Agent note:**
> This index is the entry point for all architecture-level documentation.
> Always update this table when adding or removing components.
> Keep the table sorted by ID for easy scanning.