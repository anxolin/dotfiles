#!/bin/bash
set -e

# Install Catppuccin lazygit themes (from ~/dotfiles/lazygit/themes/).
# Points ~/.config/lazygit/config.yml at the theme matching the current
# $THEME_MODE. theme.zsh re-points the symlink on subsequent toggles.

SRC=~/dotfiles/lazygit/themes
CFG=~/.config/lazygit

if ! command -v lazygit >/dev/null 2>&1; then
  printf "[dotfiles-lazygit] lazygit not installed — skipping\n"
  exit 0
fi

mkdir -p "$CFG"

mode=$(~/dotfiles/scripts/theme-mode 2>/dev/null || echo dark)
flavor=mocha
[ "$mode" = light ] && flavor=latte

# Symlink the active theme as config.yml so any lazygit invocation picks it up.
# To add custom (non-theme) lazygit settings later, replace this symlink with
# a real config.yml that has `include: [...]` pointing back at $SRC/$flavor.yml.
ln -sf "$SRC/$flavor.yml" "$CFG/config.yml"

printf "[dotfiles-lazygit] lazygit theme set to catppuccin-%s\n" "$flavor"
