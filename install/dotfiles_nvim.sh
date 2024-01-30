
#!/bin/bash
set -e

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

printf "[dotfiles-nvim] Install nvimchad. Clone repository in  ~/.config/nvim\n"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

printf "[dotfiles-nvim] Creating nvimchad symlink for custom config: $NVIM_CONFIG_DIR ( $DOT_FILES/nvim )\n"
ln -s $DOT_FILES/nvim/nvchad $NVIM_CONFIG_DIR/lua/custom
