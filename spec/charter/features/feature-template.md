---
id: FEAT-0001
title: Example Feature Name
status: proposed
last_updated: 2025-11-10
summary: Brief one-line description of what this feature does.
related_features: []
components: []
implementations: []
notes: "Use this field to capture decision rationale, key assumptions, or design trade-offs"
---

<!--
VALIDATION RULES:
- Required fields: id, title, status, last_updated
- id format: FEAT-NNNN (e.g., FEAT-0001)
- Status values: proposed | approved | active
- Traceability arrays (components, implementations):
  - Empty means "not yet planned/created"
  - Populate these as you create architecture and implementation specs
  - Example: components: ["COMP-0001", "COMP-0003"]

CROSS-TIER CONSISTENCY:
- Bidirectional links must be symmetric
- If this FEAT lists a COMP-#### in components[], that COMP must list this FEAT-#### in its features[]
- If this FEAT lists an IMPL-#### in implementations[], that IMPL must list this FEAT-#### in its features[]
- If links are asymmetric, fix them or determine which side is correct

TEMPLATE USAGE:
- Replace {{id}} with the actual feature ID (e.g., FEAT-0001)
- Replace {{title}} with the actual feature name
- Replace {{status}} with the actual status
- Replace {{components}}, {{implementations}}, {{related_features}} with actual arrays
- Replace all {{variable}} placeholders before saving
-->

# Feature: {{title}}

**ID:** `{{id}}`
**Status:** `{{status}}`

## 1. Summary

- What does this feature do for the user?
- Why is it valuable?

## 2. User Perspective

- **Primary user:** Who uses this feature and why.
- **Typical flow:**
  - Step 1: …
  - Step 2: …

## 3. Behavior & Rules

### 3.1 Core Behavior
- Main feature behaviors, in plain text.

### 3.2 Edge Cases & Exceptions
- Unusual but realistic cases.

## 4. Data & Inputs/Outputs (Conceptual)

- **Inputs:** …
- **Outputs:** …
- **Data notes:** …

## 5. Dependencies & Interactions

- Other features: `FEAT-0003`
- External integrations: …

## 6. Non-Goals / Exclusions

- Out-of-scope details.

## 7. Open Questions

- Question 1
- Question 2

## 8. Traceability

**Cross-tier links (populated as specs are created):**

- **Architecture components:** `{{components}}` (empty until architecture is designed)
- **Implementation items:** `{{implementations}}` (empty until implementation is planned)
- **Related features:** `{{related_features}}`

> **Workflow:**
> 1. Create this feature spec with empty `components` and `implementations` arrays.
> 2. When you create architecture components, come back and add them to the `components` array.
> 3. When you create implementation specs, come back and add them to the `implementations` array.
> 4. This creates full traceability from feature → component → implementation → code.

---

> **Agent note:**
> This document defines intended behavior from the user's perspective.
> Look up related Architecture and Implementation specs for technical details.
> Update this document if user-facing behavior changes.
> If this feature is removed, delete this file and update the charter index.