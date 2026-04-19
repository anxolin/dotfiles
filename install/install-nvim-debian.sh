#!/bin/bash
set -e
set -o pipefail

###################################
#   Install nvim
###################################
# Fast path: download pre-built release tarball (requires modern GLIBC).
# Fallback: build from source on older systems (Debian 11, etc.) where the
# release tarball's libc requirements aren't met.
#
# Note: this script is sourced by install.sh, so it must not change the
# parent shell's working directory or leave its $PWD pointing at a temp dir
# that gets removed (breaks subsequent `git clone` calls).

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

  echo "[install-nvim-debian] Downloading latest nvim release: $URL"
  curl -fL -o "$WORK_DIR/$TARBALL" "$URL"

  echo "[install-nvim-debian] Extracting to /opt"
  sudo rm -rf "/opt/nvim-${NVIM_ARCH}"
  sudo tar -C /opt -xzf "$WORK_DIR/$TARBALL"

  echo "[install-nvim-debian] Symlinking /usr/local/bin/nvim"
  sudo ln -sf "/opt/nvim-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim

  rm -rf "$WORK_DIR"
}

install_from_source() {
  local WORK_DIR
  echo "[install-nvim-debian] Installing build dependencies"
  sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf \
    automake cmake g++ pkg-config unzip curl doxygen python3-venv git

  # Remove any previous tarball-based install (broken symlink or old dir)
  if [[ -L /usr/local/bin/nvim ]]; then
    echo "[install-nvim-debian] Removing previous tarball symlink at /usr/local/bin/nvim"
    sudo rm -f /usr/local/bin/nvim
  fi
  sudo rm -rf /opt/nvim-linux-x86_64 /opt/nvim-linux-arm64

  WORK_DIR=$(mktemp -d)

  echo "[install-nvim-debian] Cloning neovim (stable)"
  git clone --depth 1 --branch stable https://github.com/neovim/neovim.git "$WORK_DIR"

  echo "[install-nvim-debian] Building (this may take several minutes)"
  # Subshell: keeps parent shell's PWD unchanged
  ( cd "$WORK_DIR" && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install )

  rm -rf "$WORK_DIR"
}

echo "[install-nvim-debian] Detected GLIBC $CURRENT_GLIBC (nvim tarball needs $MIN_GLIBC+)"
if version_ge "$CURRENT_GLIBC" "$MIN_GLIBC"; then
  install_from_tarball
else
  echo "[install-nvim-debian] GLIBC too old; falling back to source build"
  install_from_source
fi

echo "[install-nvim-debian] Verifying install"
if nvim --version | head -1; then
  echo "[install-nvim-debian] nvim installed successfully"
else
  echo "[install-nvim-debian] nvim failed to run — check output above"
  exit 1
fi
