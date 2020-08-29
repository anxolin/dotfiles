#!/bin/bash
set -e

# Initialize submodules
echo "[init-submodules] Install 'Oh My ZSH' + Themes"
cd $HOME/dotfiles && git submodule update --init --recursive