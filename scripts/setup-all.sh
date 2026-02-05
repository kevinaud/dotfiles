#!/usr/bin/env bash

# Run all setup scripts in sequence for a full environment bootstrap.
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

scripts=(
	"${SCRIPT_DIR}/apt-install.sh"
	"${SCRIPT_DIR}/setup-github-wsl.sh"
	"${SCRIPT_DIR}/setup-dev.sh"
	"${SCRIPT_DIR}/setup-claude.sh"
)

for script in "${scripts[@]}"; do
	echo "Running ${script}..."
	env bash "${script}"
	echo "Finished ${script}."
	echo
done

echo "All setup scripts completed successfully."
