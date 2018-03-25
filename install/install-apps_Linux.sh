#!/bin/bash
set -e

# Installed apps:
#   - zsh: Nice shell
#   - gvim: Vim (graphical + regular)
#   - ag: Allows to search text fast in test files
#       useful for the terminal, but also I use it as a replacement for vim grep
#       (also named silversearcher-ag or the_silver_searcher)
#   - ctags: Tool for generating indexes in source files
#       Also uused in VIM for "Jump to definition" functionality)
#   - xclip: Allows to share the clipboard between tmux and the X's
#   - cmake: To build packages
#       Also required by "You complete me" vim plugin
#   

# If Debian
if [[ -f /etc/debian_version ]]; then
    printf "[install-apps-Linux] Debian: Install basic apps"
    sudo apt-get install zsh gvim silversearcher-ag xclip ctags cmake
fi

# Arch linux
if [[ -f /etc/arch-release ]]; then
    printf "[install-apps-Linux] Arch: Install basic apps"
    sudo pacman -S zsh gvim the_silver_searcher xclip ctags cmake
fi

# Set ZSH as the default shell
if [[ ! $(printf $SHELL) == $(which zsh) ]]; then
    printf "[install-apps-Linux] Set ZSH as the default shell"
    chsh -s $(which zsh)
fi
