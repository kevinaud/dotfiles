#!/usr/bin/env python3
"""Ensure VS Code dotfiles settings are present without overwriting existing values."""

import argparse
import json
import pathlib
import re
import sys

DEFAULTS = {
    "dotfiles.repository": "kevinaud/dotfiles",
    "dotfiles.targetPath": "~/dotfiles",
    "dotfiles.installCommand": "install.sh",
}

COMMENT_PATTERN = re.compile(r"//.*?$|/\*.*?\*/", re.DOTALL | re.MULTILINE)


def strip_comments(text: str) -> str:
    """Remove // and /* */ style comments from JSON-like content."""
    return re.sub(COMMENT_PATTERN, "", text)


def load_settings(path: pathlib.Path) -> dict:
    """Load settings JSON allowing for comment syntax."""
    if not path.exists():
        return {}

    raw = path.read_text(encoding="utf-8")
    if not raw.strip():
        return {}

    try:
        return json.loads(raw)
    except json.JSONDecodeError:
        return json.loads(strip_comments(raw))


def ensure_defaults(path: pathlib.Path, defaults: dict) -> bool:
    """Merge defaults into existing settings; return True if file updated."""
    settings = load_settings(path)
    changed = False

    for key, value in defaults.items():
        if key not in settings:
            settings[key] = value
            changed = True

    if changed:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(settings, indent=4) + "\n", encoding="utf-8")

    return changed


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("settings_path", type=pathlib.Path, help="Path to VS Code settings.json")
    args = parser.parse_args()

    try:
        changed = ensure_defaults(args.settings_path, DEFAULTS)
    except json.JSONDecodeError:
        return 2

    if changed:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
