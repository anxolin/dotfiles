#!/bin/bash
set -e

# Install Catppuccin themes for bat (from ~/dotfiles/bat/themes/).
# Skips quietly if bat isn't on PATH — bat itself is installed by the
# platform-specific apps script.

if ! command -v bat >/dev/null 2>&1; then
  printf "[dotfiles-bat] bat not installed — skipping\n"
  exit 0
fi

SRC=~/dotfiles/bat/themes
DST="$(bat --config-dir)/themes"
mkdir -p "$DST"

printf "[dotfiles-bat] Installing Catppuccin themes into %s\n" "$DST"
for f in "$SRC"/*.tmTheme; do
  ln -sf "$f" "$DST/$(basename "$f")"
done

printf "[dotfiles-bat] Rebuilding bat cache\n"
bat cache --build >/dev/null

printf "[dotfiles-bat] bat themes installed\n"
