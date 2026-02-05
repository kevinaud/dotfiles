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

Execution can be halted with the `error` function. For example:

```just

foo := if "hello" == "goodbye" {
  "xyz"
} else if "a" == "b" {
  "abc"
} else {
  error("123")
}
```

Which produce the following error when run:

```

error: Call to function `error` failed: 123
   |
16 |   error("123")
```