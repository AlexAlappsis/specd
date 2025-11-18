# Specification Templates Manifest

This manifest lists all reusable template files for the specification system, their paths, tiers, and purposes.

It serves as a quick reference for both humans and agents when locating templates or generating new specification documents.

---

## 📦 Charter Templates (System-Level)

**Folder:** `/spec/charter/`

| File | Purpose |
|------|----------|
| `index-template.md` | Template for the Charter index file (entry point for system-level documentation). |
| `system-charter-template.md` | Template for defining the system’s purpose, goals, scope, and high-level capabilities. |
| `features/feature-template.md` | Template for defining individual features (`FEAT-####`) and their behaviors. |

---

## 🏗️ Architecture Templates (System-Level)

**Folder:** `/spec/architecture/`

| File | Purpose |
|------|----------|
| `index-template.md` | Template for the Architecture index (entry point for system architecture). |
| `stack-overview-template.md` | Template describing the tech stack, infrastructure, and cross-cutting concerns. |
| `components/component-template.md` | Template for defining architecture components (`COMP-####`) such as services, apps, or databases. |

---

## ⚙️ Implementation Templates (Repo-Level)

**Folder:** `/spec/implementation/`

| File | Purpose |
|------|----------|
| `index-template.md` | Template for the Implementation index file (per repo). |
| `overview-template.md` | Template for the repo-level overview of implementation structure and scope. |
| `contracts/impl-item-template.md` | Template for individual implementation specs (`IMPL-####`) defining interfaces, data models, and invariants. |
| `tests/impl-tests-template.md` | Optional template for test documentation (`IMPL-####-TESTS`) covering test strategy, scenarios, and coverage requirements. |

---

## 🧾 Tasks Templates (Repo-Level)

**Folder:** `/spec/tasks/`

| File | Purpose |
|------|----------|
| `index-template.md` | Template for the Tasks index file (entry point for repo-level work tracking). |
| `backlog-template.md` | Template for primary backlog or sprint task lists. |
| `items/task-template.md` | Template for individual task documents (`TASK-####`) including status, dependencies, and completion criteria. |

---

## 📄 Root Documentation Templates

**Folder:** `/spec/`

| File | Purpose |
|------|----------|
| `README.md` | Describes the full 4-tier spec system, workflows, and ID conventions. |
| `index.md` | Lightweight navigational index for all specification tiers and key files. |
| `spec-manifest.md` | This file. Summarizes all templates for automation and discovery. |
| `glossary-template.md` | Template for defining shared vocabulary, domain terms, and technical terminology. |

---

## 🧭 Agent Usage Notes

1. **Purpose:** Use this manifest to locate template files when creating new spec documents or initializing new projects.  
2. **Conventions:** Template files always end in `-template.md` and should remain unmodified for reference.  
3. **Instantiation:** When creating a new spec document, copy the relevant template and remove the `-template` suffix.  
4. **Example:**  
   ```bash
   cp spec/charter/features/feature-template.md spec/charter/features/FEAT-0001-some-feature.md
   ```
5. **Integration:** Agents can use this manifest to auto-discover template paths for document generation or consistency checks.

---

> _Agent note:_  
> This manifest is your canonical map of all template files. Use it to locate, clone, or update templates across tiers when initializing new specifications or creating derivative documentation.