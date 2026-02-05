# Syncing and Conflict Resolution

## Sync Commands

| Command | Purpose |
|---------|---------|
| `git town sync --all` | Sync all branches with remote |
| `git town sync --stack` | Sync only current stack |
| `git town sync` | Sync current branch only |

## When to Sync

- **Before starting work**: Always `git town sync --all`
- **After pushing fixes**: Propagate changes to child branches
- **After any PR merge**: Update local state and reparent branches
- **Frequently during work**: Avoid phantom conflicts

## Error Recovery Commands

| Command | Purpose |
|---------|---------|
| `git town continue` | Resume after resolving conflicts |
| `git town skip` | Skip current branch, continue sync |
| `git town undo` | Undo last Git Town command |

## Conflict Resolution Workflow

When `git town sync` hits a conflict:

```bash
# 1. Resolve conflicts in editor
# 2. Stage resolved files
git add <resolved-files>

# 3. Continue Git Town operation
git town continue
```

If you can't resolve now:
```bash
git town skip     # Skip this branch, continue others
# OR
git town undo     # Revert to pre-command state
```

## Common Issues

| Issue | Solution |
|-------|----------|
| "Branch has diverged" | Run `git town sync` to reconcile |
| Phantom merge conflicts | Squash-merge artifacts; sync frequently |
| Stale local branches | `git town sync --all` removes shipped branches |
| Child PR shows wrong diff | `gh pr edit <n> --base <parent>` |

## After Merging Parent PR

```bash
# 1. Merge via GitHub
gh pr merge <pr-number> --squash --delete-branch

# 2. Sync to update local state
git town sync --all
# - Deletes local branch (remote is gone)
# - Propagates changes to children
# - Re-parents child branches

# 3. If conflicts, resolve and continue
git add <files>
git town continue
```
