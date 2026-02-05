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

Variables can be overridden from the command line.

```just

os := "linux"

test: build
  ./test --test {{os}}

build:
  ./build {{os}}
```

```console

$ just
./build linux
./test --test linux
```

Any number of arguments of the form `NAME=VALUE` can be passed before recipes:

```console

$ just os=plan9
./build plan9
./test --test plan9
```

Or you can use the `--set` flag:

```console

$ just --set os bsd
./build bsd
./test --test bsd
```