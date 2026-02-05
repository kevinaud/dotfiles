# Justfile Organization

## File Structure Patterns

### Single Justfile (Small Projects)
```
project/
├── justfile
└── src/
```

### Modules (Medium Projects)
```
project/
├── justfile        # imports modules
├── ci.just         # CI/CD recipes
├── dev.just        # Development recipes
└── src/
```

### Directory Modules (Large Projects)
```
project/
├── justfile
├── backend/
│   └── mod.just
├── frontend/
│   └── mod.just
└── infra/
    └── mod.just
```

## Modules

Modules provide namespacing - recipes in different modules are isolated:

```just
# justfile
mod backend
mod frontend

# backend.just or backend/mod.just
build:
  cargo build

# Invoke as:
# just backend build
# just backend::build
```

### Module File Locations

Just searches in order:
1. `modulename.just`
2. `modulename/mod.just`
3. `modulename/justfile`

### Optional Modules
```just
# No error if file doesn't exist
mod? local-dev
```

### Module Documentation
```just
# Backend services
mod backend
```

## Imports

Imports merge recipes into the current scope (no namespacing):

```just
# justfile
import 'common.just'
import 'ci/recipes.just'

# common.just defines `build` recipe
# Now `just build` works directly
```

### Optional Imports
```just
import? 'local-overrides.just'
```

### Import Override Rules
- Shallower definitions override deeper ones
- Top-level overrides imports
- With `allow-duplicate-recipes`, last definition wins

## Groups

Organize recipes visually in `--list` output:

```just
[group('build')]
build-debug:
  cargo build

[group('build')]
build-release:
  cargo build --release

[group('test')]
test-unit:
  cargo test --lib

[group('test')]
test-integration:
  cargo test --test '*'
```

Output:
```
$ just --list
[build]
build-debug
build-release

[test]
test-integration
test-unit
```

### Multiple Groups
```just
[group('rust'), group('build')]
cargo-build:
  cargo build
```

## Private and Hidden

### Private Recipes (Helper Functions)
```just
# Underscore prefix - hidden from list
_setup:
  mkdir -p build

# Or use attribute
[private]
setup:
  mkdir -p build

deploy: _setup
  ./deploy.sh
```

### Private Aliases
```just
[private]
alias b := build
```

## Best Practices

### 1. Use a Sensible Default
```just
# Option A: List recipes
default:
  @just --list

# Option B: Most common task
default: build test

# Option C: Dev workflow
default: dev
```

### 2. Group Related Recipes
```just
[group('docker')]
docker-build:
docker-push:
docker-run:

[group('k8s')]
k8s-deploy:
k8s-status:
```

### 3. Use Modules for Team Boundaries
```
justfile           # shared recipes
├── mod backend    # backend team
├── mod frontend   # frontend team
└── mod infra      # platform team
```

### 4. Document Modules
```just
# Database management recipes
mod db

# Kubernetes deployment
mod k8s
```

## Reference Docs

| Topic | Reference |
|-------|-----------|
| Modules | `references/modules1190.md` |
| Imports | `references/imports.md` |
| Groups | `references/groups.md` |
| Private | `references/private-recipes.md` |
| Default | `references/the-default-recipe.md` |
