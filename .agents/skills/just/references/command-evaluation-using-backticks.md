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

Backticks can be used to store the result of commands:

```just

localhost := `dumpinterfaces | cut -d: -f2 | sed 's/\/.*//' | sed 's/ //g'`

serve:
  ./serve {{localhost}} 8080
```

Indented backticks, delimited by three backticks, are de-indented in the same
manner as indented strings:

````just

# This backtick evaluates the command `echo foo\necho bar\n`, which produces the value `foo\nbar\n`.
stuff := ```
    echo foo
    echo bar
  ```
````

See the [Strings](https://just.systems/man/en/strings.html) section for details on unindenting.

Backticks may not start with `#!`. This syntax is reserved for a future
upgrade.

The [`shell(…)` function](https://just.systems/man/en/functions.html#external-commands) provides a more general mechanism
to invoke external commands, including the ability to execute the contents of a
variable as a command, and to pass arguments to a command.