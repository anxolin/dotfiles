#!/bin/bash
set -e

# Update brew
# brew update

# Brew dependencies
# Vim dependencies:
#   - ctags: For tags in vim (jump-to-definition, auto-completion, and symbol lookup). See docs/vim.md
vim_dependencies=( ctags )

# Nvim dependencies:
#   - neovim: The Neo Vim editor. See docs/nvim.md
nvim_dependencies=( neovim )

# Development dependencies:
#   - zsh: Nicer shell. See docs/zsh.md
#   - the_silver_searcher: fast text searching tool (alternative to grep I used to use, now I use ripgrep)
#   - ripgrep: fast text searching tool (alternative to grep)
#   - fd: The silver searcher. See docs/vim.md
#   - cmake: For building packages
#   - bat: Syntax highlighting for terminal. See docs/vim.md
#   - tldr: Simplified and community-driven man pages
dev_dependencies=( zsh the_silver_searcher ripgrep fd cmake bat tldr )

# Tmux dependencies:
#   - reattach-to-user-namespace: For tmux, to allow to use the clipboard inside tmux. See docs/tmux.md
tmux_dependencies=( reattach-to-user-namespace )

# Combine all dependencies
brew_dependencies=( "${vim_dependencies[@]}" "${nvim_dependencies[@]}" "${dev_dependencies[@]}" "${tmux_dependencies[@]}" )
for package in "${brew_dependencies[@]}"
do  
  if ! brew ls --versions $package > /dev/null; then
	  echo "Installing $package with brew..."
    brew install $package
  else
    echo "$package is already installed"
  fi
done

# Install fzf
if [[ `which fzf &>/dev/null && $?` != 0 ]]; then  
  source ~/dotfiles/install/install-fzf.sh
fi
