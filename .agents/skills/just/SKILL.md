---
name: just
description: |
  Expert guidance for writing justfiles - the modern command runner that replaces make. Use when:
  (1) Creating new justfiles for projects
  (2) Writing or modifying recipes (tasks/commands)
  (3) Organizing justfiles with modules, imports, groups
  (4) Cross-platform recipe development
  (5) Questions about just syntax, settings, or best practices
  Triggers: "justfile", "just recipe", "just command", "task runner", "build automation", "replace make"
---

# Just Command Runner

Just is a command runner focused on simplicity and ergonomics. Unlike make, all recipes are "phony" - they always run regardless of file timestamps.

## Quick Reference

| Topic | Guide | Reference Docs |
|-------|-------|----------------|
| Recipe patterns | [topics/recipes.md](topics/recipes.md) | `references/recipe-parameters.md`, `references/dependencies.md` |
| Multi-language scripts | [topics/scripting.md](topics/scripting.md) | `references/shebang-recipes.md`, `references/script-recipes.md` |
| Organization | [topics/organization.md](topics/organization.md) | `references/modules1190.md`, `references/imports.md`, `references/groups.md` |
| Cross-platform | [topics/cross-platform.md](topics/cross-platform.md) | `references/attributes.md`, `references/settings.md` |
| Variables & env | [topics/variables.md](topics/variables.md) | `references/getting-and-setting-environment-variables.md`, `references/strings.md` |

## Core Syntax

```just
# Variable assignment
version := "1.0.0"

# Recipe with doc comment
# Build the project
build:
  cargo build --release

# Recipe with parameter and default
test target="all":
  cargo test {{target}}

# Dependency chain
deploy: build test
  ./deploy.sh
```

## Essential Best Practices

### 1. Always Document Recipes
```just
# Run the test suite with optional filter
test filter="":
  cargo test {{filter}}
```

### 2. Use Quiet Mode Appropriately
```just
# Suppress command echo, show only output
@list:
  ls -la

# Or use set quiet globally
set quiet
```

### 3. Prefer Script Recipes for Complex Logic
```just
[script('bash')]
complex-task:
  set -euo pipefail
  if [[ -f config.json ]]; then
    process_config
  fi
```

### 4. Make Helper Recipes Private
```just
# Public entry point
build: _setup
  cargo build

# Private helper (hidden from --list)
_setup:
  mkdir -p target
```

### 5. Use Groups for Organization
```just
[group('development')]
dev:
  cargo run

[group('testing')]
test:
  cargo test
```

## Common Patterns

**Default recipe that lists available commands:**
```just
default:
  @just --list
```

**Dangerous operation with confirmation:**
```just
[confirm("Delete all data?")]
reset-db:
  rm -rf data/*
```

**Variadic arguments passthrough:**
```just
[no-exit-message]
cargo *args:
  @cargo {{args}}
```

**Cross-platform recipe:**
```just
[unix]
open file:
  xdg-open {{file}}

[windows]
open file:
  start {{file}}
```
