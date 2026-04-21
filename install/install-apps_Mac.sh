#!/bin/bash
set -e

# Brew dependencies, grouped by purpose. All combined into brew_dependencies below.

# Vim:
#   - ctags: jump-to-definition, auto-completion, symbol lookup. See docs/vim.md
#   - watchexec: run a command when a file changes
vim_dependencies=( ctags watchexec )

# Nvim:
#   - neovim: the editor. See docs/nvim.md
#   - luarocks: Lua package manager (mason.nvim uses it for some LSP servers/tools)
#   - imagemagick: image processing (snacks.nvim image rendering)
#   - ghostscript: PDF rendering (snacks.nvim PDF support)
#   - tectonic: LaTeX engine (snacks.nvim math expression rendering)
nvim_dependencies=( neovim luarocks imagemagick ghostscript tectonic )

# Dev tools:
#   - zsh: nicer shell. See docs/zsh.md
#   - ripgrep: fast text search (replaces grep/ag)
#   - fd: fast file finder. See docs/vim.md
#   - cmake: build system
#   - bat: cat with syntax highlighting
#   - tldr: simplified, community man pages
#   - solidity: Solidity compiler
#   - uv: modern Python toolchain (replaces pyenv+pip+virtualenv+pipx)
#   - ruff: fast Python linter/formatter (replaces black+flake8+isort)
#   - fzf: fuzzy finder + shell integration
dev_dependencies=( zsh ripgrep fd cmake bat tldr solidity uv ruff fzf )

# Tmux:
#   - reattach-to-user-namespace: makes tmux clipboard work on macOS. See docs/tmux.md
tmux_dependencies=( reattach-to-user-namespace )

# Combine all dependencies
brew_dependencies=( "${vim_dependencies[@]}" "${nvim_dependencies[@]}" "${dev_dependencies[@]}" "${tmux_dependencies[@]}" )
for package in "${brew_dependencies[@]}"; do
  if ! brew ls --versions "$package" > /dev/null; then
    echo "Installing $package with brew..."
    brew install "$package"
  else
    echo "$package is already installed"
  fi
done

