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
  # FILE may be a plain name (e.g. "vimrc") or a subpath (e.g. "zsh/zshrc").
  # The home-side dotfile uses just the basename so subpaths still produce ~/.zshrc etc.
  TARGET=".$(basename "$FILE")"
  rm -rf "$HOME/$TARGET"

  if [ "$FILE" == "gitconfig" ]; then
    # For gitconfig we copy a template so machine-local edits don't pollute the repo.
    printf "[dotfiles-wipe-and-install] Creating profile file %s (using %s.example as template)\n" "$TARGET" "$FILE"
    cp "$DOT_FILES/$FILE.example" "$HOME/$TARGET"
  else
    printf "[dotfiles-wipe-and-install] Creating symlink %s -> %s\n" "$TARGET" "$DOT_FILES/$FILE"
    ln -s "$DOT_FILES/$FILE" "$HOME/$TARGET"
  fi
done < dotfiles.list
