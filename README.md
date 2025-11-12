# SpecDocs

A **specification documentation framework** for organizing system documentation across four hierarchical tiers with strict cross-tier traceability.

SpecDocs provides templates, slash commands, and workflows to maintain living documentation that evolves with your codebase.

---

## 🎯 What is SpecDocs?

SpecDocs is a **template repository** that provides:

- **Markdown templates** for four-tier specifications (Charter, Architecture, Implementation, Tasks)
- **Slash commands** for creating and managing specs with auto-ID assignment and cross-tier linking
- **Validation tools** to ensure bidirectional consistency across all tiers
- **LLM-friendly structure** with YAML front matter and semantic IDs

This repository contains the templates and tooling. Once added to your project, you'll create working specifications in `./spec/`.

For detailed documentation on the specification system itself, see [spec/readme.md](spec/readme.md).

---

## 📦 Installation & Setup

### Option 1: Add as Git Submodule (Recommended)

Add SpecDocs to your project as a git submodule:

```bash
cd your-project
git submodule add https://github.com/your-username/specdocs .specdocs
git submodule update --init --recursive
```

This makes the slash commands available throughout your project and locks the template version.

### Option 2: Global Clone

Clone SpecDocs to your home directory for use across multiple projects:

```bash
git clone https://github.com/your-username/specdocs ~/.specdocs
```

Then reference it from your projects (commands will need to be copied per-project).

---

## 🚀 Quick Start

### 1. Initialize Specification System

Run the init command to copy templates into your project:

```bash
/spec-init
```

This creates the `spec/` directory with all four tiers and initial index files.

### 2. Create Your First Feature

```bash
/spec-feature
```

Define a business capability in the Charter tier (FEAT-####).

### 3. Create Architecture Components

```bash
/spec-component
```

Define components that implement your features (COMP-####).

### 4. Create Implementation Specs

```bash
/spec-impl
```

Define contracts, APIs, and data models (IMPL-####).

### 5. Create Execution Tasks

```bash
/spec-task
```

Break implementations into prioritized, executable tasks (TASK-####).

### 6. Validate Cross-Tier Links

```bash
/spec-sync
```

Ensure all bidirectional links are consistent across tiers.

---

## 📚 What You Get

### Templates (in `spec/`)

13 Markdown templates across four tiers:
- **Charter tier**: System charter, feature templates
- **Architecture tier**: Stack overview, component templates
- **Implementation tier**: Overview, contract templates, test templates
- **Tasks tier**: Backlog, task templates
- **Supporting**: Glossary, manifest, prompts

All templates use YAML front matter with validation rules and usage instructions.

### Slash Commands (in `.claude/commands/`)

6 commands for spec management:
- `/spec-init` - Initialize specification system
- `/spec-feature`, `/spec-component`, `/spec-impl`, `/spec-task` - Create specs with auto-linking
- `/spec-sync` - Validate cross-tier consistency

### Documentation

- [spec/readme.md](spec/readme.md) - Complete specification system guide
- [spec/spec-manifest.md](spec/spec-manifest.md) - Template reference
- [spec/prompts/readme.md](spec/prompts/readme.md) - LLM prompt guide
- [CLAUDE.md](CLAUDE.md) - Guide for LLM agents

---

## 🔧 How Slash Commands Work

Commands read from `./spec/*-template.md` files (copied during `/spec-init`):

- **Auto-ID assignment**: Commands read `next_*_id` from index files and auto-increment
- **Cross-tier linking**: Commands automatically update backlinks (FEAT ↔ COMP ↔ IMPL)
- **Template customization**: After init, you can customize templates in `./spec/` per-project
- **Validation**: `/spec-sync` ensures all bidirectional links stay consistent

All commands are in `.claude/commands/` and available throughout your project.

---

## 🎨 Workflow Example

```bash
# 1. Initialize system
/spec-init

# 2. Create a feature
/spec-feature
# → Creates FEAT-0001-user-authentication.md

# 3. Create a component
/spec-component
# → Creates COMP-0001-auth-service.md
# → Updates FEAT-0001 with bidirectional link

# 4. Create implementation spec
/spec-impl
# → Creates IMPL-0001-auth-api.md
# → Updates FEAT-0001 and COMP-0001 with backlinks

# 5. Create execution task
/spec-task
# → Creates TASK-0001-implement-login-endpoint.md
# → References IMPL-0001 for contracts

# 6. Validate everything
/spec-sync
# → Checks all cross-tier links are consistent

# 7. Generate code (future skill)
specdocs-generator TASK-0001
# → Reads TASK-0001 → IMPL-0001 → generates code
```

---

## 🔮 Planned Features

Claude Skills for code generation (not yet implemented):
- `specdocs-analyst` - Analyze codebase → generate draft specs
- `specdocs-generator` - Read TASK-#### → generate code
- `specdocs-validator` - Deep validation beyond /spec-sync

---

## 📂 Directory Structure

```
your-project/
  .specdocs/                    # Git submodule (this repo)
    .claude/commands/           # Slash commands
    spec/                       # Templates (source of truth)
  spec/                         # Working specifications
    charter/
      index.md
      system-charter.md
      features/
        FEAT-0001-*.md
    architecture/
      index.md
      stack-overview.md
      components/
        COMP-0001-*.md
    implementation/
      index.md
      overview.md
      contracts/
        IMPL-0001-*.md
    tasks/
      index.md
      backlog.md
      items/
        TASK-0001-*.md
```

---

## 🤝 Using This Repository

SpecDocs is a template repository designed to be added to your projects as a git submodule.

**Customization:**
- Fork this repo and customize templates for your organization
- Modify slash commands to fit your workflow
- Add custom validation rules or additional tiers

**Updates:**
- Pull latest templates: `git submodule update --remote .specdocs`
- Template changes only affect new specs (existing specs are independent)

---

## 📄 License

MIT License

---

## 🔗 Learn More

- **[spec/readme.md](spec/readme.md)** - Complete 4-tier specification system guide
- **[CLAUDE.md](CLAUDE.md)** - Complete guide for LLM agents
- **[spec/spec-manifest.md](spec/spec-manifest.md)** - All templates and their purposes
- **[spec/prompts/readme.md](spec/prompts/readme.md)** - LLM prompt templates
