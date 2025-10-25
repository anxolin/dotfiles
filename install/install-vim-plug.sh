#!/bin/bash

# Install vim-plug plugin manager
# This script installs vim-plug to replace Vundle

set -e

echo "Installing vim-plug..."

# Create dotfiles vim directories if they don't exist
mkdir -p ~/dotfiles/vim/autoload

# Download and install vim-plug to the dotfiles location
curl -fLo ~/dotfiles/vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
echo "  :PlugList       - List installed plugins"
