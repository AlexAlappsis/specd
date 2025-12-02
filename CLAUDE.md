# specd Guide for LLM Agents

Quick reference for working with specd-based projects.

---

## First: Read the Agent Contract

**Before any work**, load and follow `spec/agent-contract.md`.

This contains project-specific rules like:
- Always load `spec/invariants.json` before modifying code
- Use `spec/glossary.md` for consistent terminology
- Prefer existing patterns over new ones
- Never violate invariants unless explicitly approved

---

## Core Spec Files

Projects using specd have these files in `spec/`:

- **`overview.md`** - 1-3 page system narrative
- **`invariants.json`** - Hard rules (layering, formats, constraints)
- **`glossary.md`** - Domain vocabulary
- **`change-log.md`** - Spec evolution history
- **`agent-contract.md`** - Your behavioral rules (READ FIRST)
- **`notes/`** - Optional module-specific decision logs

---

## Available Commands

When users invoke these, you'll see the expanded command prompt with full instructions.

### Specification Management
- `/spec-overview` - Create/refine overview
- `/spec-invariants` - Manage invariants
- `/spec-glossary` - Manage vocabulary
- `/spec-notes module="..." type="..." content="..."` - Add module notes
- `/spec-upkeep` - Review conversation for spec updates
- `/spec-sync-spec path=...` - Sync spec from code

### Code Generation
- `/spec-code-new feature="..." [path=...]` - Create new code
- `/spec-code-change feature="..." [path=...]` - Modify existing code

All commands use a three-phase flow: **Analyze → Confirm → Execute**

---

## Key Principles

### 1. Respect Invariants

Invariants in `spec/invariants.json` are **hard rules**.

If invariant conflicts with existing code:
- ✅ Follow the invariant
- ✅ Note the conflict in your summary
- ❌ Don't silently violate it

### 2. Coherence Scope (Not File Limits)

Create **complete, working changes** across layers:
- ✅ Touch all files needed (domain → data → API → config)
- ✅ Cross-layer changes allowed
- ❌ Don't add unrelated features
- ❌ Don't refactor distant code

**Test**: "If I removed any file, would the feature break?" If yes → include it.

### 3. Use Existing Patterns

Before generating code:
- Scan existing code for patterns
- Match naming, structure, conventions
- Reuse existing abstractions
- Don't invent new architectures

### 4. Smart Question Filtering

Ask questions **only when**:
- Multiple valid architectural choices exist
- Spec and code contradict each other
- Request is genuinely ambiguous

**Don't ask when**:
- Answer is in spec files
- Answer is clear from code
- It's a standard convention
- There's an obvious default

**Max 3 questions.** If you need more, ask user to clarify the request.

### 5. Path Resolution

Code commands resolve `path=` automatically:
1. **Explicit `path=` parameter** (if provided)
2. **IDE selection** (file/folder user has selected)
3. **Ask user** (fallback)

Inform user: `Working in [path] (from selected file X)`

---

## Workflow Checklist

### Before generating/modifying code:
1. ✅ Load `spec/agent-contract.md`
2. ✅ Load `spec/overview.md`
3. ✅ Load `spec/invariants.json`
4. ✅ Load `spec/glossary.md`
5. ✅ If overview links to module notes, load them
6. ✅ Scan existing code for patterns

### When generating code:
- Follow invariants
- Match existing patterns
- Use glossary terms
- Create complete vertical slices
- Report what you did

### When reporting results:
- List files created/modified
- Show CLI commands run
- Note invariants followed
- Report conflicts (don't hide them)
- Suggest notes updates for significant decisions

---

## Common Antipatterns

❌ **Don't generate without loading spec files**
❌ **Don't violate invariants silently**
❌ **Don't over-ask questions** (max 3)
❌ **Don't refactor unrelated code**
❌ **Don't stop at arbitrary file counts** (complete the feature)
❌ **Don't invent new patterns** when existing ones work

---

## Summary

Your job:
1. Read `spec/agent-contract.md` first
2. Load spec files before any code work
3. Respect invariants (hard rules)
4. Match existing patterns
5. Ask only when genuinely needed
6. Create complete, working changes
7. Report what you did clearly

The command files have detailed instructions for each phase. Follow them.
