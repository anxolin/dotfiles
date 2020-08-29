#!/bin/bash
set -e

# Initialize submodules
if [[ ! -f $HOME/dotfiles/oh-my-zsh/oh-my-zsh.sh ]]; then
  echo "[init-submodules] Install 'Oh My ZSH' + Themes"
  cd $HOME/dotfiles && git submodule update --init --recursive
else
  echo "[init-submodules] 'Oh My ZSH' + Themes are already cloned"
fi