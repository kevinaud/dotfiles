#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Go to the script's directory (which will be ~/dotfiles).
cd "$(dirname "${BASH_SOURCE[0]}")"

echo "Running non-interactive dotfiles installation..."

# Use rsync to copy all dotfiles to the home directory.
rsync --exclude ".git/" \
	--exclude ".DS_Store" \
	--exclude "bootstrap.sh" \
	--exclude "install.sh" \
	--exclude "README.md" \
	--exclude "LICENSE-MIT.txt" \
	-avh --no-perms . ~

echo "Dotfiles have been copied to the home directory."