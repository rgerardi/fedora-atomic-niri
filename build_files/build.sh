#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1
dnf5 remove -y firefox.x86_64 firefox-langpacks.x86_64

dnf5 remove -y sddm sddm-* kde-settings* plasma-*

dnf5 remove -y kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra

dnf5 autoremove -y

dnf5 copr enable bieszczaders/kernel-cachyos
dnf5 copr enable bieszczaders/kernel-cachyos-addons
dnf5 -y install kernel-cachyos cachyos-settings scx-scheds scx-tools ananicy-cpp

setsebool -P domain_kernel_load_modules on

# this installs a package from fedora repos
#dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y group install virtualization --with-optional

dnf5 -y install SDL2_image \
		SDL3_image \
		SDL3_ttf \
		atuin \
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
		distrobox \
		dunst \
		fastfetch \
		fontawesome-fonts-all \
		foot \
		foot-terminfo \
		fprintd \
		fprintd-pam \
		fzf \
		gdisk \
		glow \
		google-noto-sans-fonts \
		google-noto-sans-mono-fonts \
		google-noto-serif-fonts \
		grim \
		gum \
		htop \
		imv \
		incus \
		incus-client \
		incus-tools \
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
		stow \
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
		zsh-syntax-highlighting \
		zoxide

cat <<EOT > /etc/yum.repos.d/smallstep.repo
[smallstep]
name=Smallstep
baseurl=https://packages.smallstep.com/stable/fedora/
enabled=1
repo_gpgcheck=0
gpgcheck=1
gpgkey=https://packages.smallstep.com/keys/smallstep-0x889B19391F774443.gpg
EOT
dnf5 makecache && dnf5 install -y step-cli

dnf5 clean all

#### Example for enabling a System Unit File

#systemctl enable podman.socket
