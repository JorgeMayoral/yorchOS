#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 -y install dnf5-plugins git-delta stow bat fzf helix golang 7zip zoxide libnotify ripgrep tmux libreoffice gimp inkscape hexyl

dnf5 -y config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
dnf5 -y install gh --repo gh-cli

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 -y install wezterm
dnf5 -y copr disable wezfurlong/wezterm-nightly

dnf5 -y copr enable atim/bottom
dnf5 -y install bottom
dnf5 -y copr disable atim/bottom

#### Example for enabling a System Unit File

systemctl enable podman.socket


# CATPPUCCIN CURSORS
mkdir -p /usr/share/icons
cd /usr/share/icons
curl -LOsS https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-mocha-sky-cursors.zip
curl -LOsS https://github.com/catppuccin/cursors/releases/download/v2.0.0/catppuccin-latte-sky-cursors.zip
unzip catppuccin-mocha-sky-cursors.zip
unzip catppuccin-latte-sky-cursors.zip

# CATPPUCCIN ICONS
wget -qO- https://git.io/papirus-icon-theme-install | sh
cd /tmp
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
mkdir -p /usr/share/icons/Papirus
cp -r src/* /usr/share/icons/Papirus  
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
./papirus-folders -C cat-mocha-sky --theme Papirus-Dark
./papirus-folders -C cat-latte-sky --theme Papirus-Light


# CLEANUP
# Clean package manager cache
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

# Clean /var directory while preserving essential files
find /var/* -maxdepth 0 -type d \! -name cache -exec rm -fr {} \;
find /var/cache/* -maxdepth 0 -type d \! -name libdnf5 \! -name rpm-ostree -exec rm -fr {} \;

# Restore and setup directories
mkdir -p /var/tmp
chmod -R 1777 /var/tmp

# Commit and lint container
ostree container commit
bootc container lint
