#!/bin/bash
set -e
set -o pipefail

###################################
#   Install from sources
###################################

# Prepare a working dir to build nvim
cd /tmp
WORK_DIR=`mktemp -d -p /tmp`

# Check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "[dotfiles-nvim-debian] Could not create temp dir"
  exit 1
fi

# Change working dir
echo "[dotfiles-nvim-debian] Created workdir: $WORK_DIR"
cd $WORK_DIR

# Install required packages 
sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen python3-venv

# Clone repository
echo "[dotfiles-nvim-debian] Clone neovim into $WORK_DIR"
git clone https://github.com/neovim/neovim.git $WORK_DIR

echo "[dotfiles-nvim-debian] Build from sources (make)"
make CMAKE_BUILD_TYPE=RelWithDebInfo

echo "[dotfiles-nvim-debian] Build from sources (make install)"
sudo make install

echo "[dotgiles-nvim-debian] nvim has been successfully instaled from sources"
