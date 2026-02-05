#!/usr/bin/env bash

# Setup Claude Code configuration files.
# Rsyncs tracked config from dotfiles to ~/.claude.

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DOTFILES_CLAUDE="${SCRIPT_DIR}/../.claude"
TARGET_DIR="$HOME/.claude"

echo "Setting up Claude Code configuration..."

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy settings.json only if it doesn't exist (preserve user's local settings)
if [[ -f "$DOTFILES_CLAUDE/settings.json" ]] && [[ ! -f "$TARGET_DIR/settings.json" ]]; then
    cp "$DOTFILES_CLAUDE/settings.json" "$TARGET_DIR/settings.json"
    echo "  Created settings.json"
fi

# Rsync skills, agents, and commands directories
for dir in skills agents commands; do
    if [[ -d "$DOTFILES_CLAUDE/$dir" ]]; then
        mkdir -p "$TARGET_DIR/$dir"
        rsync -avh --exclude '.gitkeep' "$DOTFILES_CLAUDE/$dir/" "$TARGET_DIR/$dir/"
    fi
done

echo "Claude Code configuration complete."
