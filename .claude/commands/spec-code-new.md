Create a small, new area of code grounded in the living spec, inferred project style, and invariants.

Use this for **greenfield** work: new modules, new controllers, new background workers, etc.
It assumes there may not be any existing code in the target path yet and will spend more time inferring style and structure before generating files.

**What this command does:**

1. Loads the living spec:
   - `spec/living-architecture.md` (narrative overview)
   - `spec/invariants.json` (hard constraints)
   - Optionally `spec/glossary.md` for terminology
2. Interprets your requested feature/area in the context of:
   - The existing architecture (which module/layer this should live in)
   - The invariants (what rules must not be broken)
3. Scans the repo to infer project style:
   - Language & framework usage
   - Typical folder layout
   - Common patterns (controllers/services/repos, etc.)
4. Within the given scope, generates a **small, coherent scaffold**:
   - Creates or populates up to **5 files** (e.g., handler, service, model, test)
   - Uses existing patterns and conventions wherever possible
5. Summarizes what was created so you can review and commit via git.

**Scope & safety rules:**

- You must specify **where** this new code goes, via either:
  - `path=`: a directory where the new code should be created (e.g., `src/notifications`)
  - `module=`: a module name described in `spec/living-architecture.md` (e.g., `Tasks`, `Auth API`)
- The command will:
  - Only **create or modify files under that path/module**.
  - Touch at most **5 files** in a single run.
  - Prefer to create new files rather than rewrite large existing ones.
- If the requested feature would clearly require broad cross-cutting changes:
  - The command should create a minimal vertical slice (e.g., one endpoint + its pipeline) and describe follow-up work rather than trying to “do everything.”

**Usage:**

```text
/spec-code-new feature="New notifications worker that consumes Task events" path=src/notifications

/spec-code-new feature="New public reporting API" module=reports

/spec-code-new feature="Admin-only healthcheck controller" path=src/api/admin
```

---

## Implementation instructions for Claude Code

When this command is invoked, follow these steps:

### 1. Load spec context

1. Try to open `spec/living-architecture.md`.
   - If missing, explain that the living spec does not exist yet and suggest running `/spec-overview` first, then stop.
2. Try to open `spec/invariants.json`.
   - If missing, continue but note that invariants are unavailable.
3. Optionally:
   - Load `spec/glossary.md`.

### 2. Determine scope and intent

- Parse arguments:
  - `feature="..."` (short description)
  - `path=...` and/or `module=...`

If no path/module, error and suggest usage.

**If `module` is provided:**
- Map module to a directory using `living-architecture.md`.
- If ambiguous, ask user to rerun with a clear `path`.

**If `path` is provided:**
- Treat it as root target directory.
- You may create directory if missing.
- You may only write under this path.

### 3. Infer project style

Scan known areas of repo for patterns:
- Language/framework
- Folder conventions
- Controller/service/repo patterns
- Error handling
- Logging
- Test style

### 4. Design a small scaffold

Identify:
- Role (e.g., API endpoint + service + DTO)
- Up to 5 files to create/modify
- File paths and purpose
- Adherence to invariants

Communicate the design briefly and confirm before generation.  Ask clarifying questions for missing or ambiguous details.

### 5. Generate code (max 5 files)

For each file:

If exists:
- Extend minimally.

If not:
- Create minimal functional code.
- Follow inferred style.

### 6. Respect invariants

- Follow layering and constraints.
- If conflict: follow invariant, note conflict.

### 7. Summarize

List:
- Paths created/modified
- Roles
- Assumptions
- Suggested follow-up changes

### 8. Best practices

- Prefer thin coherent slice.
- Avoid over-generating.
- Use glossary terms where applicable.
