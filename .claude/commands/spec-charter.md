Initialize or update the system charter document (SYS-CHARTER).

**What this command does:**
1. Checks if charter tier is initialized (if not, initializes it)
2. Prompts for system name and basic details
3. Creates or updates system charter document
4. Sets up charter index

**Usage:**
```
/spec-charter
```

**Prerequisites:**
- Run `install.sh` script first to copy templates and commands to project root
- The `spec/` directory with templates must exist

---

**Implementation instructions for Claude Code:**

When this command is invoked:

1. **Load charter index (initialize if needed):**
   - Try to open `spec/charter/index.md`
   - If file not found:
     - Try to open `spec/charter/index-template.md`
     - If template not found, inform user to run `install.sh` first and exit
     - Copy `spec/charter/index-template.md` → `spec/charter/index.md`
     - Set initial `next_feature_id: FEAT-0001`
     - Set `last_updated` to today's date (YYYY-MM-DD)
     - Remove any example rows from feature table
     - Inform user: "Charter tier initialized."

2. **Check if system charter already exists:**
   - Try to open `spec/charter/system-charter.md`
   - If exists, ask user if they want to update/overwrite it
   - If user declines, exit gracefully

3. **Prompt for system details:**
   - System name (for charter)
   - Brief system description (1-2 sentences)
   - Vision statement (what is the long-term goal?)
   - Key business goals (optional, can be list)

4. **Create/update system charter:**
   - Copy `spec/charter/system-charter-template.md` → `spec/charter/system-charter.md`
   - Replace {{system_name}} placeholder with user-provided value
   - Replace {{description}} placeholder
   - Set `last_updated` to today's date (YYYY-MM-DD)
   - Fill in vision and business goals from user prompts
   - Set `status: draft`

5. **Report completion:**
   - Display whether tier was initialized or already existed
   - Display created/updated system charter file path
   - Show system name configured
   - Provide next steps:
     - "Review and edit spec/charter/system-charter.md with your system details"
     - "Use /spec-feature to create your first feature specification"

**Example interaction:**
```
User: /spec-charter

Claude: I'll help you initialize the charter tier and create your system charter.

Checking charter tier... not found. Initializing charter tier...
✓ Created spec/charter/index.md
✓ Set next_feature_id to FEAT-0001

System name: MyAwesomeApp
Brief description: A cloud-native platform for managing customer workflows
Vision: Become the leading workflow automation platform for SMBs
Key business goals:
- Reduce customer onboarding time by 50%
- Support 10k concurrent users
- Achieve 99.9% uptime

Creating system charter...
✓ Created spec/charter/system-charter.md

Charter tier initialized successfully!

Next steps:
- Review and edit spec/charter/system-charter.md
- Use /spec-feature to create your first feature
```

**Important notes:**
- Ensure all {{placeholder}} values are replaced in working copies
- Set all dates to current date in YYYY-MM-DD format
