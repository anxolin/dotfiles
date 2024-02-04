#!/bin/bash
set -e
set -o pipefail

###################################
#   Install from sources
###################################

# Prepare a working dir to build lazygit
cd /tmp
WORK_DIR=`mktemp -d -p /tmp`

# Check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "[dotfiles-lazygit-debian] Could not create temp dir"
  exit 1
fi

# Change working dir
echo "[dotfiles-lazygit-debian] Created workdir: $WORK_DIR"
cd $WORK_DIR

# Check latest version
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
echo "[dotfiles-lazygit-debian] Latest version of lazygit is $LAZYGIT_VERSION"

# Clone repository
echo "[dotfiles-lazygit-debian] Dowload lazygit version $LAZYGIT_VERSION"
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit

echo "[dotfiles-lazygit-debian] Install lazygit version $LAZYGIT_VERSION"
sudo install lazygit /usr/local/bin

echo "[dotgiles-lazygit-debian] lazygit has been successfully instaled from sources"
