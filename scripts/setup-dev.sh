#!/bin/bash
#
# Developer Tools Setup Script
#
# This script installs and configures the core development tools needed
# for the project within the WSL Ubuntu environment.
#
# It performs the following actions idempotently:
# 1. Installs NVM (Node Version Manager).
# 2. Installs the latest LTS (Long-Term Support) version of Node.js using NVM.
# 3. Sets the LTS version as the default for all new terminals.
# 4. Installs the Dev Containers CLI globally via npm.

# --- Script Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e

# --- Helper Functions for colored output ---
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m' # No Color

info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_NC} $1"
}

success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_NC} $1"
}

warn() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_NC} $1"
}

error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_NC} $1" >&2
    exit 1
}

command_exists() {
    command -v "$1" &> /dev/null
}

# --- Main Logic ---

# --- Step 1: Install NVM (Node Version Manager) ---
install_nvm() {
    info "Step 1: Checking for NVM (Node Version Manager)..."
    # NVM installation path
    export NVM_DIR="$HOME/.nvm"

    if [ -d "$NVM_DIR" ]; then
        success "NVM is already installed."
    else
        warn "NVM is not installed. Installing now..."
        # Download and run the official NVM installer script.
        # We use a specific version for stability.
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        success "NVM has been installed."
        info "You will need to open a new terminal for the 'nvm' command to be available everywhere, but this script will complete the setup now."
    fi
    echo
}

# --- Step 2: Install Node.js LTS and set as default ---
install_and_set_node() {
    info "Step 2: Installing and setting the default Node.js version..."
    # Source NVM script to make the `nvm` command available in this script session.
    # This is necessary because NVM is a shell function, not a binary.
    export NVM_DIR="$HOME/.nvm"
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        # shellcheck source=/dev/null
        . "$NVM_DIR/nvm.sh"
    else
        error "Could not find NVM script to source. NVM installation may have failed."
    fi

    # Check if an LTS version is already installed.
    # `nvm ls lts/*` will fail with a non-zero exit code if not found.
    if nvm ls lts/* > /dev/null 2>&1; then
        success "A Node.js LTS version is already installed."
    else
        warn "Node.js LTS is not installed. Installing now..."
        nvm install --lts
        success "Successfully installed the latest Node.js LTS version."
    fi

    # Set the LTS version as the default for new shells.
    info "Setting the default Node.js version to LTS..."
    nvm alias default lts/*
    nvm use default # Use it in the current session as well.
    
    local node_version
    node_version=$(node -v)
    success "Default Node.js version has been set to LTS ($node_version)."
    echo
}

# --- Step 3: Install Dev Containers CLI ---
install_devcontainers_cli() {
    info "Step 3: Checking for Dev Containers CLI..."
    # Ensure NVM is sourced and npm is available
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    if ! command_exists npm; then
        error "NPM is not available. Cannot install Dev Containers CLI."
    fi

    # Check if the package is already installed globally.
    # `npm list -g` will fail if the package is not found.
    if npm list -g --depth=0 @devcontainers/cli > /dev/null 2>&1; then
        success "Dev Containers CLI is already installed."
    else
        warn "Dev Containers CLI not found. Installing globally with npm..."
        npm install -g @devcontainers/cli
        success "Successfully installed the Dev Containers CLI."
    fi
    echo
}


# --- Run the Script ---
main() {
    echo "------------------------------------------------------------"
    info "Starting Developer Tools Setup..."
    info "This will install NVM, Node.js, and the Dev Containers CLI."
    echo "------------------------------------------------------------"
    
    install_nvm
    install_and_set_node
    install_devcontainers_cli

    echo "------------------------------------------------------------"
    success "All done! Your core development tools are set up."
    warn "Please close and reopen your terminal for all changes to take full effect."
    echo "------------------------------------------------------------"
}

main
