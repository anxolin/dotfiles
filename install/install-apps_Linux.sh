#!/bin/bash
set -e


# Install fzf from sources
#if [[ `which fzf &>/dev/null && $?` != 0 ]]; then
if ! command -v fzf &>/dev/null; then
  echo "Install fzf from source code"
  source ~/dotfiles/install/install-fzf.sh
fi

# Installed apps:
#   - zsh: Nice shell
#   - nvim: Neo Vim (installed separately from source/release in install-nvim-debian.sh)
#   - ripgrep (rg): Fast code search; superseded silversearcher-ag
#   - xclip: Allows to share the clipboard between tmux and the X's
#   - cmake: To build packages
#   - bat: cat with syntax highlighting (binary named `batcat` on Debian/Ubuntu)

# If Debian based
if [[ -f /etc/debian_version ]]; then
    # Install some useful apps (neovim is not installed, as its built from source instead for Debian systems)
    #sudo apt-get -y install ripgrep zsh silversearcher-ag xclip cmake
    sudo apt-get -y install ripgrep zsh xclip cmake bat

    # Install bat: Syntax highlighting (for now, not in raspian for example)
    # Note: on Debian/Ubuntu the binary is installed as `batcat` (conflict with an older tool). Alias it if needed.
    #printf "[install-apps-Linux] Get bat deb and install. Syntax highlighting"
    #BAT_VERSION=0.24.0 # https://github.com/sharkdp/bat/releases
    #BAT_DEB_FILE="bat_${BAT_VERSION}_`dpkg --print-architecture`.deb"
    #wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/$BAT_DEB_FILE"
    #sudo apt install ./$BAT_DEB_FILE
    #rm $BAT_DEB_FILE
fi



# Arch linux
if [[ -f /etc/arch-release ]]; then
    printf "[install-apps-Linux] Arch: Install basic apps\n"
    #sudo pacman -S --noconfirm zsh neovim ripgrep ripgrep the_silver_searcher xclip cmake bc bat unzip
    sudo pacman -S --noconfirm zsh neovim ripgrep xclip cmake bc bat unzip
fi

# Alpine linux
if [[ -f /etc/alpine-release ]]; then
    printf "[install-apps-Linux] alpine: Install basic apps\n"
    sudo apk add --no-cache zsh neovim ripgrep xclip cmake bat
fi
