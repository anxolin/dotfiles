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
echo ""
echo "Next steps:"
echo "1. Open vim and run :PlugInstall to install all plugins"
echo "2. Or run: vim +PlugInstall +qall"
echo ""
echo "Useful vim-plug commands:"
echo "  :PlugInstall    - Install plugins"
echo "  :PlugUpdate     - Update plugins"
echo "  :PlugClean      - Remove unused plugins"
echo "  :PlugUpgrade    - Upgrade vim-plug itself"
echo "  :PlugStatus     - List installed plugins"

