# Shipping PRs (Merge Workflow)

## Golden Rule: Ship Oldest First

Always merge PRs from the bottom of the stack upward. Merging out of order breaks child PRs.

## Creating PRs

```bash
# Create PR for current branch
git town propose --title "<title>" --body "<body>"
```

Git Town's `propose` ensures proper branch tracking. Prefer it over raw `gh pr create`.

## Pre-Merge Checklist

Before merging any PR in a stack:

1. **Identify child PRs**:
   ```bash
   gh pr list --base <branch-being-merged> --json number,headRefName
   ```

2. **Update child PR bases** (CRITICAL):
   ```bash
   # Each child must target the parent's base, not the parent branch
   gh pr edit <child-pr-number> --base main
   ```

   Why? GitHub auto-closes PRs when their base branch is deleted.

## Merge Workflow

```bash
# 1. Merge and delete remote branch
gh pr merge <pr-number> --squash --delete-branch

# 2. Sync to update local state
git town sync --all

# 3. Resolve any conflicts
git add <files>
git town continue
```

## Example: 3-PR Stack

Stack: `main → pr1 → pr2 → pr3`

```bash
# Merge PR1
gh pr edit <pr2-number> --base main  # Update PR2's base first
gh pr merge <pr1-number> --squash --delete-branch
git town sync --all

# Merge PR2
gh pr edit <pr3-number> --base main  # Update PR3's base first
gh pr merge <pr2-number> --squash --delete-branch
git town sync --all

# Merge PR3
gh pr merge <pr3-number> --squash --delete-branch
git town sync --all
```

## What `sync --all` Does After Merge

- Updates local state (remote branch is gone)
- Deletes local branch (tracking branch deleted)
- Propagates merged changes to child branches
- Re-parents children to new base
- Updates stack hierarchy

## Rules

- **Use `git town propose`** for PR creation, not `gh pr create`
- **Update child bases BEFORE merging parent**
- **Always `git town sync --all` after merge**
- **Never use `git checkout -b`** for branch creation in stacks
