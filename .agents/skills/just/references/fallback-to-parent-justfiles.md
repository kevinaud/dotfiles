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

If a recipe is not found in a `justfile` and the `fallback` setting is set,
`just` will look for `justfile`s in the parent directory and up, until it
reaches the root directory. `just` will stop after it reaches a `justfile` in
which the `fallback` setting is `false` or unset.

As an example, suppose the current directory contains this `justfile`:

```just

set fallback
foo:
  echo foo
```

And the parent directory contains this `justfile`:

```just

bar:
  echo bar
```

```console

$ just bar
Trying ../justfile
echo bar
bar
```