#!/usr/bin/env bash

# Install command-line tools using APT.

# Make sure we’re using the latest package lists and upgrade existing packages.
sudo apt update
sudo apt upgrade -y

# --- Locale configuration ---
# Ensure the en_US.UTF-8 locale exists so tools referencing it (e.g. Git) behave.
if ! locale -a | grep -q '^en_US.utf8$'; then
	sudo sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
	sudo locale-gen en_US.UTF-8
fi
sudo update-locale LANG=en_US.UTF-8

# --- Git (latest stable) ---
# Install the Git Core PPA so we always get the newest stable Git build.
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update

# --- Core GNU Utilities ---
# On Ubuntu, the core utilities (coreutils, findutils, sed, grep) are already
# the modern GNU versions. The original script installs these to replace the
# outdated BSD versions that come with macOS. This is unnecessary here.
# brew install coreutils      -> (not needed)
# brew install findutils      -> (not needed)
# brew install gnu-sed        -> (not needed)
# brew install grep           -> (not needed)

# --- Modern Bash ---
# Install a modern version of Bash and bash completion.
sudo apt install -y bash bash-completion

# The logic to switch to a brew-installed bash is less critical on Ubuntu,
# as the default bash is usually up-to-date. You can uncomment this if
# you want to ensure it's explicitly set.
# if ! fgrep -q "/usr/bin/bash" /etc/shells; then
#   echo "/usr/bin/bash" | sudo tee -a /etc/shells;
#   chsh -s "/usr/bin/bash";
# fi;

# --- Standard Utilities ---
# Install `wget` and GnuPG for PGP-signing commits.
sudo apt install -y wget gnupg

# Install more recent versions of some tools.
sudo apt install -y vim openssh-client screen php-cli libgmp-dev

# --- Font Tools ---
# These may require adding a PPA if not in the default repos,
# but are often available directly.
sudo apt install -y woff2

# --- CTF / Security Tools ---
# Note: Some package names may differ slightly from their Homebrew versions.
sudo apt install -y aircrack-ng binutils binwalk dns2tcp fcrackzip \
	foremost hydra john knockd netpbm nmap pngcheck socat sqlmap \
	tcpflow tcpreplay tcptrace ucspi-tcp xpdf xz-utils

# The package 'bfg' is not in the standard Ubuntu repositories.
# It typically needs to be downloaded and run as a Java .jar file manually.
# The package 'cifer' is also not in standard repositories.

# --- Other Useful Binaries ---
sudo apt install -y ack git git-lfs ghostscript imagemagick lua5.3 lynx \
	p7zip-full pigz pv rename rlwrap tree vbindiff zopfli shfmt

# ssh-copy-id is part of the openssh-client package, already installed above.

# Remove packages that were automatically installed to satisfy dependencies
# for other packages and are now no longer needed.
sudo apt autoremove -y

echo "Ubuntu package installation complete."
