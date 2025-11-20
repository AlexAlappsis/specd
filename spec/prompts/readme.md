# Prompts README

This directory contains reusable **prompt templates** for guiding LLMs or developers when working with the specification system.

These prompts act as **instructional playbooks**, not project Tasks (`TASK-####`). They describe *how* to perform actions like creating or updating specs safely and consistently, with built-in clarification and confirmation steps.

---

## 📂 Folder Structure

```text
/spec/
  /prompts/
    /creation/           # Prompts for creating new specs from templates
    /maintenance/        # Prompts for updating or syncing existing specs
```

---

## 🧭 Purpose & Philosophy

Prompt templates serve as reusable instruction sets that:

- Guide LLMs or developers through complex, multi-step processes.
- Ensure consistent file structure and metadata across all tiers.
- Prevent accidental overwrites by requiring clarifications and confirmations.
- Keep all updates aligned with the four-tier specification framework.

They are **not executable tasks** by themselves — they’re human-readable or agent-readable blueprints that can be used manually or embedded into automated workflows.

---

## ⚙️ Usage Modes

### 1. **Manual Mode**

Used directly in an interactive session (e.g., ChatGPT, MCP console, or IDE integration):

1. Open the relevant prompt file under `/spec/prompts/creation/` or `/spec/prompts/maintenance/`.
2. Copy its contents into your LLM interface.
3. Provide context (e.g., feature name, affected IDs, or repo name).
4. Follow the clarifying questions and confirmation steps.
5. Approve or adjust before generating files.

This approach is ideal for one-off spec edits or experimentation.

---

### 2. **Orchestrated Mode**

Used inside an agent or script that automates spec management.

- The orchestrator reads a prompt template.
- Injects variables (e.g., `{repo}`, `{feature_id}`, `{component_name}`).
- Sends it as the agent’s “system” or “instruction” message.
- Optionally executes file writes or git commits after user or CI approval.

This mode enables reproducible, auditable spec maintenance.

---

## 🧩 Available Prompt Sets

| Folder          | Scope                   | Example Files                                                                                                                                                            | Description                                                                                                         |
| --------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- |
| `/creation/`    | Spec creation           | `charter-creation-prompt.md`, `architecture-creation-prompt.md`, `implementation-creation-prompt.md`, `task-creation-prompt.md`                                          | Guides agents through creating new spec files based on templates, with clarifying questions and confirmation steps. |
| `/maintenance/` | Spec maintenance & sync | `charter-maintenance-prompt.md`, `architecture-maintenance-prompt.md`, `implementation-maintenance-prompt.md`, `task-maintenance-prompt.md`, `cross-tier-sync-prompt.md`, `align-to-templates.md` | Guides updates after code or design changes, ensuring cross-tier consistency. Includes template migration support.                                       |

---

## 🧠 Agent Guidance

- Always begin with **clarifying questions** to verify context and intent.
- Confirm the **tier**, **IDs**, and **target file paths** before editing.
- Present a **summary plan** before making changes.
- Wait for explicit approval before writing any files.
- Use `/spec/spec-manifest.md` and `/spec/index.md` for file discovery.

---

## 🧾 Example Scenarios

**Creating a New Feature:**

- Use `/spec/prompts/creation/charter-creation-prompt.md`.
- Provide system name, feature summary, and expected behavior.
- Confirm ID (e.g., `FEAT-0005`) and file path.
- Generate `/spec/charter/features/FEAT-0005-feature-name.md`.

**Updating After Code Changes:**

- Use `/spec/prompts/maintenance/implementation-maintenance-prompt.md`.
- Identify changed modules or APIs.
- Review and update related `IMPL-####` and `TASK-####` documents.

**Full System Sync:**

- Use `/spec/prompts/maintenance/cross-tier-sync-prompt.md`.
- Traverse `FEAT`, `COMP`, `IMPL`, and `TASK` IDs for consistency.

**Migrating to Updated Templates:**

- Use `/spec/prompts/maintenance/align-to-templates.md`.
- Align existing specs to current template structure after template updates.
- Handles overviews, indexes, and individual spec files.
- Optionally suggests glossary creation from discovered terms.

---

## 🧠 Best Practices

- Keep prompts **short and procedural**, not narrative.
- Update them as workflows evolve — especially after testing them with real agents.
- Add example outputs or filled-in samples as comments if needed.
- Use consistent metadata and confirmation flow across all prompts.

---

> *Agent note:*\
> Use the prompts in this folder as reusable operational guides. Each defines **how** to interact with the specification system safely. Before automating or modifying specs, select the relevant prompt, inject context, confirm scope, and only then proceed with execution.

