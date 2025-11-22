# specd

A **lightweight living specification system** for keeping architecture documentation in sync with code.

specd provides templates and slash commands to maintain a small, narrative spec that evolves alongside your codebase—designed for human readability and LLM-assisted development.

---

## What is specd?

specd is a **template repository** that provides:

- **Markdown templates** for living architecture documentation
- **JSON invariants** for machine-readable constraints
- **Slash commands** for creating and maintaining specs cooperatively
- **Bidirectional sync** between spec and code
- **LLM-optimized structure** for agent-assisted development

This repository contains the templates and tooling. Once installed, you'll create working specifications in `./spec/` that stay in sync with your code.

---

## Why specd?

Most documentation falls out of sync because:
- It lives separately from code
- There's no process to keep it current
- It's too heavy to maintain

specd solves this by:
- **Staying small**: Just 4 core files (living architecture, invariants, glossary, change log)
- **Being narrative**: No rigid tiers or IDs—write how you think
- **Bidirectional sync**: Commands to go spec → code AND code → spec
- **LLM-native**: Agents can read specs, respect invariants, generate code

The goal: **specs cheap enough to maintain that you actually keep them updated**.

---

## Installation & Setup

### Step 1: Add as Git Submodule

Add specd to your project:

```bash
cd your-project
git submodule add https://github.com/AlexAlappsis/specd .specd
git submodule update --init --recursive
```

### Step 2: Run Installation Script

Copy templates and commands to your project:

```bash
bash .specd/install.sh
```

This copies:
- Templates from `.specd/spec/` → `./spec/`
- Slash commands from `.specd/.claude/commands/` → `./.claude/commands/`

### Step 3: Create Your Living Architecture

Start by describing your system:

```bash
/spec-overview
```

This cooperatively creates `spec/living-architecture.md` - a 1-3 page narrative describing your system's purpose, architecture, and key decisions.

---

## Quick Start

After installation, build your spec iteratively:

### 1. Define Your System Overview
```bash
/spec-overview
```
Create or refine the living architecture narrative

### 2. Capture Hard Constraints
```bash
/spec-invariants
```
Add machine-readable rules (layering, ID formats, error handling, etc.)

### 3. Build Shared Vocabulary
```bash
/spec-glossary
```
Define domain terms for consistent naming

### 4. Generate Code from Spec
```bash
/spec-code-new feature="Task tagging system" path=src/tasks
```
Create new features grounded in your architecture

### 5. Make Incremental Changes
```bash
/spec-code-change feature="Add priority field to tasks" path=src/domain
```
Modify existing code while respecting invariants

### 6. Sync Spec from Code
```bash
/spec-sync-spec path=src/tasks
```
Update spec to reflect what code actually does

---

## What You Get

### Core Spec Files (in `spec/`)

**4 essential files**:
- **`living-architecture.md`** - Narrative system overview (1-3 pages)
  - Purpose & scope
  - Architecture overview
  - Key flows
  - Technology choices
  - Constraints & risks

- **`invariants.json`** - Machine-readable hard rules
  - Layering constraints
  - ID/date formats
  - Error handling patterns
  - Cross-cutting requirements

- **`glossary.md`** - Shared domain vocabulary
  - Domain terms and definitions
  - Naming conventions
  - Relationships between concepts

- **`change-log.md`** - Spec evolution history
  - Architectural changes over time
  - Context for why changes were made

**Supporting**:
- **`agent-contract.md`** - 7 simple rules for LLM agents
- **`readme.md`** - How the spec system works
- Templates (`.md` and `.json`) for creating new projects

### Slash Commands (in `.claude/commands/`)

**6 commands** for spec and code workflows:

**Specification Management:**
- `/spec-overview` - Create or refine living architecture cooperatively
- `/spec-invariants` - List, add, or edit system invariants
- `/spec-glossary` - Manage domain vocabulary
- `/spec-sync-spec path=...` - Sync spec from code (code → spec)

