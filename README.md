# SpecDocs

A **specification documentation framework** for organizing system documentation across four hierarchical tiers with strict cross-tier traceability.

SpecDocs helps you maintain living documentation that evolves with your codebase, enabling both humans and LLMs to understand and build your system.

---

## 🎯 Overview

SpecDocs provides a structured approach to specification management with:

- **Four-tier architecture**: Charter → Architecture → Implementation → Tasks
- **Cross-tier traceability**: Bidirectional links between all specification layers
- **LLM-friendly**: Structured YAML front matter and consistent ID conventions
- **Living documents**: Specs evolve with code; history lives in git
- **Mandatory tasks**: Execution planning layer before code generation

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

## 📚 Four-Tier Architecture

| Tier | Path | Scope | Purpose |
|------|------|-------|---------|
| **Charter** | `/spec/charter/` | System-level | Business goals, vision, and features (FEAT-####) |
| **Architecture** | `/spec/architecture/` | System-level | Tech stack, components, and system design (COMP-####) |
| **Implementation** | `/spec/implementation/` | Repo-level | Interfaces, contracts, and data models (IMPL-####) |
| **Tasks** | `/spec/tasks/` | Repo-level | Work items and execution planning (TASK-####) |

### Cross-Tier Traceability

SpecDocs maintains bidirectional links across all tiers:

```
FEAT-0002 ↔ COMP-0004 ↔ IMPL-0012 → TASK-0045 → Code
```

**Features** track which **Components** and **Implementations** realize them.
**Components** track which **Features** they implement and which **Implementations** define them.
**Implementations** track which **Features** and **Components** they belong to.
**Tasks** reference all tiers but are not referenced back (one-way).

---

## 🔧 Slash Commands

All commands are available in `/.claude/commands/`:

| Command | Description |
|---------|-------------|
| `/spec-init` | Initialize spec system in a new project |
| `/spec-feature` | Create new feature (FEAT-####) with auto-ID assignment |
| `/spec-component` | Create new component (COMP-####) with cross-tier linking |
| `/spec-impl` | Create new implementation (IMPL-####) with backlink updates |
| `/spec-task` | Create new task (TASK-####) for execution planning |
| `/spec-sync` | Validate cross-tier consistency and fix broken links |

---

## 📖 ID Conventions

All specifications use unique machine-readable IDs:

- `SYS-CHARTER` - System charter document
- `FEAT-####` - Individual features (e.g., FEAT-0001)
- `COMP-####` - Architecture components (e.g., COMP-0003)
- `IMPL-####` - Implementation specifications (e.g., IMPL-0012)
- `TASK-####` - Work items (e.g., TASK-0045)
- `GLOSSARY` - System glossary (optional)

IDs use four-digit format (NNNN) with leading zeros. IDs do not need to be consecutive.

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

### Skills (Claude Skills - Not Yet Implemented)

- `specdocs-analyst` - Analyze existing codebase and generate draft specs
- `specdocs-generator` - Generate code from TASK-#### (reads referenced IMPL-#### for contracts)
- `specdocs-validator` - Deep validation of spec consistency

---

## 📝 Philosophy

- **Living documents**: Specs evolve with the system; history lives in git
- **Atomic updates**: Code changes paired with spec changes
- **Minimal enforcement**: Lightweight conventions, flexible workflows
- **LLM-friendly**: Designed with agents in mind (structured IDs, YAML front matter)
- **Redundant traceability**: Optimizes for reads over writes

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

## 🤝 Contributing

This is a template repository. Fork it, customize it, make it your own!

---

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

## 🔗 Resources

- [Full Documentation](spec/readme.md)
- [Template Manifest](spec/spec-manifest.md)
- [Prompts Guide](spec/prompts/readme.md)
- [CLAUDE.md](CLAUDE.md) - Complete guide for LLM agents
