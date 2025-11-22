# Specification System README

This document explains how the specification system in this project is structured and how to use it.
---

## Files

- `living-architecture.md` – narrative overview of the system
- `invariants.json` – machine-readable constraints that must always hold
- `glossary.md` – shared vocabulary for humans + agents
- `change-log.md` – short history of meaningful spec changes
- `agent-contract.md` - short list of agent behaviors

---

## Reusable Templates

Each file besides agent-contract has a `*-template.md` file. These templates provide:

- YAML front matter with required metadata.
- Standardized headings for readability and agent parsing.
- Embedded usage notes for consistency.

Keep these templates version-controlled in your project for agent reference or automation.

---

## Commands

- `/spec-overview` – create or refine `living-architecture.md`
- `/spec-invariants` – list/add/edit invariants in `invariants.json`
- `/spec-glossary` – manage `glossary.md`
- (later) `/spec-code-change`, `/spec-sync-code` – code-aware commands

---

## ✅ Typical Workflow

1. Use `/spec-overview` to fill in or refine the narrative.
3. Capture any hard rules in `/spec-invariants`.
4. Add/adjust glossary terms as they emerge.
5. When you change architecture or invariants, add a short entry to `change-log.md`.
6. When coding, use the code-aware commands (once added) to keep spec and code aligned.

---