**Code Generation:**
- `/spec-code-new feature="..." [path=...]` - Create new code from spec (spec → code)
- `/spec-code-change feature="..." [path=...]` - Modify existing code from spec (spec → code)

All commands work cooperatively: they analyze, propose a plan, ask clarifying questions, and execute only after confirmation.

---

## How It Works

### The Cooperative Workflow

All commands follow a **three-phase approach**:

1. **ANALYZE** (automatic):
   - Load spec files
   - Scan relevant code
   - Understand context
   - Propose a plan

2. **CONFIRM** (interactive):
   - Show the plan
   - Ask clarifying questions (only when needed)
   - Get user approval

3. **EXECUTE** (automatic):
   - Make changes
   - Report results
   - Suggest next steps

### Path Resolution

Code commands (`/spec-code-new`, `/spec-code-change`, `/spec-sync-spec`) automatically determine where to work:

1. **Explicit `path=` parameter** (if provided)
2. **IDE selection** (file or folder you have selected)
3. **Ask user** (fallback)

Example:
```bash
# Select src/domain/Task.cs in your IDE, then run:
/spec-code-change feature="Add tags to Task"

# Agent responds: "Working in src/domain (from selected file Task.cs)"
# Then proposes changes across domain → data → API layers
```

### Coherence Scope

Commands create **complete, working changes** across layers:

```bash
/spec-code-change feature="Add tags to Task" path=src/domain
```

This might modify:
- `src/domain/Task.cs` (add property)
- `src/data/Migrations/004_AddTags.cs` (migration)
- `src/data/AppDbContext.cs` (configure column)
- `src/api/dtos/TaskDto.cs` (DTO mapping)
- `src/api/TasksController.cs` (expose in API)

The agent touches **all files needed for the feature to work**, but won't add unrelated features or refactor distant code.

---

## Workflow Example

```bash
# 1. Install specd
git submodule add https://github.com/your-org/specd .specd
bash .specd/install.sh

# 2. Create living architecture
/spec-overview
# Cooperatively write 1-3 page system overview

# 3. Add some invariants
/spec-invariants add
# "Controllers must not access database directly"
# "Task IDs are UUIDv7 strings"

# 4. Define key terms
/spec-glossary add Task
# "A unit of work assigned to a user with status tracking"

# 5. Create new feature (spec → code)
/spec-code-new feature="Task tagging system" path=src/tasks
# Agent analyzes, proposes plan, asks questions, generates code

# 6. Make incremental change (spec → code)
/spec-code-change feature="Add priority field" path=src/domain
# Agent modifies existing code across layers

# 7. Sync spec with reality (code → spec)
/spec-sync-spec path=src/tasks
# Agent updates living-architecture.md, glossary.md, change-log.md
```

---

## File Structure

```
your-project/
  .specd/                    # Git submodule (this repo)
    .claude/commands/           # Slash command definitions
    spec/                       # Template files
    install.sh                  # Installation script

  spec/                         # Your working spec (created during install)
    living-architecture.md      # System narrative
    invariants.json             # Hard rules
    glossary.md                 # Domain vocabulary
    change-log.md               # Spec evolution
    agent-contract.md           # Agent behavior rules
    readme.md                   # How the spec system works
    *-template.md               # Templates for new projects

  .claude/commands/             # Slash commands (copied during install)
    spec-overview.md
    spec-invariants.md
    spec-glossary.md
    spec-code-new.md
    spec-code-change.md
    spec-sync-spec.md
```

---

## Design Principles

### 1. Stay Small
The living architecture should be 1-3 pages, not a book. Capture decisions, not documentation.

### 2. Stay Narrative
Write how you think. No rigid IDs, tiers, or templates. Just clear prose.

### 3. Capture Constraints
Use `invariants.json` for rules that must never be violated (layering, formats, patterns).

### 4. Use Shared Vocabulary
Define terms once in `glossary.md`, use them everywhere (spec and code).

