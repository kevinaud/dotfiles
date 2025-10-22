#!/usr/bin/env bash

# Install command-line tools using APT.

# Make sure we’re using the latest package lists and upgrade existing packages.
sudo apt update
sudo apt upgrade -y

# --- Locale configuration ---
# Ensure the en_US.UTF-8 locale exists.
if ! locale -a | grep -q '^en_US.utf8$'; then
	sudo sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
	sudo locale-gen en_US.UTF-8
fi
sudo update-locale LANG=en_US.UTF-8

# --- Git (latest stable) ---
# Install the Git Core PPA to get the newest stable Git build.
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update

# --- Core Development & Utility Packages ---
sudo apt install -y \
	ack \
	bash \
	bash-completion \
	git \
	git-lfs \
	gnupg \
	openssh-client \
	p7zip-full \
	pigz \
	pv \
	rename \
	rlwrap \
	screen \
	shfmt \
	tree \
	vim \
	wget

# Remove packages that were automatically installed and are no longer needed.
sudo apt autoremove -y

echo "Ubuntu package installation complete."
