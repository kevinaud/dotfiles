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

Assignments prefixed with the `export` keyword will be exported to recipes as
environment variables:

```just

export RUST_BACKTRACE := "1"

test:
  # will print a stack trace if it crashes
  cargo test
```

Parameters prefixed with a `$` will be exported as environment variables:

```just

test $RUST_BACKTRACE="1":
  # will print a stack trace if it crashes
  cargo test
```

Exported variables and parameters are not exported to backticks in the same scope.

```just

export WORLD := "world"
# This backtick will fail with "WORLD: unbound variable"
BAR := `echo hello $WORLD`
```

```just

# Running `just a foo` will fail with "A: unbound variable"
a $A $B=`echo $A`:
  echo $A $B
```

When [export](https://just.systems/man/en/settings.html#export) is set, all `just` variables are exported as environment
variables.

Environment variables can be unexported with the `unexport keyword`:

```just

unexport FOO

@foo:
  echo $FOO
```

```

$ export FOO=bar
$ just foo
sh: FOO: unbound variable
```

Environment variables from the environment are passed automatically to the
recipes.

```just

print_home_folder:
  echo "HOME is: '${HOME}'"
```

```console

$ just
HOME is '/home/myuser'
```

Environment variables can be propagated to `just` variables using the `env()` function.
See
[environment-variables](https://just.systems/man/en/functions.html#environment-variables).