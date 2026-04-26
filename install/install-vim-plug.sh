#!/bin/bash

# Install vim-plug plugin manager
# This script installs vim-plug to replace Vundle

set -e

echo "Installing vim-plug..."

# Vim looks for autoload at ~/.vim/autoload (the runtime dir).
# Note: pre-namespace-refactor this used ~/dotfiles/vim/autoload because
# ~/.vim was symlinked to ~/dotfiles/vim. Now ~/.vim is its own real dir.
mkdir -p ~/.vim/autoload

# Download vim-plug to the standard runtime location
curl -fLo ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install the plugins listed in vimrc
vim +PlugInstall +qall

echo "vim-plug installed successfully!"

