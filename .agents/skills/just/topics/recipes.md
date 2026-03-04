# Recipe Patterns and Best Practices

## Recipe Structure

```just
# Documentation comment (shows in --list)
[attributes]
recipe-name param1 param2="default" *variadic:
  command line 1
  command line 2
```

## Parameter Patterns

### Required vs Optional
```just
# Required parameter
build target:
  cargo build --target {{target}}

# Optional with default
test filter="":
  cargo test {{filter}}

# Use variables for computed defaults
arch := "x86_64"
compile triple=(arch + "-unknown-linux"):
  rustc --target {{triple}}
```

### Variadic Parameters
```just
# One or more arguments (+)
backup +files:
  cp {{files}} /backup/

# Zero or more arguments (*)
run *args:
  ./app {{args}}

# Variadic with default
test +flags="-q":
  cargo test {{flags}}
```

### Exported Parameters
```just
# $-prefixed params become env vars
deploy $ENVIRONMENT:
  ./deploy.sh  # can use $ENVIRONMENT directly
```

## Dependency Patterns

### Basic Dependencies
```just
# Run deps before recipe
deploy: build test
  ./deploy.sh

# Pass arguments to deps
all: (build "release") (test "integration")
```

### Subsequent Dependencies
```just
# && runs after the recipe body
build: setup && cleanup
  cargo build
```

### Parallel Dependencies
```just
# Run deps in parallel
[parallel]
all: build-frontend build-backend
```

## Best Practices

### 1. Quote Parameters in Commands
```just
# BAD: breaks on spaces
search query:
  grep {{query}} *.txt

# GOOD: handles spaces
search query:
  grep '{{query}}' *.txt
```

### 2. Use Private Helpers
```just
build: _ensure-deps
  cargo build

[private]
_ensure-deps:
  cargo fetch
```

### 3. Validate with Patterns
```just
[arg('env', pattern='dev|staging|prod')]
deploy env:
  ./deploy.sh {{env}}
```

### 4. Wrap Tools Cleanly
```just
[no-exit-message]
npm *args:
  @npm {{args}}
```

### 5. Add Confirmation for Dangerous Ops
```just
[confirm("This will destroy the database. Continue?")]
reset-db:
  dropdb myapp && createdb myapp
```

## Reference Docs

| Topic | Reference |
|-------|-----------|
| Parameters | `references/recipe-parameters.md` |
| Dependencies | `references/dependencies.md` |
| Attributes | `references/attributes.md` |
| Quiet mode | `references/quiet-recipes.md` |
