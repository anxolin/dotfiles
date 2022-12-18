#!/bin/bash
set -e

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# dotfiles directory
DOT_FILES=~/dotfiles
cd $DOT_FILES


echo "[dotfiles-wipe-and-install] Create local ZSH config directory"
mkdir -p ~/.zsh
touch ~/.zsh/alias.zsh ~/.zsh/config.zsh ~/.zsh/dev.zsh ~/.zsh/path.zsh

# Dot files install:
#   1. Backup: Copy any existing dotfiles to dotfiles_old directory
#   2. Symlink: Create symlinks in the homedir pointing to the dotfile
printf "[dotfiles-wipe-and-install] Wipe previous dotfiles and install new ones\n"
while read FILE; do
  if [ "$FILE" == "" ]; then
    echo "[dotfiles-wipe-and-install] Error, file is undefined"
    exit 1
  fi
  rm -rf -r ~/.$FILE

  #if [ "$FILE" == "zshrc" ] || [ "$FILE" == "bashrc" ] || [ "$FILE" == "gitconfig" ]; then
  if [ "$FILE" == "gitconfig" ]; then
    # For bashrc and zshrc, we don't want to keep the file versioned, because a lot
    # of scripts keep adding lines there as part of the install
    # Instead, we use a bashrc_base and zshrc_base
    printf "[dotfiles-wipe-and-install] Creating profile file .$FILE (using $DOT_FILES/$FILE.example as template)\n"
    cp $DOT_FILES/$FILE.example ~/.$FILE
  else
    # All other confi files are versioned
    printf "[dotfiles-wipe-and-install] Creating symlink .$FILE ( ~$DOT_FILES/$FILE )\n"
    ln -s $DOT_FILES/$FILE ~/.$FILE
  fi
done < dotfiles.list
