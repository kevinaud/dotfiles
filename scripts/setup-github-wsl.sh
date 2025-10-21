#!/bin/bash
#
# GitHub WSL Authentication Setup Script (Windows Interop Method)
#
# This script configures Git and the GitHub CLI inside a fresh WSL Ubuntu
# installation. It uses the Git Credential Manager (GCM) from the host
# Windows OS, which is the official and most reliable method.
#
# Prerequisites:
# 1. You have already installed Git on your Windows machine.
#    (https://git-scm.com/download/win)
# 2. You have already installed Git and Curl inside this WSL distro.
#    (You can run: sudo apt update && sudo apt install git curl)

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

# --- Main Logic ---

command_exists() {
	command -v "$1" &>/dev/null
}

# --- Step 1: Check WSL Prerequisites ---
check_prerequisites() {
	info "Step 1: Checking for prerequisite tools (git, curl)..."
	if ! command_exists git; then
		error "Git is not installed in WSL. Please run 'sudo apt update && sudo apt install git' first."
	fi
	if ! command_exists curl; then
		error "Curl is not installed in WSL. Please run 'sudo apt update && sudo apt install curl' first."
	fi
	success "Prerequisite tools are installed."
	echo
}

# --- Step 2: Configure WSL Git to use Windows GCM ---
configure_windows_gcm() {
	info "Step 2: Configuring Git to use the Windows Credential Manager..."

	# Standard path for GCM that comes with Git for Windows.
	local gcm_path_unquoted="/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"

	# The working configuration requires escaping the space for the .gitconfig file.
	local gcm_path_escaped="/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe"

	if [ ! -f "$gcm_path_unquoted" ]; then
		error "Windows GCM not found at '$gcm_path_unquoted'."
		error "Please ensure you have installed the latest version of Git for Windows on your host machine."
		exit 1
	fi

	# Set the credential helper using the path with the escaped space.
	# This is the format that `git` correctly parses from the .gitconfig file.
	git config --global credential.helper "$gcm_path_escaped"
	success "Git credential helper has been set to the Windows GCM."

	# This setting is recommended for compatibility with Azure DevOps but is good practice for all users.
	git config --global credential.https://dev.azure.com.useHttpPath true
	success "Applied Azure DevOps compatibility setting."
	echo
}

# --- Step 3: Configure Your Git User Profile ---
configure_git_profile() {
	info "Step 3: Checking your Git user profile..."
	local current_name
	# Add `|| true` to prevent script from exiting if config is not set.
	current_name=$(git config --global user.name || true)
	local current_email
	# Add `|| true` to prevent script from exiting if config is not set.
	current_email=$(git config --global user.email || true)

	if [ -z "$current_name" ]; then
		info "Your Git user name is not set. This information is embedded into every commit you make to identify you as the author."
		info "For example: 'John Doe'"
		read -p "Please enter your full name: " user_name
		git config --global user.name "$user_name"
		success "Git user.name set to: $user_name"
	else
		success "Git user.name already set to: $current_name"
	fi

	if [ -z "$current_email" ]; then
		info "Your Git email is not set. When you push commits, GitHub uses this email to link the commit to your profile."
		info "Please use the same email address you use for your GitHub account."
		read -p "Please enter your GitHub email address: " user_email
		git config --global user.email "$user_email"
		success "Git user.email set to: $user_email"
	else
		success "Git user.email already set to: $current_email"
	fi
	echo
}

# --- Step 4: Install GitHub CLI ---
install_github_cli() {
	info "Step 4: Installing GitHub CLI ('gh')..."
	if command_exists gh; then
		success "GitHub CLI is already installed."
		echo
		return
	fi

	warn "GitHub CLI ('gh') is not installed. Installing now..."
	(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) &&
		sudo mkdir -p -m 755 /etc/apt/keyrings &&
		wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
		sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
		sudo apt update &&
		sudo apt install gh -y

	success "GitHub CLI has been installed."
	echo
}

# --- Step 5: Log in to GitHub CLI ---
login_to_github_cli() {
	info "Step 5: Authenticating with GitHub CLI..."
	# `gh auth status` returns a non-zero exit code if not logged in.
	if gh auth status &>/dev/null; then
		success "You are already logged into the GitHub CLI."
		gh auth status # Show the user who they are logged in as
		echo
		return
	fi

	warn "You are not logged into the GitHub CLI."
	info "A browser window will open on your Windows desktop to complete authentication."

	# Run the login command non-interactively, forcing the HTTPS protocol
	# and web-based authentication flow.
	gh auth login --git-protocol https --web --hostname github.com

	# Verify login was successful
	if gh auth status &>/dev/null; then
		success "Successfully authenticated with the GitHub CLI."
		gh auth status
	else
		error "GitHub CLI authentication failed. Please try running 'gh auth login' manually."
	fi
	echo
}

# --- Run the Script ---
main() {
	echo "------------------------------------------------------------"
	info "Starting GitHub WSL Setup..."
	info "This will configure Git to use your Windows credentials and"
	info "also install and authenticate the GitHub CLI ('gh')."
	echo "------------------------------------------------------------"

	check_prerequisites
	configure_windows_gcm
	configure_git_profile
	install_github_cli
	login_to_github_cli

	echo "------------------------------------------------------------"
	success "All done! Your WSL environment is fully configured."
	info "Git commands will use your Windows credentials automatically."
	info "GitHub CLI ('gh') is installed and ready to use."
	echo "------------------------------------------------------------"
}

main
