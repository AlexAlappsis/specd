---
id: IMPL-0000-TESTS              # e.g., IMPL-0001-TESTS
title: Tests for IMPL-0000
last_updated: 2025-11-10
status: active                   # active | draft
owners: [your-name-or-team]
impl_id: IMPL-0000
repo: your-repo-name-or-path
features: []                     # e.g., ["FEAT-0001", "FEAT-0005"]
notes: >
  Optional notes about the test strategy or coverage.
---

# Tests for {{impl_id}} ({{title}})

## 1. Test Strategy

> _How this implementation area is tested._

- Types of tests used (unit, integration, contract, end-to-end).  
- Any important conventions or frameworks for this area.

## 2. Critical Scenarios

> _Scenarios that must always be covered by tests._

- Scenario 1 – description, related behavior or rule.  
- Scenario 2 – description, related behavior or rule.

## 3. Edge Cases & Error Conditions

> _Tests required for unusual or failure conditions._

- Edge case 1.  
- Error condition 1.

## 4. Mapping to Features & Requirements

> _Link test coverage back to features and contracts._

- **Features (`FEAT-####`):** which features these tests help validate.  
- **Contracts (`IMPL-####` document):** sections or behaviors this test set is focused on.

## 5. Gaps & TODOs

> _Known gaps in test coverage or planned additions._

- Gap 1.  
- TODO 1.

---

> _Agent note:_  
> When adding or modifying tests for `{{impl_id}}`, update this document to reflect the current test strategy and critical scenarios.  
> Use this as a guide for generating additional tests or verifying coverage when behavior changes.