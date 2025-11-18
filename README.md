# specd

A **specification documentation framework** for organizing system documentation across four hierarchical tiers with strict cross-tier traceability.

specd provides templates, slash commands, and workflows to maintain living documentation that evolves with your codebase.

---

## 🎯 What is specd?

specd is a **template repository** that provides:

- **Markdown templates** for four-tier specifications (Charter, Architecture, Implementation, Tasks)
- **Slash commands** for creating and managing specs with auto-ID assignment and cross-tier linking
- **Validation tools** to ensure bidirectional consistency across all tiers
- **LLM-friendly structure** with YAML front matter and semantic IDs

This repository contains the templates and tooling. Once added to your project, you'll create working specifications in `./spec/`.

For detailed documentation on the specification system itself, see [spec/readme.md](spec/readme.md).

---

## 📦 Installation & Setup

### Step 1: Add as Git Submodule

Add specd to your project as a git submodule:

```bash
cd your-project
git submodule add https://github.com/AlexAlappsis/specd .specdocs
git submodule update --init --recursive
```

### Step 2: Run Installation Script

Copy templates and slash commands to your project root:

```bash
bash .specdocs/install.sh
```

This copies:
- Templates from `.specdocs/spec/` → `./spec/`
- Slash commands from `.specdocs/.claude/commands/` → `./.claude/commands/`

### Step 3: Plan Your System

Start by cooperatively planning your system overview:

```bash
/spec-plan
```

This guides you through creating the system charter, architecture overview, and implementation overview. The command will initialize each tier as needed by creating working files from templates.

---

## 🚀 Quick Start

After installation, use `/spec-plan` to create your system overview, then create specific items:

### 1. Plan System Overview
```bash
/spec-plan
```
Cooperatively create system charter, architecture, and implementation overviews

### 2. Create Features
```bash
/spec-feature
```
Define business capabilities (FEAT-####)

### 3. Create Components
```bash
/spec-component
```
Define architecture components (COMP-####)

### 4. Create Implementations
```bash
/spec-impl
```
Define contracts and data models (IMPL-####)

### 5. Create Tasks
```bash
/spec-task
```
Create execution tasks (TASK-####)

### 6. Validate
```bash
/spec-sync
```
Check cross-tier consistency

---

## 📚 What You Get

### Templates (in `spec/`)

12 Markdown templates across four tiers:
- **Charter tier**: System charter, feature templates
- **Architecture tier**: Stack overview, component templates
- **Implementation tier**: Overview, contract templates (with inline testing strategy)
- **Tasks tier**: Backlog, task templates
- **Supporting**: Glossary, manifest, prompts

All templates use YAML front matter with validation rules and usage instructions.

### Slash Commands (in `.claude/commands/`)

6 commands for spec management:
- `/spec-plan` - Cooperative planning for Charter, Architecture, and Implementation overviews
- `/spec-feature`, `/spec-component`, `/spec-impl`, `/spec-task` - Create specs with auto-linking
- `/spec-sync` - Validate cross-tier consistency

### Documentation

- [spec/readme.md](spec/readme.md) - Complete specification system guide
- [spec/spec-manifest.md](spec/spec-manifest.md) - Template reference
- [spec/prompts/readme.md](spec/prompts/readme.md) - LLM prompt guide
- [CLAUDE.md](CLAUDE.md) - Guide for LLM agents

---

## 🔧 How Slash Commands Work

Commands read from `./spec/*-template.md` files (copied during installation):

- **Auto-ID assignment**: Commands read `next_*_id` from index files and auto-increment
- **Cross-tier linking**: Commands automatically update backlinks (FEAT ↔ COMP ↔ IMPL)
- **Tier initialization**: `/spec-plan` creates working files from templates when first run
- **Template customization**: You can customize templates in `./spec/` per-project
- **Validation**: `/spec-sync` ensures all bidirectional links stay consistent

All commands are in `.claude/commands/` and available throughout your project.

---

## 🎨 Workflow Example

```bash
# 1. Add specd to your project
git submodule add https://github.com/AlexAlappsis/specd .specdocs
git submodule update --init --recursive
bash .specdocs/install.sh

# 2. Plan system overview
/spec-plan
# → Cooperatively creates system-charter.md, stack-overview.md, overview.md
# → Initializes each tier as needed (creates working files from templates)

# 3. Create a feature
/spec-feature
# → Creates FEAT-0001-user-authentication.md

# 4. Create a component
/spec-component
# → Creates COMP-0001-auth-service.md
# → Updates FEAT-0001 with bidirectional link

# 5. Create implementation spec
/spec-impl
# → Creates IMPL-0001-auth-api.md (includes inline test strategy in Section 7)
# → Updates FEAT-0001 and COMP-0001 with backlinks

# 6. Create execution task
/spec-task
# → Creates TASK-0001-implement-login-endpoint.md
# → References IMPL-0001 for contracts

# 7. Validate everything
/spec-sync
# → Checks all cross-tier links are consistent

# 8. Generate code (future skill)
specdocs-generator TASK-0001
# → Reads TASK-0001 → IMPL-0001 (including test strategy) → generates code
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
      stack-overview.md         # Includes testing philosophy (Section 7)
      components/
        COMP-0001-*.md
    implementation/
      index.md
      overview.md               # Includes testing approach (Section 6)
      contracts/
        IMPL-0001-*.md          # Includes inline test strategy (Section 7)
    tasks/
      index.md
      backlog.md
      items/
        TASK-0001-*.md
```

---

## 🤝 Using This Repository

specd is a template repository designed to be added to your projects as a git submodule.

**Customization:**
- Fork this repo and customize templates for your organization
- Modify slash commands to fit your workflow
- Add custom validation rules or additional tiers

**Updates:**
- Pull latest templates: `git submodule update --remote .specdocs`
- Template changes only affect new specs (existing specs are independent)

---

## 📄 License & Attribution

This spec framework is inspired by the [GitHub spec-kit project](https://github.com/github/spec-kit) but simplified and restructured for flexibility and LLM-assisted workflows.

MIT License

---

## 🔗 Learn More

- **[spec/readme.md](spec/readme.md)** - Complete 4-tier specification system guide
- **[CLAUDE.md](CLAUDE.md)** - Complete guide for LLM agents
- **[spec/spec-manifest.md](spec/spec-manifest.md)** - All templates and their purposes
- **[spec/prompts/readme.md](spec/prompts/readme.md)** - LLM prompt templates
