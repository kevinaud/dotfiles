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

Recipe lines are interpreted by the shell, not `just`, so it’s not possible to
set `just` variables in the middle of a recipe:

```justfile

foo:
  x := "hello" # This doesn't work!
  echo {{x}}
```

It is possible to use shell variables, but there’s another problem. Every
recipe line is run by a new shell instance, so variables set in one line won’t
be set in the next:

```just

foo:
  x=hello && echo $x # This works!
  y=bye
  echo $y            # This doesn't, `y` is undefined here!
```

The best way to work around this is to use a shebang recipe. Shebang recipe
bodies are extracted and run as scripts, so a single shell instance will run
the whole thing:

```just

foo:
  #!/usr/bin/env bash
  set -euxo pipefail
  x=hello
  echo $x
```