# Multi-Language Scripting

## Recipe Types

Just supports three recipe types:

1. **Linewise** (default) - each line runs in a separate shell
2. **Shebang** - entire recipe as a script with `#!` interpreter
3. **Script attribute** - modern alternative to shebang

## Linewise Recipes

Each line is a separate shell invocation. Variables don't persist:

```just
# BAD: $x is undefined on second line
broken:
  x=hello
  echo $x

# GOOD: chain with && or use script
working:
  x=hello && echo $x
```

## Shebang Recipes

```just
python-task:
  #!/usr/bin/env python3
  import json
  print(json.dumps({"status": "ok"}))

node-task:
  #!/usr/bin/env node
  console.log('Hello from Node!')
```

### Safer Bash Shebangs

Always add safety flags for bash:

```just
safe-bash:
  #!/usr/bin/env bash
  set -euxo pipefail
  # -e: exit on error
  # -u: error on undefined vars
  # -x: print commands (debugging)
  # -o pipefail: fail on pipe errors
```

### Cross-Platform Shebang Tips

```just
# Use env for portability
good:
  #!/usr/bin/env python3

# Use -S for arguments (some systems need this)
with-args:
  #!/usr/bin/env -S bash -x
```

## Script Attribute (Modern Approach)

Avoids shebang quirks, better cross-platform support:

```just
# Default interpreter (sh -eu)
[script]
simple:
  echo "Hello"
  echo "World"

# Specific interpreter
[script('bash')]
bash-task:
  set -euo pipefail
  array=(one two three)
  for i in "${array[@]}"; do
    echo "$i"
  done

[script('python3')]
python-task:
  import sys
  print(f"Python {sys.version}")

[script('node')]
node-task:
  const data = { key: 'value' };
  console.log(JSON.stringify(data));
```

## When to Use Each

| Type | Use Case |
|------|----------|
| Linewise | Simple commands, one-liners |
| Shebang | Complex scripts, need specific interpreter |
| Script attr | Cross-platform, cleaner syntax, bash arrays |

## Best Practices

### 1. Use Script Attribute for Multi-line Bash
```just
# Cleaner than shebang, no env lookup issues
[script('bash')]
build:
  set -euo pipefail
  for pkg in ./packages/*; do
    (cd "$pkg" && npm build)
  done
```

### 2. Use Extension Attribute for Non-Standard Extensions
```just
# Some interpreters need correct file extension
[script('pwsh'), extension('.ps1')]
windows-script:
  Get-ChildItem | Format-Table
```

### 3. Keep Language-Specific Logic in External Files
```just
# For complex scripts, call external files
analyze:
  python scripts/analyze.py {{args}}
```

## Reference Docs

| Topic | Reference |
|-------|-----------|
| Shebang recipes | `references/shebang-recipes.md` |
| Script recipes | `references/script-recipes.md` |
| Safer bash | `references/safer-bash-shebang-recipes.md` |
| Temp files | `references/script-and-shebang-recipe-temporary-files.md` |
