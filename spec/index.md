---
id: SPEC-INDEX
title: Root Specification Index
last_updated: 2025-11-10
description: Lightweight navigational index for all specification tiers to support both human and agent lookup.
---

# Root Specification Index

This file provides a compact, machine-readable index of all specification tiers and key files.

Agents can use this index to locate documents quickly without parsing the full README.

---

## 📂 Directory Structure

| Tier | Folder | Scope | Primary Index | Key Templates | Description |
|------|---------|--------|----------------|----------------|--------------|
| **1. Charter** | `spec/charter/` | System-level | `spec/charter/index.md` | `index-template.md`, `system-charter-template.md`, `features/feature-template.md` | System purpose, vision, and features (`FEAT-####`). |
| **2. Architecture** | `spec/architecture/` | System-level | `spec/architecture/index.md` | `index-template.md`, `stack-overview-template.md`, `components/component-template.md` | Tech stack, components, and system structure (`COMP-####`). |
| **3. Implementation** | `spec/implementation/` | Repo-level | `spec/implementation/index.md` | `index-template.md`, `overview-template.md`, `contracts/impl-item-template.md`, `tests/impl-tests-template.md` | Interfaces, data models, and implementation contracts (`IMPL-####`). |
| **4. Tasks** | `spec/tasks/` | Repo-level | `spec/tasks/index.md` | `index-template.md`, `backlog-template.md`, `items/task-template.md` | Work items and backlog tracking (`TASK-####`). |

---

## 🔗 Cross-Tier Linking Summary

| From | To | Link Type | Description |
|------|----|------------|--------------|
| Charter (`FEAT-####`) | Architecture (`COMP-####`) | capability mapping | Which components deliver each feature. |
| Architecture (`COMP-####`) | Implementation (`IMPL-####`) | component realization | Which code areas implement each component. |
| Implementation (`IMPL-####`) | Tasks (`TASK-####`) | work linkage | Which tasks produce or modify specific implementation items. |

---

## 🧭 Quick Access Paths

| Description | Path |
|--------------|------|
| Root README | `spec/README.md` |
| Root Index (this file) | `spec/index.md` |
| Charter Index | `spec/charter/index.md` |
| Architecture Index | `spec/architecture/index.md` |
| Implementation Index (per repo) | `spec/implementation/index.md` |
| Tasks Index (per repo) | `spec/tasks/index.md` |

---

## 🧠 Agent Usage Notes

1. **Always start here** when you need to locate a specific spec file by tier or ID.
2. To find a document by ID pattern:
   - `FEAT-####` → check `spec/charter/features/`
   - `COMP-####` → check `spec/architecture/components/`
   - `IMPL-####` → check `spec/implementation/contracts/`
   - `TASK-####` → check `spec/tasks/items/`
3. If you need contextual understanding of the entire system, open `spec/README.md`.

---

> _Agent note:_  
> This index is meant for navigation and document discovery. Use it to determine which file paths to load into context before performing work or analysis.