# specd Guide for LLM Agents

This document explains how to work with specd-based projects as an LLM agent.

---

## What is specd?

specd is a **lightweight living specification system** that maintains a small, narrative architecture document alongside code.

**Core files** (always in `spec/`):
- `living-architecture.md` - 1-3 page system narrative
- `invariants.json` - Machine-readable hard rules
- `glossary.md` - Domain vocabulary
- `change-log.md` - Spec evolution history
- `agent-contract.md` - Your behavioral rules (READ THIS FIRST)

---

## Agent Contract (CRITICAL)

Before working on any specd project, **always read** `spec/agent-contract.md`.

It typically contains rules like:
1. Load `spec/invariants.json` before modifying code or specs
2. Load `spec/living-architecture.md` to understand system context
3. Load `spec/glossary.md` for consistent terminology
4. Prefer reading existing code over inventing patterns
5. Respect naming conventions and glossary terms
6. Never violate invariants unless explicitly approved
7. Keep changes small and scoped
8. Suggest spec updates when appropriate

**Follow these rules strictly.** They are the contract between you and the development team.

---

## Available Slash Commands

Users can invoke these commands. When they do, you'll see the expanded prompt from the command file.

### Specification Commands

**`/spec-overview [section]`**
- Create or refine `living-architecture.md`
- Work cooperatively to edit specific sections
- Keep it narrative and concise (1-3 pages total)

**`/spec-invariants [add|edit ID|deprecate ID]`**
- List, add, or edit invariants in `invariants.json`
- Use stable JSON formatting
- Group by category

**`/spec-glossary [term|add term]`**
- List all terms, show specific term, or add/update term
- Keep alphabetical order
- Maintain consistent definitions

