#!/bin/bash
set -e


# Install fzf from sources
if [[ `which fzf &>/dev/null && $?` != 0 ]]; then
  echo "Install fzf from source code"
  source ~/dotfiles/install/install-fzf.sh
fi

# Installed apps:
#   - zsh: Nice shell
#   - gvim: Vim (graphical + regular)
#   - ag: Allows to search text fast in test files
#       useful for the terminal, but also I use it as a replacement for vim grep
#       (also named silversearcher-ag or the_silver_searcher)
#   - xclip: Allows to share the clipboard between tmux and the X's
#   - cmake: To build packages
#       Also required by "You complete me" vim plugin
#   

# If Debian based
if [[ -f /etc/debian_version ]]; then
    DISTRO=$(cat /etc/issue)
    sudo apt-get update
    if [[ $DISTRO = *"Ubuntu"* ]]; then
      printf "[install-apps-Linux] Ubuntu: Install basic apps"
      sudo apt-get install vim-nox bc
    else
      printf "[install-apps-Linux] Debian: Install basic apps"
      sudo apt-get install vim-athena bc
    fi
    sudo apt-get install zsh silversearcher-ag xclip cmake    

    BAT_DEBIAN_VERSION=bat_0.15.4_amd64.deb
    # Install bat
    wget https://github.com/sharkdp/bat/releases/download/v0.15.4/$BAT_DEBIAN_VERSION
    sudo apt install ./$BAT_DEBIAN_VERSION
    rm $BAT_DEBIAN_VERSION
fi



# Arch linux
if [[ -f /etc/arch-release ]]; then
    printf "[install-apps-Linux] Arch: Install basic apps"
    sudo pacman -S --noconfirm zsh gvim the_silver_searcher xclip cmake bc bat
    # gvim
fi

# Alpine linux
#if [[ -f /etc/alpine-release ]]; then
#    printf "[install-apps-Linux] alpine: Install basic apps"
#    su - root -c "apk add --no-cache zsh vim the_silver_searcher xclip cmake"
#fi

# Set ZSH as the default shell
#if [[ ! $(printf $SHELL) == $(which zsh) ]]; then
#    printf "[install-apps-Linux] Set ZSH as the default shell"
#    chsh -s $(which zsh)
#fi
