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

Normally, if a command returns a non-zero exit status, execution will stop. To
continue execution after a command, even if it fails, prefix the command with
`-`:

```just

foo:
  -cat foo
  echo 'Done!'
```

```console

$ just foo
cat foo
cat: foo: No such file or directory
echo 'Done!'
Done!
```