**`/spec-sync-spec path=...`**
- Code → spec sync
- Update architecture, glossary, change log from code
- Only update relevant sections (don't rewrite everything)

### Code Commands

**`/spec-code-new feature="..." [path=...]`**
- Spec → code (greenfield)
- Create new features from scratch
- Can create projects, run CLI commands
- Works in 3 phases: Analyze → Confirm → Execute

**`/spec-code-change feature="..." [path=...]`**
- Spec → code (incremental)
- Modify existing code
- Preserve patterns and style
- Works in 3 phases: Analyze → Confirm → Execute

---

## Three-Phase Cooperative Pattern

All code commands follow this pattern:

### Phase 1: ANALYZE (automatic, read-only)
1. Load spec files (`living-architecture.md`, `invariants.json`, `glossary.md`)
2. Determine working path (explicit > IDE selection > ask)
3. Scan code to understand patterns
4. Design the change
5. Prepare detailed plan

### Phase 2: CONFIRM (interactive)
1. Present the plan clearly
2. Ask clarifying questions (ONLY when genuinely needed)
3. Get explicit approval before proceeding

**When to ask questions**:
- ✅ Multiple valid architectural choices exist
- ✅ Spec and code are contradictory
- ✅ Request is genuinely ambiguous

**When NOT to ask**:
- ❌ Answer is in spec files
- ❌ Answer is clear from existing code
- ❌ It's a standard convention
- ❌ There's an obvious default

**Keep questions to 3 or fewer.** If you need more, the request is too vague—ask user to clarify the feature instead.

### Phase 3: EXECUTE (automatic after approval)
1. Run CLI commands (if any)
2. Create/modify files
3. Report results with summary
4. Suggest next steps
5. Do NOT run git commands (user reviews and commits)

---

## Path Resolution

Code commands resolve `path=` in priority order:

### 1. Explicit Parameter (highest priority)
```bash
/spec-code-new feature="..." path=src/tasks
```
Use `src/tasks` directly.

### 2. IDE Selection (automatic fallback)
If no `path=` provided, check `<ide_selection>` tags:
- **File selected**: Use containing directory
- **Folder selected**: Use that folder
- **Ignored selections**: Docs, configs, build artifacts, git files

Inform user: `Working in [path] (from selected file/folder)`

### 3. Ask User (final fallback)
If no valid path/selection:
```
What area of the codebase should I work in?
(provide a directory path like 'src/tasks' or 'src/api')
```

---

## Coherence Scope Principle

**The goal**: Create complete, working changes—not arbitrary file limits.

### What "coherence scope" means:

**DO include**:
- ✅ All files needed to make the feature work end-to-end
- ✅ Cross-layer changes (domain → data → API → config)
- ✅ Database migrations, package installs, DI registration
- ✅ Files outside working path if directly needed

**DO NOT include**:
- ❌ Unrelated features ("I also added filtering while I was at it")
- ❌ Speculative future features
- ❌ Refactoring of distant unrelated code
- ❌ Comprehensive test suites (unless requested)

**The test**: "If I removed any single file from this change, would the feature be broken or incomplete?"
- If **YES** → include it
- If **NO** → skip it

### Examples:

```bash
# Request: "Add tags to Task entity"
# Working path: src/domain

✅ Modify src/domain/Task.cs (add Tags property)
✅ Create src/data/Migrations/004_AddTags.cs (migration)
✅ Modify src/data/AppDbContext.cs (configure column)
✅ Modify src/api/dtos/TaskDto.cs (expose in DTO)
✅ Modify src/api/TasksController.cs (expose in endpoints)

❌ Modify src/domain/User.cs (unrelated entity)
❌ Add filtering to TasksController (unasked feature)
❌ Refactor src/reporting/ (not in dependency chain)
```

---

## Working with Invariants

### Loading Invariants
**ALWAYS** load `spec/invariants.json` before:
- Generating code
- Modifying code
- Making architectural decisions

### Respecting Invariants
Invariants are **hard rules** that must not be violated:

```json
{
  "id": "1",
  "category": "architecture",
  "summary": "Controllers must not access database directly",
  "details": "Controllers call services only. All data access through repositories.",
  "appliesTo": ["module:api", "layer:application"],
  "status": "active"
}
```

**If you encounter a conflict**:
1. **Follow the invariant** (not existing code if they differ)
2. **Note the conflict** in your summary
3. Let the user decide whether to:
   - Fix the code
   - Update the invariant (via `/spec-invariants`)

**Never**:
- Silently violate an invariant
- Assume invariant is wrong
- Modify `invariants.json` without explicit user request

### Invariant Fields
- `id`: Unique identifier
- `category`: architecture, data, api, security, etc.
- `summary`: One-line description
- `details`: Longer explanation
- `appliesTo`: Scope (optional) - modules, layers, entities
- `status`: active, deprecated, proposed

---

## Working with the Living Architecture

### Purpose
`living-architecture.md` is a **1-3 page narrative** describing:
- System purpose & scope
- External systems & users
- Module responsibilities
- Key flows
- Technology choices
- Constraints & risks

### Reading the Architecture
Before generating code, understand:
- **Which module** should this feature live in?
- **What are the boundaries** between modules?
- **What patterns** are described?
- **What flows** does this affect?

### Updating the Architecture
When using `/spec-overview`:
- Keep it **narrative** (not a spec document)
- Keep it **small** (1-3 pages total)
- **Don't duplicate invariants** (reference them instead)
- **Use glossary terms** consistently

---

## Working with the Glossary

### Purpose
`glossary.md` defines domain vocabulary for consistency.

### Using the Glossary
When writing code:
1. Load `spec/glossary.md`
2. Use defined terms for classes, variables, types
3. Don't invent new terms for existing concepts

### Example
```markdown
## Task
**Definition**: A unit of work assigned to a user with status tracking

**Related Terms**:
- Job (avoid - use Task instead)
- Work Item (synonym, but prefer Task)
```

When creating a class:
- ✅ `class Task`
- ❌ `class Job` (glossary says "avoid")
- ❌ `class WorkItem` (glossary says "prefer Task")

### Adding Terms
When using `/spec-glossary add`:
- Provide concise one-line summary
- Add detailed definition if needed
- Note related terms, synonyms, acronyms
- Keep alphabetical order

---

## Code Generation Best Practices

### 1. Infer from Existing Code
Before generating anything:
- **Scan existing code** in similar modules
- **Identify patterns**: layering, DI, error handling, logging
- **Match conventions**: naming, folder structure, formatting
- **Reuse abstractions**: don't invent new patterns

### 2. Generate Minimal Working Code
- ✅ Minimal code to make feature work
- ✅ Follow discovered patterns
- ✅ Respect invariants
- ❌ Comprehensive boilerplate
- ❌ Speculative features
- ❌ Full test suites (unless requested)

### 3. Preserve Existing Style
When modifying code:
- Match indentation, formatting, naming
- Use same error handling approach
- Follow existing DI patterns
- Don't refactor unrelated code

### 4. Handle Missing Infrastructure
If working path doesn't exist:
- ✅ Create it (with user approval)
- ✅ Scaffold new projects via CLI (`dotnet new`, etc.)
- ✅ Document what was created

### 5. Cross-Layer Changes
If feature needs changes across layers:
- ✅ Touch all necessary files
- ✅ Domain → Data → API → Config in one pass
- ❌ Stop arbitrarily at N files if feature needs more

### 6. Use Glossary Terms
- Name classes, types, variables using `glossary.md` terms
- Ask to add to glossary if introducing new domain concept

---

## Reporting Results

After executing changes, provide:

### 1. What was created/modified
```
Created:
- src/notifications/NotificationService.cs
- src/notifications/IEmailSender.cs

Modified:
- src/api/Program.cs (DI registration)
- src/api/TasksController.cs (notification call)
```

### 2. Commands run
```
Ran:
- dotnet new classlib -n MyApp.Notifications
- dotnet add package MailKit
```

### 3. Next steps (optional)
```
Next steps:
- Update appsettings.json with SMTP credentials
- Consider retry logic for failed emails
```

### 4. Invariants followed
```
Adhered to:
- Invariant #1: Controllers don't access DB directly
- Invariant #4: All IDs are UUIDv7 strings
```

### 5. Issues detected (if any)
```
Noted:
- Invariant #2 says use UUIDs, but existing code uses int IDs
  (followed existing pattern - user should decide which to change)
```

---

## Common Patterns

### Pattern 1: User asks for new feature
```
User: Add task tagging

You:
1. Check if they have file/folder selected (IDE context)
2. If not: "What area should I work in?"
3. Load spec files (living-architecture, invariants, glossary)
4. Scan existing code for patterns
5. Present plan: files to create/modify, commands to run
6. Ask clarifying questions (only if genuinely needed)
7. Get approval
8. Execute
9. Report results
```

### Pattern 2: User asks to modify existing code
```
User: Fix the login validation issue

You:
1. Determine working path (explicit > IDE selection > ask)
2. Load spec files
3. Analyze existing code in that area
4. Identify what needs to change
5. Present plan
6. Get approval
7. Make surgical edits
8. Report results
```

### Pattern 3: User wants to update spec
```
User: Update the spec to reflect the new notifications module

You:
1. Use /spec-sync-spec path=src/notifications
2. Scan code in src/notifications
3. Update relevant sections of living-architecture.md
4. Add/refine terms in glossary.md
5. Append entry to change-log.md
6. Report what was updated
```

---

## Antipatterns (What NOT to Do)

### ❌ Don't Generate Without Context
```
User: Add notifications

Bad: Immediately start generating NotificationService.cs
Good: Load spec, understand architecture, ask for path, propose plan
```

### ❌ Don't Violate Invariants Silently
```
Invariant: "Controllers must not access DB directly"
Existing code: Some controllers access DB directly

Bad: Match existing code (violate invariant)
Good: Follow invariant, note conflict in summary
```

### ❌ Don't Over-Ask Questions
```
Bad:
- What type should tags be?
- Should tags be required?
- What's the max tags per task?
- Should we validate tag format?
- Should we add tag search?

Good:
- Infer from existing patterns (array properties are usually optional)
- Ask only: "Should tags be simple string array or separate Tags table?"
```

### ❌ Don't Refactor Unrelated Code
```
User: Add priority field to Task

Bad: Also refactor User.cs, clean up imports in TaskService, update comments
Good: Only add priority field and related changes (DTO, API, migration)
```

### ❌ Don't Assume File Limits
```
Feature: Add tags to tasks

Bad: Stop at 5 files even though migration and API aren't updated
Good: Touch all files needed (domain, migration, context, DTO, controller)
```

### ❌ Don't Invent New Patterns
```
Existing code: Uses repositories for data access

Bad: Create new DAL pattern because "it's better"
Good: Use existing repository pattern
```

---

## Quick Reference

### Before ANY code work:
1. ✅ Read `spec/agent-contract.md`
2. ✅ Load `spec/living-architecture.md`
3. ✅ Load `spec/invariants.json`
4. ✅ Load `spec/glossary.md`
5. ✅ Scan existing code for patterns

### When generating code:
- Follow invariants (hard rules)
- Match existing patterns
- Use glossary terms
- Create complete vertical slices
- Don't refactor unrelated code

### When asking questions:
- Only when genuinely ambiguous
- Max 3 questions
- Don't ask about things in spec or clear from code

### When reporting:
- List all files created/modified
- Show commands run
- Note invariants followed
- Report conflicts (don't hide them)

---

## Summary

specd keeps specs and code in sync through:
- **Small, narrative architecture** (living-architecture.md)
- **Machine-readable constraints** (invariants.json)
- **Shared vocabulary** (glossary.md)
- **Cooperative commands** (analyze → confirm → execute)
- **Bidirectional sync** (spec ↔ code)

Your job: Respect the spec, follow invariants, match patterns, ask only when needed, create complete changes.
