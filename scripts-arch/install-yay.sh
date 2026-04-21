#!/usr/bin/env bash
set -e

# Install yay — the de-facto AUR helper on Arch Linux.
# Replaces the old pacaur/cower flow (both deprecated upstream).
#
# Alternative: paru (https://github.com/Morganamilo/paru). Same idea, Rust-based.
# To use paru instead: swap the two AUR_PKG=... lines and the repo URL.

if ! command -v pacman &>/dev/null; then
  echo "[install-yay] Not an Arch system (pacman missing); skipping"
  exit 0
fi

if command -v yay &>/dev/null; then
  echo "[install-yay] yay already installed: $(yay --version | head -1)"
  exit 0
fi

echo "[install-yay] Installing build deps"
sudo pacman -S --needed --noconfirm base-devel git

AUR_PKG=yay
AUR_URL="https://aur.archlinux.org/${AUR_PKG}.git"

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

echo "[install-yay] Cloning $AUR_URL"
git clone --depth 1 "$AUR_URL" "$WORK_DIR/$AUR_PKG"

# Subshell: keeps parent PWD intact (this script is often sourced)
echo "[install-yay] Building and installing $AUR_PKG"
( cd "$WORK_DIR/$AUR_PKG" && makepkg --syncdeps --install --noconfirm )

echo "[install-yay] $(yay --version | head -1) installed"
