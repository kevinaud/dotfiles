# Variables and Environment

## Variable Types

### Just Variables
```just
# Simple assignment
version := "1.0.0"

# From command output (backticks)
git_hash := `git rev-parse --short HEAD`

# Conditional
mode := if env("CI", "") != "" { "release" } else { "debug" }
```

### Environment Variables
```just
# Export just variable to recipes
export RUST_BACKTRACE := "1"

# Access existing env vars in recipes
show-home:
  echo $HOME

# Propagate env to just variable
user := env("USER")
ci := env("CI", "false")  # with default
```

## String Types

### Single vs Double Quotes
```just
# Single quotes: literal (no escapes)
raw := 'hello\nworld'  # contains backslash-n literally

# Double quotes: escape sequences work
formatted := "hello\nworld"  # contains newline
```

### Shell-Expanded Strings
```just
# x-prefix: expands ~ and $VAR at parse time
config := x'~/.config/$APP_NAME'
```

### Format Strings
```just
# f-prefix: interpolation with {{}}
name := "world"
greeting := f'Hello, {{name}}!'
```

### Indented Strings
```just
# Triple quotes: auto-dedent
script := '''
  line 1
  line 2
'''
# Result: "line 1\nline 2\n"
```

## Backtick Evaluation

```just
# Simple command capture
date := `date +%Y-%m-%d`

# Multi-line (indented)
info := ```
  echo "OS: $(uname -s)"
  echo "Arch: $(uname -m)"
```

# shell() function for complex cases
files := shell('find . -name "*.rs" | wc -l')
```

## Export Patterns

### Global Export
```just
set export  # all variables become env vars

version := "1.0.0"
build:
  echo "Building $version"  # works
```

### Selective Export
```just
export VERSION := "1.0.0"
internal := "not exported"

build:
  echo $VERSION  # works
  # echo $internal  # would fail
```

### Parameter Export
```just
deploy $ENVIRONMENT:
  ./deploy.sh  # $ENVIRONMENT available
```

### Unexport
```just
unexport SECRET  # remove from environment for recipes
```

## dotenv Integration

```just
set dotenv-load

# Optional: customize location
set dotenv-filename := ".env.local"
# or
set dotenv-path := "/etc/myapp/.env"

# Make it required
set dotenv-required
```

## Conditional Expressions

```just
# Equality
mode := if env("CI", "") == "true" { "ci" } else { "local" }

# Regex match
is_semver := if version =~ '[0-9]+\.[0-9]+\.[0-9]+' { "yes" } else { "no" }

# Chained conditions
target := if os() == "linux" {
  "x86_64-unknown-linux-gnu"
} else if os() == "macos" {
  "x86_64-apple-darwin"
} else {
  "x86_64-pc-windows-msvc"
}
```

## Command-Line Overrides

```just
# In justfile
version := "dev"

build:
  echo "Building {{version}}"
```

```bash
# Override from CLI
just version=1.0.0 build
```

## Best Practices

### 1. Use env() with Defaults
```just
# GOOD: graceful fallback
port := env("PORT", "8080")

# RISKY: fails if unset
# port := env("PORT")
```

### 2. Avoid Backticks in Expressions When Possible
```just
# Backticks run at parse time, not recipe time
# Can cause issues if command might fail

# GOOD: use shell() in recipes
build:
  #!/usr/bin/env bash
  version=$(git describe --tags)
  cargo build --version "$version"

# OK for always-available commands
date := `date +%Y-%m-%d`
```

### 3. Quote Interpolations in Commands
```just
message := "hello world"

# BAD: word splitting
bad:
  echo {{message}}

# GOOD: quoted
good:
  echo "{{message}}"
```

### 4. Use Conditional Short-Circuit
```just
# Only runs expensive backtick if needed
expensive := if env("SKIP_EXPENSIVE", "") == "" { `expensive-command` } else { "skipped" }
```

## Reference Docs

| Topic | Reference |
|-------|-----------|
| Environment | `references/getting-and-setting-environment-variables.md` |
| Strings | `references/strings.md` |
| Conditionals | `references/conditional-expressions.md` |
| Backticks | `references/command-evaluation-using-backticks.md` |
| Functions | `references/functions.md` |
| CLI overrides | `references/setting-variables-from-the-command-line.md` |
