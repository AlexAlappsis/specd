Make small, scoped code changes grounded in the living spec and existing code.

This command is for **spec → code** work: you describe a feature or change, give a scope (`path` or `module`), and the agent updates a small set of files while respecting the living specification and invariants.

**What this command does:**

1. Loads the living spec:
   - `spec/living-architecture.md` (narrative overview)
   - `spec/invariants.json` (hard constraints)
   - Optionally `spec/glossary.md` for terminology
2. Interprets your requested change in the context of:
   - The living architecture
   - The invariants
   - The existing code under the given scope
3. Scans the code in the scoped area to:
   - Understand current behavior
   - Identify a small set of files that should be edited
4. Plans and applies small, incremental edits:
   - Modifies at most **5 files** per invocation
   - Keeps changes local to the given `path` or `module`
5. Summarizes what changed so you can review in git.

**Scope & safety rules:**

- To **modify** code, you must specify either:
  - `path=` (directory or file)  
  - `module=` (a module name mentioned in `living-architecture.md`)
- If **neither** is provided:
  - The command runs in **analysis mode** only (no file writes).
- The command will:
  - Prefer to **reuse existing patterns** and abstractions found in the scoped code
  - Respect invariants from `spec/invariants.json`
  - Avoid cross-layer violations (e.g., controllers calling DB directly) unless the spec/invariants explicitly allow it
- At most **5 files** are modified per run:
  - If more files look relevant, the command:
    - Prioritizes the top ~5 most important files
    - Mentions the remaining files in the summary so you can address them in follow-up runs

**Usage:**

```text
/spec-code-change feature="Add task tagging" path=src/tasks

/spec-code-change feature="Align error responses with error format invariant" module=api

/spec-code-change feature="Implement basic login flow" path=src/auth
```

---

## Implementation instructions for Claude Code

When this command is invoked, follow these steps:

### 1. Load spec context

1. Try to open `spec/living-architecture.md`.
   - If missing, explain that the living spec does not exist yet and suggest running `/spec-overview` first.
2. Try to open `spec/invariants.json`.
   - If missing, continue but note that invariants are not available and you may only rely on the architecture narrative + code.
3. Optionally (non-fatal if missing):
   - Load `spec/glossary.md` for preferred terminology.

You should use:

- `living-architecture.md` to understand modules, flows, and boundaries
- `invariants.json` to understand **hard rules** you must not violate

### 2. Determine scope

- Parse arguments for:
  - `path=` (e.g., `path=src/tasks`)
  - `module=` (e.g., `module=api`)

**If neither `path` nor `module` is provided:**

- Enter **analysis-only** mode:
  - Do **not** write any files.
  - Instead:
    - Summarize how you would approach the requested change.
    - Suggest a concrete command invocation with `path` or `module` so the user can re-run it with scope.

**If `path` is provided:**

- Treat that path as the root for:
  - File discovery
  - Allowed write operations
- You may read other files in the project for context (e.g., shared types), but you may only **modify files under the given `path`**.

**If `module` is provided:**

- Use `spec/living-architecture.md` to map the module name to one or more directories or files.
  - For example, if the architecture doc describes a “Tasks” module and says it lives under `src/tasks`, treat that as the scoped path.
- If you cannot reliably map the module to a path:
  - Explain the ambiguity and suggest a specific `path=` for the user to use next time.
  - Do not write files in this case.

### 3. Analyze existing code

Within the scoped path:

1. Find key files:
   - Entry points (routes/controllers/handlers)
   - Domain models/entities
   - Services/use-cases
   - Relevant tests (if any)
2. Read enough of these files to:
   - Understand current patterns and boundaries
   - Detect existing error formats, naming conventions, etc.
3. Cross-check against:
   - Invariants (e.g., layering rules, ID formats, error shape)
   - Architecture narrative (expected responsibilities of the module)

### 4. Plan a small, scoped change

Before editing any files:

1. Create a short plan that includes:
   - The **intent** of the change (based on `feature="..."` or user description)
   - A list of candidate files to edit, ordered by importance
   - A sentence or two describing what will change in each file
2. Respect the max file limit:
   - If more than 5 files appear relevant:
     - Focus on the top 3–5 files that provide the most value for an initial step.
     - Note the additional files that might be addressed in later runs.

Communicate the design briefly and confirm before generation.  Ask clarifying questions for missing or ambiguous details.

### 5. Apply changes (max 5 files)

1. Modify at most **5 files** under the allowed `path`.
2. For each file:
   - Preserve existing style and patterns.
   - Integrate with current abstractions rather than inventing new architectures unless necessary.
   - Respect invariants; if an invariant conflicts with the requested feature:
     - Choose the invariant.
     - Note the conflict in your final summary.
3. Whenever possible:
   - Prefer adding or adjusting small functions over large rewrites.
   - Avoid renaming or moving many symbols at once unless the user explicitly asked for a refactor.

### 6. Summarize what you did

After applying changes:

1. Produce a concise summary that includes:
   - Which files were modified (paths)
   - A short bullet list of changes per file
   - Any **notable invariants** you adhered to or conflicts you detected
   - Any additional files that might need follow-up work
2. Do **not** stage, commit, or run git commands yourself; assume the user will review diffs and commit.

### 7. Best practices

- If you are unsure about a non-trivial architectural change, keep your edits minimal and mention the uncertainty.
- Do not attempt large, sweeping refactors with this command. Instead, suggest follow-up work the user can trigger with additional scoped invocations.
- Use terminology from `spec/glossary.md` when introducing or updating concepts in code (e.g., “Task” vs “Job”).
