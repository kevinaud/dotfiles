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

Recipes can be listed in alphabetical order with `just --list`:

```console

$ just --list
Available recipes:
    build
    test
    deploy
    lint
```

Recipes in [submodules](https://just.systems/man/en/modules1190.html) can be listed with `just --list PATH`,
where `PATH` is a space- or `::`-separated module path:

```

$ cat justfile
mod foo
$ cat foo.just
mod bar
$ cat bar.just
baz:
$ just --list foo bar
Available recipes:
    baz
$ just --list foo::bar
Available recipes:
    baz
```

`just --summary` is more concise:

```console

$ just --summary
build test deploy lint
```

Pass `--unsorted` to print recipes in the order they appear in the `justfile`:

```just

test:
  echo 'Testing!'

build:
  echo 'Building!'
```

```console

$ just --list --unsorted
Available recipes:
    test
    build
```

```console

$ just --summary --unsorted
test build
```

If you’d like `just` to default to listing the recipes in the `justfile`, you
can use this as your default recipe:

```just

default:
  @just --list
```

Note that you may need to add `--justfile {{justfile()}}` to the line above.
Without it, if you executed `just -f /some/distant/justfile -d .` or
`just -f ./non-standard-justfile`, the plain `just --list` inside the recipe
would not necessarily use the file you provided. It would try to find a
justfile in your current path, maybe even resulting in a `No justfile found`
error.

The heading text can be customized with `--list-heading`:

```console

$ just --list --list-heading $'Cool stuff…\n'
Cool stuff…
    test
    build
```

And the indentation can be customized with `--list-prefix`:

```console

$ just --list --list-prefix ····
Available recipes:
····test
····build
```

The argument to `--list-heading` replaces both the heading and the newline
following it, so it should contain a newline if non-empty. It works this way so
you can suppress the heading line entirely by passing the empty string:

```console

$ just --list --list-heading ''
    test
    build
```