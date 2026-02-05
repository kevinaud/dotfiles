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

When `just` is invoked without a recipe, it runs the recipe with the
`[default]` attribute, or the first recipe in the `justfile` if no recipe has
the `[default]` attribute.

This recipe might be the most frequently run command in the project, like
running the tests:

```just

test:
  cargo test
```

You can also use dependencies to run multiple recipes by default:

```just

default: lint build test

build:
  echo Building…

test:
  echo Testing…

lint:
  echo Linting…
```

If no recipe makes sense as the default recipe, you can add a recipe to the
beginning of your `justfile` that lists the available recipes:

```just

default:
  just --list
```