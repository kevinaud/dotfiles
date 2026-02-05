## Keyboard shortcuts

Press `←` or `→` to navigate between chapters

Press `S` or `/` to search in the book

Press `?` to show this help

Press `Esc` to hide this help

- Auto
- Light
- Rust
- Coal
- Navy
- Ayu

# Just Programmer's Manual

[Print this book](https://just.systems/man/en/print.html "Print this book")[Git repository](https://github.com/casey/just "Git repository")

Recipes and modules may be annotated with one or more group names:

```just

[group('lint')]
js-lint:
    echo 'Running JS linter…'

[group('rust recipes')]
[group('lint')]
rust-lint:
    echo 'Running Rust linter…'

[group('lint')]
cpp-lint:
  echo 'Running C++ linter…'

# not in any group
email-everyone:
    echo 'Sending mass email…'
```

Recipes are listed by group:

```

$ just --list
Available recipes:
    email-everyone # not in any group

    [lint]
    cpp-lint
    js-lint
    rust-lint

    [rust recipes]
    rust-lint
```

`just --list --unsorted` prints recipes in their justfile order within each group:

```

$ just --list --unsorted
Available recipes:
    (no group)
    email-everyone # not in any group

    [lint]
    js-lint
    rust-lint
    cpp-lint

    [rust recipes]
    rust-lint
```

Groups can be listed with `--groups`:

```

$ just --groups
Recipe groups:
  lint
  rust recipes
```

Use `just --groups --unsorted` to print groups in their justfile order.