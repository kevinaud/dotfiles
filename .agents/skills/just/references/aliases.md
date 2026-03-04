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

Aliases allow recipes to be invoked on the command line with alternative names:

```just

alias b := build

build:
  echo 'Building!'
```

```console

$ just b
echo 'Building!'
Building!
```

The target of an alias may be a recipe in a submodule:

```justfile

mod foo

alias baz := foo::bar
```