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

Recipes with a `[script(COMMAND)]`1.32.0 attribute are run as
scripts interpreted by `COMMAND`. This avoids some of the issues with shebang
recipes, such as the use of `cygpath` on Windows, the need to use
`/usr/bin/env`, inconsistencies in shebang line splitting across Unix OSs, and
requiring a temporary directory from which files can be executed.

Recipes with an empty `[script]` attribute are executed with the value of `set script-interpreter := […]`1.33.0, defaulting to `sh -eu`, and _not_
the value of `set shell`.

The body of the recipe is evaluated, written to disk in the temporary
directory, and run by passing its path as an argument to `COMMAND`.