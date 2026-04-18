#!/bin/bash
set -e
set -o pipefail

###################################
#   Install nvim
###################################
# Fast path: download pre-built release tarball (requires modern GLIBC).
# Fallback: build from source on older systems (Debian 11, etc.) where the
# release tarball's libc requirements aren't met.

# Neovim release tarballs are currently built against GLIBC 2.34 (Ubuntu
# 22.04 / Debian 12 bookworm and newer). Older distros must build from source.
MIN_GLIBC="2.34"

# Detect current GLIBC version
CURRENT_GLIBC=$(ldd --version | head -1 | grep -oE '[0-9]+\.[0-9]+$' || echo "0.0")

# Compare versions: returns 0 if $1 >= $2
version_ge() {
  [[ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -1)" == "$2" ]]
}

install_from_tarball() {
  local ARCH NVIM_ARCH TARBALL URL WORK_DIR
  ARCH=$(uname -m)
  case "$ARCH" in
    x86_64)         NVIM_ARCH="linux-x86_64" ;;
    aarch64|arm64)  NVIM_ARCH="linux-arm64"  ;;
    *)
      echo "[install-nvim-debian] Unsupported arch for tarball: $ARCH"
      return 1
      ;;
  esac

  TARBALL="nvim-${NVIM_ARCH}.tar.gz"
  URL="https://github.com/neovim/neovim/releases/latest/download/${TARBALL}"

  WORK_DIR=$(mktemp -d)
  trap 'rm -rf "$WORK_DIR"' RETURN
  cd "$WORK_DIR"

  echo "[install-nvim-debian] Downloading latest nvim release: $URL"
  curl -fL -o "$TARBALL" "$URL"

  echo "[install-nvim-debian] Extracting to /opt"
  sudo rm -rf "/opt/nvim-${NVIM_ARCH}"
  sudo tar -C /opt -xzf "$TARBALL"

  echo "[install-nvim-debian] Symlinking /usr/local/bin/nvim"
  sudo ln -sf "/opt/nvim-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
}

install_from_source() {
  local WORK_DIR
  echo "[install-nvim-debian] Installing build dependencies"
  sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf \
    automake cmake g++ pkg-config unzip curl doxygen python3-venv git

  WORK_DIR=$(mktemp -d)
  trap 'rm -rf "$WORK_DIR"' RETURN
  cd "$WORK_DIR"

  echo "[install-nvim-debian] Cloning neovim"
  # Pin to stable tag so builds are reproducible; bump as needed
  git clone --depth 1 --branch stable https://github.com/neovim/neovim.git .

  echo "[install-nvim-debian] Building (make CMAKE_BUILD_TYPE=RelWithDebInfo)"
  make CMAKE_BUILD_TYPE=RelWithDebInfo

  echo "[install-nvim-debian] Installing (make install)"
  sudo make install
}

echo "[install-nvim-debian] Detected GLIBC $CURRENT_GLIBC (nvim tarball needs $MIN_GLIBC+)"
if version_ge "$CURRENT_GLIBC" "$MIN_GLIBC"; then
  install_from_tarball
else
  echo "[install-nvim-debian] GLIBC too old; falling back to source build (this takes several minutes)"
  install_from_source
fi

echo "[install-nvim-debian] Verifying install"
if nvim --version | head -1; then
  echo "[install-nvim-debian] nvim installed successfully"
else
  echo "[install-nvim-debian] nvim failed to run — check output above"
  exit 1
fi
