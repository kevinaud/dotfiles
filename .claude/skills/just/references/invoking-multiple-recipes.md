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

Multiple recipes may be invoked on the command line at once:

```just

build:
  make web

serve:
  python3 -m http.server -d out 8000
```

```console

$ just build serve
make web
python3 -m http.server -d out 8000
```

Keep in mind that recipes with parameters will swallow arguments, even if they
match the names of other recipes:

```just

build project:
  make {{project}}

serve:
  python3 -m http.server -d out 8000
```

```console

$ just build serve
make: *** No rule to make target `serve'.  Stop.
```

The `--one` flag can be used to restrict command-line invocations to a single
recipe:

```console

$ just --one build serve
error: Expected 1 command-line recipe invocation but found 2.
```