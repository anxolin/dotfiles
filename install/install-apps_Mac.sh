#!/bin/bash
set -e



# Update brew
# brew update

# Vim dependencies:
#   - watchexec: Allow to run a command when a file changes
dev_dependencies=( watchexec )

# Brew dependencies
# Vim dependencies:
#   - ctags: For tags in vim (jump-to-definition, auto-completion, and symbol lookup). See docs/vim.md
vim_dependencies=( ctags )

# Nvim dependencies:
#   - neovim: The Neo Vim editor. See docs/nvim.md
#   - luarocks: Lua package manager (required by mason.nvim for some LSP servers/tools)
#   - imagemagick: Image processing (required by snacks.nvim image rendering to convert images)
#   - ghostscript: PDF rendering support (required by snacks.nvim to render PDF files in terminal)
#   - tectonic: LaTeX engine (required by snacks.nvim to render LaTeX math expressions)
nvim_dependencies=( neovim luarocks imagemagick ghostscript tectonic )

# Development dependencies:
#   - zsh: Nicer shell. See docs/zsh.md
#   - the_silver_searcher: fast text searching tool (alternative to grep I used to use, now I use ripgrep)
#   - ripgrep: fast text searching tool (alternative to grep)
#   - fd: The silver searcher. See docs/vim.md
#   - cmake: For building packages
#   - bat: Syntax highlighting for terminal. See docs/vim.md
#   - tldr: Simplified and community-driven man pages
#   - uv: Modern Python toolchain (package manager, venv, Python installer) — replaces pyenv+pip+virtualenv+pipx
#   - ruff: Fast Python linter/formatter (replaces black+flake8+isort)
dev_dependencies=( zsh the_silver_searcher ripgrep fd cmake bat tldr solidity uv ruff)

# Tmux dependencies:
#   - reattach-to-user-namespace: For tmux, to allow to use the clipboard inside tmux. See docs/tmux.md
tmux_dependencies=( reattach-to-user-namespace )

# Combine all dependencies
brew_dependencies=( "${dev_dependencies[@]}" "${vim_dependencies[@]}" "${nvim_dependencies[@]}" "${dev_dependencies[@]}" "${tmux_dependencies[@]}" )
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
