---
id: COMP-0000                    # e.g., COMP-0001
title: Example Component Name    # Short, human-readable name
last_updated: 2025-11-10
status: active                   # active | draft | deprecated
owners: [your-name-or-team]
component_type: service          # e.g., web-app | service | worker | library | database | external-system
repo: your-repo-name-or-path     # e.g., repo name or subfolder path; 'external' if outside your control
related_features: []             # e.g., ["FEAT-0001", "FEAT-0003"]
related_capabilities: []         # Optional high-level capability labels
notes: >
  Optional short note about this component or its history.
---

# {{title}} ({{id}})

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

### 3.1 Internal Dependencies

- Other components (`COMP-####`) this component calls or uses.
- Nature of dependency: synchronous call, async messaging, shared library, etc.

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

## 7. Mapping to Features & Implementation

> _Connect this component to Charter and Implementation tiers._

- **Implements features:** `FEAT-0001`, `FEAT-0005`, …
- **Key implementation specs:** `IMPL-####` (to be defined in Implementation tier).
- **Typical change flow:** When implementing a feature that touches this component, update:
  - This component doc (if responsibilities or boundaries change).
  - Relevant Implementation docs (`IMPL-####`).

## 8. Open Questions & Future Work

> _Notes for future architectural or design decisions._

- Known limitations or technical debt.
- Potential refactors or replacements.

---

> _Agent note:_  
> Use this document to understand the role, boundaries, and dependencies of `{{id}}` before changing code.  
> When adding or changing functionality:
> - Check which features (`FEAT-####`) are impacted.
> - Update this doc if responsibilities, dependencies, or major behavior change.
> - Ensure Implementation docs (`IMPL-####`) and Tasks (`TASK-####`) stay in sync with this component description.