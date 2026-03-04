# Cross-Platform Development

## Platform Attributes

Restrict recipes to specific platforms:

```just
[linux]
install:
  apt-get install mypackage

[macos]
install:
  brew install mypackage

[windows]
install:
  choco install mypackage

[unix]  # linux + macos + bsd
open file:
  xdg-open {{file}} 2>/dev/null || open {{file}}
```

Multiple platform attributes work as OR:
```just
[linux, macos]
posix-only:
  echo "POSIX system"
```

## Shell Configuration

### Default Shell Behavior
- Unix: `sh -cu`
- Windows: `sh -cu` (requires sh installed)

### Configure Shell Per-Platform
```just
# Use bash everywhere
set shell := ["bash", "-uc"]

# Windows-specific shell
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
```

### Shell Options Explained
```just
# -c: read commands from string
# -u: error on undefined variables
set shell := ["bash", "-uc"]

# Add -e for exit on error, -o pipefail for pipe safety
set shell := ["bash", "-euco", "pipefail"]
```

## Conditional Logic

### OS Detection
```just
# Built-in functions
current_os := os()           # "linux", "macos", "windows"
current_family := os_family() # "unix" or "windows"
current_arch := arch()        # "x86_64", "aarch64", etc.

setup:
  @echo "Setting up for {{current_os}} ({{current_arch}})"
```

### Conditional Expressions
```just
path_sep := if os_family() == "windows" { "\\" } else { "/" }
exe_ext := if os() == "windows" { ".exe" } else { "" }

binary := "myapp" + exe_ext

build:
  go build -o {{binary}}
```

## Path Handling

### Use `/` Operator for Paths
```just
# Always use forward slash - works everywhere
config := home_directory() / ".config" / "myapp"

# Avoid join() - uses platform-native separators
# bad := join(home_directory(), ".config")  # may use \ on Windows
```

### Invocation Directory
```just
# Where just was called from (not justfile location)
src := invocation_directory()

build:
  cd {{src}} && make
```

## Environment Variables

### dotenv Support
```just
set dotenv-load

# Reads .env file automatically
deploy:
  echo "Deploying to $DEPLOY_TARGET"
```

### Platform-Specific Env
```just
[unix]
home := env("HOME")

[windows]
home := env("USERPROFILE")
```

## Best Practices

### 1. Prefer Platform Attributes Over Conditionals
```just
# GOOD: Clear, maintainable
[linux]
notify message:
  notify-send "{{message}}"

[macos]
notify message:
  osascript -e 'display notification "{{message}}"'

# AVOID: Complex conditional logic in recipe body
```

### 2. Test on All Target Platforms
```just
[group('ci')]
ci: ci-linux ci-macos ci-windows

[linux, group('ci')]
ci-linux: build test

[macos, group('ci')]
ci-macos: build test

[windows, group('ci')]
ci-windows: build test
```

### 3. Handle Missing Tools Gracefully
```just
# Check for required tools
_check-deps:
  #!/usr/bin/env bash
  for cmd in docker node cargo; do
    command -v "$cmd" >/dev/null || { echo "Missing: $cmd"; exit 1; }
  done

build: _check-deps
  cargo build
```

### 4. Document Platform Requirements
```just
# Requires: docker, node 18+, cargo
# Supported: Linux, macOS (Windows experimental)
default:
  @just --list
```

## Reference Docs

| Topic | Reference |
|-------|-----------|
| Attributes | `references/attributes.md` |
| Settings | `references/settings.md` |
| Shell config | `references/configuring-the-shell.md` |
| Functions | `references/functions.md` |
| Windows paths | `references/paths-on-windows.md` |
