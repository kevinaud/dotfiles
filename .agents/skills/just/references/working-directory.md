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

By default, recipes run with the working directory set to the directory that
contains the `justfile`.

The `[no-cd]` attribute can be used to make recipes run with the working
directory set to directory in which `just` was invoked.

```just

@foo:
  pwd

[no-cd]
@bar:
  pwd
```

```console

$ cd subdir
$ just foo
/
$ just bar
/subdir
```

You can override the working directory for all recipes with
`set working-directory := '…'`:

```just

set working-directory := 'bar'

@foo:
  pwd
```

```console

$ pwd
/home/bob
$ just foo
/home/bob/bar
```

You can override the working directory for a specific recipe with the
`working-directory` attribute1.38.0:

```just

[working-directory: 'bar']
@foo:
  pwd
```

```console

$ pwd
/home/bob
$ just foo
/home/bob/bar
```

The argument to the `working-directory` setting or `working-directory`
attribute may be absolute or relative. If it is relative it is interpreted
relative to the default working directory.