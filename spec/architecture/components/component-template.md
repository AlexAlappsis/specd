---
id: COMP-0001
title: Example Component Name
status: active
last_updated: 2025-11-10
summary: Brief one-line description of what this component does.
component_type: service
repo: your-repo-name-or-path
features: []
implementations: []
depends_on_components: []
notes: "Use this field to capture decision rationale, key assumptions, or design trade-offs"
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated, component_type, repo
- id format: COMP-NNNN (e.g., COMP-0001)
- Status values: draft | active
- component_type values: web-app | service | worker | library | database | external-system
- Traceability arrays (features, implementations, depends_on_components):
  - Empty means "not yet planned/created" or "no dependencies"
  - Populate `features` with FEAT-#### IDs this component implements
  - Populate `implementations` with IMPL-#### IDs as they are created
  - Populate `depends_on_components` with COMP-#### IDs this component depends on
  - Example: features: ["FEAT-0001", "FEAT-0003"], depends_on_components: ["COMP-0002"]

CROSS-TIER CONSISTENCY:
- Bidirectional links must be symmetric
- If this COMP lists a FEAT-#### in features[], that FEAT must list this COMP-#### in its components[]
- If this COMP lists an IMPL-#### in implementations[], that IMPL must list this COMP-#### in its components[]
- If links are asymmetric, fix them or determine which side is correct

TEMPLATE USAGE:
- Replace {{id}} with the actual component ID (e.g., COMP-0001)
- Replace {{title}} with the actual component name
- Replace {{component_type}} with the actual type
- Replace {{status}} with the actual status
- Replace {{repo}} with the actual repository name or path
- Replace {{features}}, {{implementations}}, {{depends_on_components}} with actual arrays
- Replace all {{variable}} placeholders before saving
-->

# Component: {{title}}

**ID:** `{{id}}`
**Type:** `{{component_type}}`
**Status:** `{{status}}`
**Repo:** `{{repo}}`

## 1. Purpose & Responsibility

> _What this component does and why it exists._

- Primary responsibilities.
- What domain or problem area it owns.
- What it explicitly does **not** do (to clarify boundaries).

## 2. Public Interface

> _How other components and clients interact with this component._

### 2.1 APIs / Endpoints

- REST/RPC endpoints, GraphQL operations, or other public operations. High level only; detailed contracts live in Implementation tier.
- For each major endpoint:
  - Name / path / verb.
  - Purpose.

### 2.2 Events / Messages

- Events this component **publishes**.
- Events this component **subscribes to**.

### 2.3 UI (if applicable)

- Key screens/pages this component owns.
- Major user flows it supports.

## 3. Dependencies

> _What this component depends on to do its job._

### 3.1 Internal Component Dependencies

**Dependencies:** `{{depends_on_components}}`

- List other components (`COMP-####`) this component depends on
- For each dependency, describe:
  - Nature of dependency: synchronous call, async messaging, shared library, data dependency, etc.
  - Why the dependency exists
  - Any failure modes if the dependency is unavailable

### 3.2 External Systems

- Third-party APIs or services this component integrates with.
- How critical they are and any notable constraints.

### 3.3 Data Stores

- Databases, caches, or queues this component owns or directly uses.
- Ownership: Does this component own the schema, or is it shared?

## 4. Data & Domain Concepts

> _Key domain concepts owned or heavily used by this component, at a conceptual level._

- Main entities / aggregates this component deals with.
- Any important invariants or consistency rules.

(Concrete schemas and interfaces belong in the Implementation tier, but mention them here conceptually.)

## 5. Operational Concerns

> _How this component runs in production._

- Deployment: where/how it is deployed (e.g., container, function, service).
- Scaling model: horizontal/vertical scaling, expected load.
- Failure modes: what happens if this component is down.

## 6. Security & Access

> _Security posture specific to this component._

- Authentication / authorization requirements.
- Data sensitivity handled by this component.
- Any special audit/logging requirements.

## 7. Traceability

**Cross-tier links (populated as specs are created):**

- **Implements features:** `{{features}}` (list FEAT-#### IDs this component supports)
- **Implementation specs:** `{{implementations}}` (empty until implementation is planned)

> **Workflow:**
> 1. Create this component spec with the `features` array populated (from charter tier).
> 2. Update the corresponding feature specs to reference this component ID.
> 3. When you create implementation specs, come back and add them to the `implementations` array.
> 4. This creates full traceability from feature → component → implementation → code.

## 8. Open Questions & Future Work

> _Notes for future architectural or design decisions._

- Known limitations or technical debt.
- Potential refactors or replacements.

---

> **Agent note:**
> This document defines the role, boundaries, and dependencies of `{{id}}`.
> When adding or changing functionality:
> - Check which features (`FEAT-####`) are impacted.
> - Update this doc if responsibilities, dependencies, or major behavior change.
> - Ensure Implementation docs (`IMPL-####`) stay in sync with this component description.
> If this component is no longer needed, delete this file and update the architecture index.