### 5. Sync Bidirectionally
- Spec → Code: `/spec-code-new`, `/spec-code-change`
- Code → Spec: `/spec-sync-spec`

### 6. Work Cooperatively
Commands analyze, propose, confirm, then execute. You stay in control.

---

## Command Details

### /spec-overview

Create or refine `living-architecture.md` cooperatively.

**Usage**:
```bash
/spec-overview              # General refinement
/spec-overview Modules      # Focus on modules section
/spec-overview Flows        # Focus on key flows
```

**What it does**:
- Loads existing architecture (or template)
- Shows current state
- Suggests areas to improve
- Cooperatively edits specific sections
- Updates change log

---

### /spec-invariants

View or edit `invariants.json`.

**Usage**:
```bash
/spec-invariants                # List all invariants
/spec-invariants add            # Add new invariant
/spec-invariants edit 2         # Edit invariant #2
/spec-invariants deprecate 3    # Mark invariant #3 as deprecated
```

**What it does**:
- Shows grouped summary of invariants
- Helps add/edit invariants cooperatively
- Maintains stable JSON format

---

### /spec-glossary

Manage domain vocabulary in `glossary.md`.

**Usage**:
```bash
/spec-glossary              # List all terms
/spec-glossary Task         # Show definition of "Task"
/spec-glossary add Task     # Add or update "Task" definition
```

**What it does**:
- Lists terms alphabetically
- Shows full definitions
- Adds new terms cooperatively
- Maintains consistent vocabulary

---

### /spec-code-new

Create new code from spec (greenfield work).

**Usage**:
```bash
/spec-code-new feature="Task notification system" path=src/notifications
/spec-code-new feature="Healthcheck endpoint"
# (uses IDE selection or asks for path)
```

**What it does**:
- Loads spec (architecture, invariants, glossary)
- Infers project patterns
- Proposes plan (files, commands, changes)
- Asks clarifying questions (only when needed)
- Generates coherent vertical slice
- Can create new directories/projects
- Can run CLI commands

**Scope**:
- Creates complete, working features
- Touches multiple layers if needed (domain → data → API)
- Won't add unrelated features

---

### /spec-code-change

Modify existing code based on spec (incremental work).

**Usage**:
```bash
/spec-code-change feature="Add priority to tasks" path=src/domain
/spec-code-change feature="Fix login validation"
# (uses IDE selection or asks for path)
```

**What it does**:
- Loads spec (architecture, invariants, glossary)
- Analyzes existing code patterns
- Proposes plan (which files, what changes)
- Asks clarifying questions (only when needed)
- Makes surgical edits preserving style
- Updates related files for completeness

**Scope**:
- Makes complete, working changes
- Touches multiple layers if needed
- Preserves existing patterns
- Won't refactor unrelated code

---

### /spec-sync-spec

Update spec to match code reality (code → spec sync).

**Usage**:
```bash
/spec-sync-spec path=src/tasks
```

**What it does**:
- Scans code in specified area
- Updates relevant sections of `living-architecture.md`
- Adds/refines terms in `glossary.md`
- Appends entry to `change-log.md`
- Detects invariant violations (reports, doesn't auto-fix)

**Scope**:
- Only updates sections related to the path
- Doesn't rewrite entire spec
- Keeps narrative tone and size

---

## Using This Repository

### Installation
Add as submodule and run install script:
```bash
git submodule add https://github.com/your-org/specd .specd
bash .specd/install.sh
```

### Customization
Templates are copied to `./spec/` during installation and can be customized per-project. For structural changes, fork this repository.

### Updates
Pull latest templates:
```bash
git submodule update --remote .specd
```

Template changes only affect new files created after update.

---

## License

MIT License

---

## Learn More

- **[spec/readme.md](spec/readme.md)** - How the specification system works
- **[spec/agent-contract.md](spec/agent-contract.md)** - Rules for LLM agents
- **[spec/living-architecture-template.md](spec/living-architecture-template.md)** - Template structure
- **[.claude/commands/](. claude/commands/)** - All slash command definitions
