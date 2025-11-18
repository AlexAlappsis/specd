# Specification System README (Template)

This document explains how the specification system in this project is structured and how to use it.

It defines **four tiers** of documentation—**Charter**, **Architecture**, **Implementation**, and **Tasks**—that together describe *what* the system is, *how* it’s built, *how* it’s implemented, and *what work remains to be done*.

Each tier has Markdown templates (ending in `-template.md`) and instantiated working files (`index.md`, etc.) inside `/spec/`.

---

## 📚 Overview of Tiers

| Tier | Folder | Scope | Purpose |
|------|---------|--------|----------|
| **1. Charter** | `/spec/charter/` | System-level | Defines the system's goals, vision, and features in human terms.  The "why" and "what." |
| **2. Architecture** | `/spec/architecture/` | System-level | Defines the technology stack, system structure, components, and how they interact.  The "how it's organized." |
| **3. Implementation** | `/spec/implementation/` | Repo-level | Defines actual interfaces, contracts, data models, and implementation details for each repository.  The "how it's built." Includes inline testing strategy. |
| **4. Tasks** | `/spec/tasks/` | Repo-level | Execution planning: translates implementation specs into prioritized, ordered work items.  The "when and how to build it." |

---

## 🧭 File & Folder Structure

```text
/spec/
  charter/                    # Tier 1 – high-level system charter & features
    index.md
    system-charter.md
    features/
      FEAT-0001-*.md

  architecture/               # Tier 2 – architecture & component definitions
    index.md
    stack-overview.md
    components/
      COMP-0001-*.md

  implementation/             # Tier 3 – implementation details (per repo)
    index.md
    overview.md
    contracts/
      IMPL-0001-*.md        # Includes inline testing strategy (Section 7)

  tasks/                      # Tier 4 – task lists and individual work items (per repo)
    index.md
    backlog.md
    items/
      TASK-0001-*.md

  # (Optional) keep the -template.md versions in each folder for agent reference
```

---

## 🧩 ID Conventions

Every entity in the spec system has a unique **machine-readable ID**.

| Prefix | Type | Example | Description |
|---------|------|----------|--------------|
| `SYS-CHARTER` | System Charter | `SYS-CHARTER` | The overall system definition. |
| `FEAT-####` | Feature | `FEAT-0007` | A specific capability or behavior defined in the Charter tier. |
| `COMP-####` | Component | `COMP-0003` | A subsystem, service, or app defined in Architecture. |
| `IMPL-####` | Implementation | `IMPL-0005` | A defined implementation area or module within a repo (includes inline test strategy). |
| `TASK-####` | Task | `TASK-0020` | A specific work item tracked in the Tasks tier. |

IDs appear in file names, front matter, and tables across tiers, allowing easy traceability.

---

## 🔗 Cross-Tier Relationships

- **Charter → Architecture:**  Each feature (`FEAT-####`) maps to one or more architecture components (`COMP-####`).
- **Architecture → Implementation:**  Each component is implemented through one or more implementation specs (`IMPL-####`).
- **Implementation → Testing:**  Testing strategy is documented inline within implementation specs at three levels:
  - System-wide testing philosophy in `architecture/stack-overview.md` (Section 7)
  - Implementation testing approach in `implementation/overview.md` (Section 6)
  - Spec-specific test requirements in each `IMPL-####` file (Section 7)
- **Implementation → Tasks:**  Each implementation area requires at least one task (`TASK-####`) before code generation.

This chain allows both humans and LLMs to trace any work item all the way back to its original product intent.

**Mandatory workflow for code generation:**
```
FEAT-0002  →  COMP-0004  →  IMPL-0012  →  TASK-0045  →  Code
```

Tasks separate specification (what to build) from execution planning (when/how to build it).

---

## 🧠 Agent Workflow

### Planning & Specification

1. **Understand the system:**  Read `/spec/charter/system-charter.md`.
2. **Find related architecture:**  Check `/spec/architecture/index.md` and open relevant `COMP-####` files.
3. **Locate implementation details:**  Go to `/spec/implementation/contracts/IMPL-####.md` for data models and interfaces.
4. **Review testing strategy:**  Check Section 7 of the IMPL spec for test requirements and coverage expectations.
5. **Create tasks:**  For each IMPL-####, create at least one TASK-#### in `/spec/tasks/items/`.

### Code Generation

6. **Read task:**  Open the relevant `TASK-####` file to understand what to build and priority.
7. **Read implementation:**  Follow the task's `implementations: []` link to get detailed contracts from `IMPL-####`.
8. **Generate code:**  Use contracts, data models, invariants, and test strategy (Section 7) from IMPL spec to generate code.
9. **Update status:**  Mark task as `in-progress`, then `done` when complete.

### After Code Changes

9. **Update specs:**  Update affected Implementation and Task docs to match reality.
10. **Update cross-tier links:**  If architecture or features changed, update those too.
11. **Maintain consistency:**  Keep IDs and bidirectional links consistent across all tiers.

---

## 🧾 Living Document Philosophy

- **Editable, not archival.**  These files evolve with the system. Outdated features or components can be deleted; history lives in git.  
- **Atomic updates.**  Each change to behavior or design should include spec updates alongside code changes.  
- **Minimal enforcement.**  No formal process required; conventions are lightweight to suit any workflow.

---

## 🧰 Reusable Templates

Each tier includes its own `*-template.md` files for creating new specs. These templates provide:

- YAML front matter with required metadata.
- Standardized headings for readability and agent parsing.
- Embedded usage notes for consistency.

Keep these templates version-controlled in your project for agent reference or automation.

---

## ✅ Example Workflow

1. Define a new feature in Charter (`FEAT-0010`).  
2. Add/adjust architecture components to support it (`COMP-0008`).  
3. Create or update implementation specs in the relevant repo (`IMPL-0020`).  
4. Add tasks to the backlog (`TASK-0055`) referencing the implementation item.  
5. Implement the code.  
6. Update all related specs and mark the task as done.

---

> _Agent note:_  
> Use this README as your navigation map for the project’s specification system.  
> Before performing or automating any work, identify which tier and IDs your task touches, and load those documents into context.