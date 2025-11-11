---
id: SYS-CHARTER
title: System Charter
last_updated: 2025-11-10
owners: [your-name-or-team]
status: active  # active | draft
summary: >
  High-level description of the system, its purpose, and the major features it provides.
---

# System Charter

## 1. Purpose

> _Describe, in a few paragraphs, what this system is and why it exists._

- What problem does this system solve?
- For whom (primary user groups or stakeholders)?
- Why does this system need to exist now?

## 2. Vision & Goals

> _Capture the long-term direction and primary goals._

- **Vision statement:**  
  - e.g., “Provide a reliable, automated scheduling assistant for small businesses.”
- **Primary goals:**
  - Goal 1
  - Goal 2
  - Goal 3

## 3. Scope

### 3.1 In Scope

- Core capabilities this system will provide.
- Key workflows it must support.

### 3.2 Out of Scope / Non-Goals

- Explicitly call out things this system will **not** do.
- This helps avoid feature creep and helps agents ignore irrelevant directions.

## 4. Stakeholders & Users

- **Primary users:**  
  - Role: Description, main needs.
- **Secondary users:**  
  - Role: Description, occasional interactions.
- **Stakeholders (non-users):**  
  - e.g., internal teams, external partners.

## 5. High-Level Capabilities

- **Capability A – Scheduling**  
  - Related features: `FEAT-0001`, `FEAT-0002`
- **Capability B – Reporting**  
  - Related features: `FEAT-0003`

## 6. Constraints & Assumptions

- **Technical constraints**  
  - Required platforms, tech choices, performance needs.
- **Product constraints**  
  - Budget, timelines, minimum viable scope.
- **Assumptions**  
  - About users, environment, integrations, or dependencies.

## 7. Success Criteria (High Level)

- Business-level or system-level metrics (not per-feature acceptance tests).
- Examples:
  - “Reduce time spent on manual scheduling by 50%.”
  - “System can handle N concurrent users without degradation.”

## 8. Related Documents

- **Charter index:** `index.md`
- **Feature docs:** `features/FEAT-####-*.md`
- **Architecture:** `../architecture/index.md` (once created)

> _Agent note:_  
> Use this document to understand the system’s overall goals and constraints.  
> Reference the feature docs (`FEAT-####`) for specific behaviors.  
> Update this file when system-wide goals or scope change.