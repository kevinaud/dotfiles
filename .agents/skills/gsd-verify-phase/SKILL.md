---
name: gsd-verify-phase
description: "Migrated Claude /gsd workflow for `verify-phase`. Use when you want to follow the original get-shit-done workflow in Codex."
---

# Migrated GSD Workflow

This skill wraps the original Claude workflow file:

- `/home/vscode/.claude/get-shit-done/workflows/verify-phase.md`

Codex does not have Claude-style custom slash commands, so the closest equivalent is a skill.

When using this skill:

1. Read `references/original-workflow.md`.
2. If that workflow references additional files under `~/.claude/get-shit-done/`, read them on demand.
3. Follow the workflow as closely as Codex's tool model allows.
4. Treat Claude-only mechanics (for example custom slash commands or status line behavior) as guidance, not strict requirements.
