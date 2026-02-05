# Creating Stacked Branches

## Branch Creation Commands

| Command | When to Use |
|---------|-------------|
| `git town hack <name>` | First branch in stack, independent work (branches from `main`) |
| `git town append <name>` | Subsequent branches that depend on current branch |

## Workflow

```bash
# Start on main
git checkout main
git town sync --all  # Always sync first

# Create first branch (off main)
git town hack sprint-1/pr1/base-feature

# Build stack on top
git town append sprint-1/pr2/adds-to-base
git town append sprint-1/pr3/final-piece
```

## Verify Stack Structure

```bash
git town branch
#   main
#    \
#     sprint-1/pr1/base-feature
#      \
#       sprint-1/pr2/adds-to-base
#        \
#   *     sprint-1/pr3/final-piece
```

## Branch Naming Convention

Format: `<context>/<identifier>/<description>`

Examples:
- `sprint-1/pr1/session-state`
- `feature/auth/add-oauth`
- `fix/bug-123/null-check`

## Best Practices

1. **Sync before creating**: Run `git town sync --all` before starting
2. **One responsibility per branch**: Keep each branch focused
3. **Name descriptively**: Branch names should explain the change
4. **Check structure often**: Use `git town branch` to verify hierarchy
