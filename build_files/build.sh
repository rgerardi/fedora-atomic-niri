#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1
dnf5 remove -y firefox.x86_64 firefox-langpacks.x86_64

dnf5 remove -y sddm sddm-* kde-settings* plasma-*

dnf5 autoremove -y

# this installs a package from fedora repos
#dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y install SDL2_image \
		SDL3_image \
		SDL3_ttf \
		borgbackup \
		breeze-cursor-theme \
		breeze-gtk-common \
		breeze-gtk-gtk3 \
		breeze-gtk-gtk4 \
		breeze-icon-theme \
		brightnessctl \
		cascadia-fonts-all \
		chafa \
		curl \
		dunst \
		fastfetch \
		fontawesome-fonts-all \
		foot \
		foot-terminfo \
		fprintd \
		fprintd-pam \
		gdisk \
		glow \
		google-noto-sans-fonts \
		google-noto-sans-mono-fonts \
		google-noto-serif-fonts \
		grim \
		guestfs-tools \
		gum \
		htop \
		imv \
		iwd \
		jetbrains-mono-fonts-all \
		lm_sensors \
		niri \
		nwg-bar \
		parted \
		podman-compose \
		podman-machine \
		podman-tui \
		powertop \
		qt6ct \
		rclone \
		socat \
		slurp \
		swaybg \
		swayidle \
		tailscale \
		tmux \
		vulkan-tools \
		waybar \
		wev \
		wl-clipboard \
		wofi \
		zsh \
		zsh-autosuggestions \
		zsh-syntax-highlighting

dnf5 clean all

#### Example for enabling a System Unit File

#systemctl enable podman.socket
