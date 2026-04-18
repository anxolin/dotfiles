#!/bin/bash
set -e
set -o pipefail

###################################
#   Install nvim from release tarball
###################################
# Previously built from source — replaced with the pre-built tarball
# from neovim/neovim releases. Much faster and avoids pulling a full
# build toolchain (ninja, libtool, cmake, etc.).

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
  x86_64)         NVIM_ARCH="linux-x86_64" ;;
  aarch64|arm64)  NVIM_ARCH="linux-arm64"  ;;
  *)
    echo "[install-nvim-debian] Unsupported arch: $ARCH"
    echo "[install-nvim-debian] No pre-built nvim release for this arch; build from source manually if needed."
    exit 1
    ;;
esac

TARBALL="nvim-${NVIM_ARCH}.tar.gz"
URL="https://github.com/neovim/neovim/releases/latest/download/${TARBALL}"

# Work in a temp dir
WORK_DIR=$(mktemp -d)
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "[install-nvim-debian] Could not create temp dir"
  exit 1
fi
trap 'rm -rf "$WORK_DIR"' EXIT

cd "$WORK_DIR"

echo "[install-nvim-debian] Downloading latest nvim release: $URL"
curl -fL -o "$TARBALL" "$URL"

echo "[install-nvim-debian] Extracting to /opt"
sudo rm -rf "/opt/nvim-${NVIM_ARCH}"
sudo tar -C /opt -xzf "$TARBALL"

echo "[install-nvim-debian] Symlinking /usr/local/bin/nvim"
sudo ln -sf "/opt/nvim-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim

echo "[install-nvim-debian] nvim $(/usr/local/bin/nvim --version | head -1) installed"
