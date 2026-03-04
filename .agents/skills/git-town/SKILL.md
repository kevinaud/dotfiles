---
name: git-town
description: |
  Git Town branch management for stacked changes and dependent PRs. Use when:
  - Creating stacked/dependent branches
  - Managing PR chains where child PRs depend on parent PRs
  - Syncing branch hierarchies after merges
  - Resolving conflicts in branch stacks
  - Working with "ship oldest first" PR workflows

  Triggers: "stacked PRs", "dependent branches", "branch stack", "git town",
  "append branch", "sync stack", "ship PR", "reparent branch"
---

# Git Town

Git Town automates branch management for stacked/dependent changes. It tracks parent-child relationships between branches and handles the complexity of syncing, rebasing, and shipping PRs in order.

## Quick Reference

| Topic | Guide | Reference |
|-------|-------|-----------|
| Creating stacks | [topics/creating-stacks.md](topics/creating-stacks.md) | Core commands |
| Syncing & conflicts | [topics/syncing.md](topics/syncing.md) | Error recovery |
| Shipping PRs | [topics/shipping.md](topics/shipping.md) | Merge workflow |

## Core Commands

| Command | Purpose |
|---------|---------|
| `git town hack <name>` | Create branch off `main` |
| `git town append <name>` | Create branch off current (stacked) |
| `git town sync --all` | Sync all branches with remote |
| `git town sync --stack` | Sync only current stack |
| `git town propose` | Create PR for current branch |
| `git town branch` | Show branch hierarchy |
| `git town switch` | Interactive branch switcher |

## Essential Patterns

### Create a Stack

```bash
git town hack feature/base      # main → base
git town append feature/step-2  # main → base → step-2
git town append feature/step-3  # main → base → step-2 → step-3
```

### Visualize Stack

```bash
git town branch
#   main
#    \
#     feature/base
#      \
#       feature/step-2
#        \
#   *     feature/step-3
```

### Ship Oldest First

Always merge PRs from oldest to newest:
1. Update child PR bases before merging parent
2. Merge parent with `gh pr merge --squash --delete-branch`
3. Run `git town sync --all` to propagate changes
