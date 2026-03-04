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

Each recipe line is executed by a new shell, so if you change the working
directory on one line, it won’t have an effect on later lines:

```just

foo:
  pwd    # This `pwd` will print the same directory…
  cd bar
  pwd    # …as this `pwd`!
```

There are a couple ways around this. One is to call `cd` on the same line as
the command you want to run:

```just

foo:
  cd bar && pwd
```

The other is to use a shebang recipe. Shebang recipe bodies are extracted and
run as scripts, so a single shell instance will run the whole thing, and thus a
`cd` on one line will affect later lines, just like a shell script:

```just

foo:
  #!/usr/bin/env bash
  set -euxo pipefail
  cd bar
  pwd
```