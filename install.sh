#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Go to the script's directory (which will be ~/dotfiles).
cd "$(dirname "${BASH_SOURCE[0]}")"

echo "Running non-interactive dotfiles installation..."

# Use an array to build the list of rsync arguments. This is safer than a plain string.
rsync_args=(
    --exclude ".git/"
    --exclude ".DS_Store"
    --exclude ".claude/"
    --exclude "bootstrap.sh"
    --exclude "install.sh"
    --exclude "README.md"
    --exclude "LICENSE-MIT.txt"
    -avh --no-perms
)

# --- Conditional Check ---
# If we are in a dev container...
if [[ -n "$REMOTE_CONTAINERS" ]]; then
    echo "Dev container detected and existing .gitconfig found. Preserving it."
    # ...then add an extra exclude rule for .gitconfig to the arguments.
    rsync_args+=(--exclude ".gitconfig")
fi
# -------------------------

echo "Syncing dotfiles to the home directory..."

# Execute rsync, expanding the array of arguments safely.
rsync "${rsync_args[@]}" . ~

# Setup Claude Code configuration
./scripts/setup-claude.sh

echo "Dotfiles installation complete."