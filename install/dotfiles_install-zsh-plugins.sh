#!/bin/bash
set -e

# Initialize Oh My ZSH
if [[ ! -f $HOME/dotfiles/oh-my-zsh/oh-my-zsh.sh ]]; then
  echo "[dotfiles-install-zsh-plugins] Install 'Oh My ZSH'"
  cd $HOME/dotfiles && git submodule update --init --recursive
else
  echo "[dotfiles-install-zsh-plugins] 'Oh My ZSH' is already cloned"
fi


# Initialize Oh My ZSH
if [[ ! -f $HOME/dotfiles/zsh-custom/themes/powerlevel10k ]]; then
  echo "[dotfiles-install-zsh-plugins] Install 'PowerLevel10K Theme'"
  cd $HOME/dotfiles && git submodule update --init --recursive
else
  echo "[dotfiles-install-zsh-plugins] 'PowerLevel10K Theme' is already cloned"
fi



