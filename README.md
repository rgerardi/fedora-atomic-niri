# fedora-atomic-niri

A custom [bootc](https://github.com/bootc-dev/bootc) image built from the Universal Blue [image-template](https://github.com/ublue-os/image-template). It is based on Fedora Atomic Desktop's `sway-atomic` image and replaces the window manager with [niri](https://github.com/YaLTeR/niri), a scrollable-tiling Wayland compositor.

## Features

> **Note:** This image only provides packages — it ships no built-in configuration (no niri config, dotfiles, themes, or system settings). You are expected to configure the entire system yourself.

- **Compositor & desktop**: niri, [waybar](https://github.com/Alexays/Waybar), nwg-bar, [dunst](https://github.com/dunst-project/dunst), wofi, swaybg, swayidle, foot, imv, wev, wl-clipboard, grim, slurp
- **Shell & terminal**: zsh with autosuggestions and syntax highlighting, tmux, atuin, zoxide, fzf, fastfetch, glow, chafa, htop, powertop
- **Containers & VMs**: podman (+ compose, machine, tui), distrobox, incus, ramalama, virtualization group
- **Networking & security**: tailscale, step-cli (smallstep), rclone, socat, iwd
- **Hardware & media**: fprintd (fingerprint PAM), brightnessctl, lm_sensors, gdisk, parted
- **Codecs**: rpmfusion free/nonfree with the `ffmpeg-free` → `ffmpeg` swap, `mesa-va-drivers-freeworld`, `libva-utils`, `gstreamer1-plugin-openh264`
- **Theme & fonts**: Breeze cursor/GTK/icon themes, Cascadia, JetBrains Mono, Font Awesome, Google Noto fonts
- **Removed**: Firefox, SDDM, Plasma/KDE settings (base image is Sway-based)

## Installation

On any existing Fedora Atomic / Universal Blue system:

```bash
sudo bootc switch ghcr.io/rgerardi/fedora-atomic-niri:latest
sudo reboot
```

## Fresh install

**Not supported.** The original disk-image scripts from the template are still in the repo (`build-disk.yml`, `disk_config/`, `just build-qcow2|build-raw|build-iso`), but no effort has been made to test or ensure they work. Use at your own risk.

## Building locally

Prerequisites: `just` and `podman`.

```bash
just build                       # builds fedora-atomic-niri:latest
just build fedora-atomic-niri lts
just lint                        # shellcheck on all *.sh
just format                      # shfmt on all *.sh
```

## Customization

All customization lives in `build_files/build.sh`, which is invoked by the `Containerfile`. Add/remove packages there using `dnf5`; third-party and COPR repositories (yalter/niri, smallstep, terra, tailscale, rpmfusion) are enabled and then disabled again so they are not left enabled on the final image. The build ends with `dnf5 clean all`.

## Signing

Published images are signed with [cosign](https://github.com/sigstore/cosign) using the repository's `SIGNING_SECRET`. The public key is committed at `cosign.pub`; never commit `cosign.key`. Verify with:

```bash
cosign verify --key cosign.pub ghcr.io/rgerardi/fedora-atomic-niri:latest
```

## CI

GitHub Actions builds and publishes the image to GHCR on every push to `main` (tags: `latest`, `latest.YYYYMMDD`, `YYYYMMDD`). Action versions are pinned and updated by Renovate and Dependabot.

## Acknowledgments

Based on the [ublue-os/image-template](https://github.com/ublue-os/image-template) and [YaLTeR/niri](https://github.com/YaLTeR/niri).
