
#!/bin/bash
set -e

# See Install instructions in https://nvchad.com/docs/quickstart/install
NVCHAD_REPO=https://github.com/NvChad/starter
NVIM_CONFIG_DIR=~/.config/nvim
DOT_FILES=~/dotfiles

# Backup any previous config
TIME_STAMP=$(date +%F_%R)
BACKUP_DIR=~/dotfiles/backup/nvim_$TIME_STAMP

printf "[dotfiles-nvim] Backup old nvim config into '$BACKUP_DIR'\n"
mkdir -p $BACKUP_DIR
mkdir -p ~/.config
cp -rf $NVIM_CONFIG_DIR $BACKUP_DIR 2>/dev/null || :

printf "[dotfiles-nvim] Delete old nvim config\n"
rm -rf $NVIM_CONFIG_DIR  2>/dev/null || :
rm -rf ~/.local/share/nvim 2>/dev/null || :

printf "[dotfiles-nvim] Install nvimchad. Clone repository in  $NVIM_CONFIG_DIR\n"
git clone $NVCHAD_REPO $NVIM_CONFIG_DIR --depth 1

printf "[dotfiles-nvim] Creating nvimchad symlink for custom config: $NVIM_CONFIG_DIR ( $DOT_FILES/nvim )\n"
ln -s $DOT_FILES/nvim/nvchad $NVIM_CONFIG_DIR/lua/custom


# Install some NPM packages
if command -v npm >/dev/null 2>&1; then
  printf "[dotfiles-nvim] Installing some NPM packages"
  npm i -g vscode-langservers-extracted
else
  printf "[dotfiles-nvim] Node.js not installed. Skipping installing some packages"
fi

