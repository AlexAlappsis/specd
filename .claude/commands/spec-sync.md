Validate cross-tier consistency and fix broken bidirectional links in the specification system.

**What this command does:**
1. Scans all specification files across four tiers
2. Validates bidirectional links (FEAT ↔ COMP ↔ IMPL)
3. Checks for missing or orphaned references
4. Reports inconsistencies
5. Offers to fix broken links automatically

**Usage:**
```
/spec-sync
```

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Scan all specification files:**
   - Read all files in `spec/charter/features/FEAT-*.md`
   - Read all files in `spec/architecture/components/COMP-*.md`
   - Read all files in `spec/implementation/contracts/IMPL-*.md`
   - Read all files in `spec/tasks/items/TASK-*.md`
   - Extract front matter from each file

2. **Build relationship maps:**
   - Create map of FEAT → COMP relationships (from features' components[] arrays)
   - Create map of COMP → FEAT relationships (from components' features[] arrays)
   - Create map of FEAT → IMPL relationships (from features' implementations[] arrays)
   - Create map of IMPL → FEAT relationships (from implementations' features[] arrays)
   - Create map of COMP → IMPL relationships (from components' implementations[] arrays)
   - Create map of IMPL → COMP relationships (from implementations' components[] arrays)
   - Create map of TASK → (FEAT, COMP, IMPL) relationships (one-way only)

3. **Validate bidirectional consistency:**

   **For FEAT ↔ COMP:**
   - For each FEAT-####:
     - Check if all COMP-#### IDs in its components[] array exist
     - For each COMP-#### in components[]:
       - Verify that COMP's features[] array contains this FEAT-####
       - If not: ASYMMETRIC LINK ERROR

   **For FEAT ↔ IMPL:**
   - For each FEAT-####:
     - Check if all IMPL-#### IDs in its implementations[] array exist
     - For each IMPL-#### in implementations[]:
       - Verify that IMPL's features[] array contains this FEAT-####
       - If not: ASYMMETRIC LINK ERROR

   **For COMP ↔ IMPL:**
   - For each COMP-####:
     - Check if all IMPL-#### IDs in its implementations[] array exist
     - For each IMPL-#### in implementations[]:
       - Verify that IMPL's components[] array contains this COMP-####
       - If not: ASYMMETRIC LINK ERROR

   **For COMP → COMP (dependencies):**
   - For each COMP-####:
     - Check if all COMP-#### IDs in depends_on_components[] exist

4. **Validate task references (one-way):**
   - For each TASK-####:
     - Verify all FEAT-#### IDs in features[] exist
     - Verify all COMP-#### IDs in components[] exist
     - Verify all IMPL-#### IDs in implementations[] exist
     - Verify all TASK-#### and IMPL-#### IDs in depends_on[] exist
   - Tasks should NOT be referenced back (one-way relationship)

5. **Check for orphaned specs:**
   - FEAT-#### with no components and no implementations (might be draft/planned)
   - COMP-#### with no features (ERROR - components must implement features)
   - IMPL-#### with no features or no components (ERROR - must link to both)
   - IMPL-#### with no tasks (WARNING - tasks are mandatory before code generation)

6. **Report findings:**

   **Format:**
   ```
   Cross-Tier Validation Report
   ============================

   ✓ Scanned 5 features, 3 components, 7 implementations, 12 tasks

   ERRORS (3):

   1. ASYMMETRIC LINK: FEAT-0002 → COMP-0003
      - FEAT-0002 lists COMP-0003 in components[]
      - But COMP-0003 does NOT list FEAT-0002 in features[]
      - Fix: Add FEAT-0002 to COMP-0003's features[] array

   2. MISSING REFERENCE: IMPL-0005 references non-existent FEAT-0099
      - IMPL-0005 has FEAT-0099 in features[]
      - But FEAT-0099 does not exist
      - Fix: Remove FEAT-0099 from IMPL-0005 or create FEAT-0099

   3. ORPHANED SPEC: COMP-0007 has no feature links
      - COMP-0007's features[] array is empty
      - Components must implement at least one feature
      - Fix: Add FEAT-#### to COMP-0007's features[] and update feature

   WARNINGS (2):

   1. IMPL-0008 has no tasks
      - Tasks are mandatory before code generation
      - Create at least one TASK-#### referencing IMPL-0008

   2. FEAT-0001 has no implementations yet
      - This is OK if feature is in planning phase
      - Create IMPL-#### when ready to define contracts
   ```

7. **Offer automatic fixes:**
   - Ask user: "I found 3 errors. Would you like me to fix them automatically?"
   - If yes:
     - For asymmetric links: Add missing backlinks
     - For missing references: Ask whether to remove invalid ID or skip
     - For orphaned specs: Ask user which FEAT-#### to link, then add links
   - If no: Exit with report only

8. **Apply fixes (if user approves):**
   - Edit affected spec files
   - Add missing IDs to appropriate arrays
   - Update last_updated fields
   - Report each fix applied

9. **Final report:**
   ```
   ✓ Fixed 3 errors
   ✓ Updated 5 specification files
   ✓ All cross-tier links are now consistent

   Files modified:
   - spec/architecture/components/COMP-0003-user-service.md
   - spec/implementation/contracts/IMPL-0005-auth-module.md
   - spec/architecture/components/COMP-0007-background-worker.md
   - spec/charter/features/FEAT-0002-user-management.md

   Run /spec-sync again to verify all issues are resolved.
   ```

**Validation rules reference:**

1. **Bidirectional links MUST be symmetric:**
   - If FEAT lists COMP → COMP must list FEAT
   - If FEAT lists IMPL → IMPL must list FEAT
   - If COMP lists IMPL → IMPL must list COMP

2. **All referenced IDs must exist:**
   - No dangling references to non-existent specs

3. **Components must have features:**
   - Empty features[] in COMP is an error

4. **Implementations must have both features AND components:**
   - Empty features[] in IMPL is an error
   - Empty components[] in IMPL is an error

5. **Tasks should reference implementations:**
   - Empty implementations[] in TASK is a warning
   - Tasks are one-way (not referenced back)

**Important notes:**
- Always backup or use version control before auto-fixing
- Arrays must remain valid YAML/JSON after edits
- Preserve formatting and comments in spec files
- Update last_updated fields when modifying specs
- Re-run /spec-sync after manual edits to verify fixes
