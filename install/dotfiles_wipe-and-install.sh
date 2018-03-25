#!/bin/bash
set -e

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# dotfiles directory
DOT_FILES=~/dotfiles
cd $DOT_FILES

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
  printf "[dotfiles-wipe-and-install] Creating symlink .$FILE ( ~$DOT_FILES/$FILE )\n"
  ln -s $DOT_FILES/$FILE ~/.$FILE
done < dotfiles.list


# Install Oh My Zsh 
#   Clone my oh-my-zsh repository from GitHub only if it isn't already present
echo "[dotfiles-wipe-and-install] Install 'Oh My ZSH' into $DOT_FILES/oh-my-zsh/"
if [[ ! -d $DOT_FILES/oh-my-zsh/ ]]; then
    git clone http://github.com/robbyrussell/oh-my-zsh.git
fi
