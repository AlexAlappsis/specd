# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SpecDocs is a **specification documentation framework** for organizing system documentation across four hierarchical tiers. This is a **template repository**, not a runtime application. It provides reusable Markdown templates and LLM prompts for structured specification management.

## Four-Tier Architecture

The specification system is organized into four tiers with strict cross-tier traceability:

| Tier | Path | Scope | Purpose |
|------|------|-------|---------|
| **Charter** | `/spec/charter/` | System-level | Business goals, vision, and features (FEAT-####) |
| **Architecture** | `/spec/architecture/` | System-level | Tech stack, components, and system design (COMP-####) |
| **Implementation** | `/spec/implementation/` | Repo-level | Interfaces, contracts, and data models (IMPL-####) |
| **Tasks** | `/spec/tasks/` | Repo-level | Work items and task tracking (TASK-####) |

## ID Conventions

All specification entities use unique machine-readable IDs:

- `SYS-CHARTER` - System charter document
- `FEAT-####` - Individual features (Charter tier)
- `COMP-####` - Architecture components (Architecture tier)
- `IMPL-####` - Implementation specifications (Implementation tier)
- `TASK-####` - Work items (Tasks tier)

Cross-tier linking example: `FEAT-0002 ↔ COMP-0004 ↔ IMPL-0012 ↔ TASK-0045`

## Key Files

- [spec/readme.md](spec/readme.md) - Comprehensive guide to the 4-tier system
- [spec/spec-manifest.md](spec/spec-manifest.md) - Complete manifest of all templates
- [spec/index.md](spec/index.md) - Quick-reference navigational index
- [spec/prompts/readme.md](spec/prompts/readme.md) - Guide to LLM prompt templates

## Template Structure

All templates use YAML front matter followed by structured Markdown sections:

```yaml
---
id: FEAT-0000
title: Example Feature Name
status: proposed
last_updated: 2025-11-10
owners: [your-name-or-team]
related_features: []
---
```

Templates always end in `-template.md` and should be copied (not modified) when instantiating new specs.

## Workflow Guidance

When working with this repository:

1. **Understanding the system**: Start with [spec/readme.md](spec/readme.md)
2. **Finding templates**: Use [spec/spec-manifest.md](spec/spec-manifest.md)
3. **Creating new specs**:
   - Copy relevant template from the appropriate tier
   - Remove `-template` suffix
   - Fill in YAML front matter with unique ID
   - Follow the structured sections in the template
4. **Using prompts**: Reference [spec/prompts/](spec/prompts/) for creation and maintenance workflows
   - Creation prompts guide new spec generation
   - Maintenance prompts guide updates after code/design changes
   - Cross-tier sync prompt ensures consistency

## LLM/Agent Prompts

The `/spec/prompts/` directory contains reusable prompt templates:

- **Creation prompts** (`/prompts/creation/`): Guide agents through creating new spec files
- **Maintenance prompts** (`/prompts/maintenance/`): Guide updates to existing specs
- **Cross-tier sync**: Ensure consistency across all four tiers

These prompts include clarifying questions and confirmation steps to prevent accidental overwrites.

## Philosophy

- **Living documents**: Specs evolve with the system; history lives in git
- **Atomic updates**: Code changes paired with spec changes
- **Minimal enforcement**: Lightweight conventions, flexible workflows
- **LLM-friendly**: Designed with agents in mind (structured IDs, YAML front matter, consistent templates)

## Version Control

This is a git repository. No build process, runtime code, or testing framework exists—this is purely documentation and templates.
