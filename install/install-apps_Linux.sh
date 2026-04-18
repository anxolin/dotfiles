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
#   - fd (fd-find on Debian, binary `fdfind`): Fast find alternative; used by telescope.nvim and snacks.picker
#   - xclip: Allows to share the clipboard between tmux and the X's
#   - xdg-utils: Provides xdg-open, used by Neovim's vim.ui.open (e.g. gx to open URLs)
#   - cmake: To build packages
#   - bat: cat with syntax highlighting (binary named `batcat` on Debian/Ubuntu)
#   - gh: GitHub CLI (on Debian, installed from GitHub's official apt repo)

# If Debian based
if [[ -f /etc/debian_version ]]; then
    # Install some useful apps (neovim is not installed, as its built from source instead for Debian systems)
    #sudo apt-get -y install ripgrep zsh silversearcher-ag xclip cmake
    sudo apt-get -y install ripgrep fd-find zsh xclip xdg-utils cmake bat

    # Install gh (GitHub CLI) from the official repo — not in Debian bullseye's apt.
    if ! command -v gh &>/dev/null; then
        printf "[install-apps-Linux] Install gh (GitHub CLI) from cli.github.com\n"
        (type -p wget >/dev/null || sudo apt-get install -y wget) \
            && sudo mkdir -p -m 755 /etc/apt/keyrings \
            && out=$(mktemp) && wget -nv -O"$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg \
            && sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg < "$out" > /dev/null \
            && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
            && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
                | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
            && sudo apt-get update \
            && sudo apt-get install -y gh
    fi

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
    sudo pacman -S --noconfirm zsh neovim ripgrep fd xclip xdg-utils cmake bc bat unzip github-cli
fi

# Alpine linux
if [[ -f /etc/alpine-release ]]; then
    printf "[install-apps-Linux] alpine: Install basic apps\n"
    sudo apk add --no-cache zsh neovim ripgrep fd xclip xdg-utils cmake bat github-cli
fi
