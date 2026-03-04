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

Recipes and aliases whose name starts with a `_` are omitted from `just --list`:

```just

test: _test-helper
  ./bin/test

_test-helper:
  ./bin/super-secret-test-helper-stuff
```

```console

$ just --list
Available recipes:
    test
```

And from `just --summary`:

```console

$ just --summary
test
```

The `[private]` attribute1.10.0 may also be used to hide recipes or
aliases without needing to change the name:

```just

[private]
foo:

[private]
alias b := bar

bar:
```

```console

$ just --list
Available recipes:
    bar
```

This is useful for helper recipes which are only meant to be used as
dependencies of other recipes.