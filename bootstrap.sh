#!/usr/bin/env bash

# --- Argument Parsing ---
# Set default behaviors
PULL_CHANGES=true
FORCE_RUN=false

# Loop through all arguments provided to the script
for arg in "$@"; do
  case $arg in
    -l|--local)
      PULL_CHANGES=false
      shift # remove --local from the list of arguments
      ;;
    -f|--force)
      FORCE_RUN=true
      shift # remove --force from the list of arguments
      ;;
  esac
done

# --- Main Logic ---

cd "$(dirname "${BASH_SOURCE}")"

# Conditionally pull changes based on the --local flag
if [ "$PULL_CHANGES" = true ]; then
	echo "-> Pulling latest changes from origin main..."
	git pull origin main
else
	echo "-> Skipping 'git pull' due to --local flag."
fi

echo "" # Add a newline for better formatting

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude "tests/" \
		-avh --no-perms . ~
	source ~/.bash_profile
}

# If --force was passed OR if not running in an interactive terminal, run automatically.
if [ "$FORCE_RUN" = true ] || [ ! -t 0 ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt
