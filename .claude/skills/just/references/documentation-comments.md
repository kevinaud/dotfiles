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

Comments immediately preceding a recipe will appear in `just --list`:

```just

# build stuff
build:
  ./bin/build

# test stuff
test:
  ./bin/test
```

```console

$ just --list
Available recipes:
    build # build stuff
    test # test stuff
```

The `[doc]` attribute can be used to set or suppress a recipe’s doc comment:

```just

# This comment won't appear
[doc('Build stuff')]
build:
  ./bin/build

# This one won't either
[doc]
test:
  ./bin/test
```

```console

$ just --list
Available recipes:
    build # Build stuff
    test
```