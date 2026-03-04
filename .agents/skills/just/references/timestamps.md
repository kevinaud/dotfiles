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

`just` can print timestamps before each recipe commands:

```just

recipe:
  echo one
  sleep 2
  echo two
```

```

$ just --timestamp recipe
[07:28:46] echo one
one
[07:28:46] sleep 2
[07:28:48] echo two
two
```

By default, timestamps are formatted as `HH:MM:SS`. The format can be changed
with `--timestamp-format`:

```

$ just --timestamp recipe --timestamp-format '%H:%M:%S%.3f %Z'
[07:32:11:.349 UTC] echo one
one
[07:32:11:.350 UTC] sleep 2
[07:32:13:.352 UTC] echo two
two
```

The argument to `--timestamp-format` is a `strftime`-style format string, see
the
[`chrono` library docs](https://docs.rs/chrono/latest/chrono/format/strftime/index.html)
for details.