
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


# All other confi files are versioned
printf "[dotfiles-nvim] Creating symlink $NVIM_CONFIG_DIR ( $DOT_FILES/nvim )\n"
ln -s $DOT_FILES/nvim $NVIM_CONFIG_DIR