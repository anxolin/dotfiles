#!/usr/bin/env bash
# Refresh ~/dotfiles/bat/themes/ from catppuccin/bat upstream.
#
# Run when you want to pick up upstream tweaks. Symlinks in
# ~/.config/bat/themes/ already point here, so no further install needed
# — just `bat cache --build` if syntax/theme metadata changes.
#
# Review the resulting `git diff bat/themes/` before committing.

set -euo pipefail

DEST=~/dotfiles/bat/themes
BASE="https://raw.githubusercontent.com/catppuccin/bat/main/themes"
THEMES=(
  "Catppuccin Latte.tmTheme"
  "Catppuccin Frappe.tmTheme"
  "Catppuccin Macchiato.tmTheme"
  "Catppuccin Mocha.tmTheme"
)

if ! command -v curl >/dev/null 2>&1; then
  echo "update-bat-themes: curl not found" >&2
  exit 1
fi

mkdir -p "$DEST"
for name in "${THEMES[@]}"; do
  # URL-encode spaces
  url="$BASE/${name// /%20}"
  printf "→ %s\n" "$name"
  curl -fsSL "$url" -o "$DEST/$name"
done

if command -v bat >/dev/null 2>&1; then
  bat cache --build >/dev/null
  printf "✓ bat cache rebuilt\n"
fi

printf "\nDone. Review changes: git -C ~/dotfiles diff bat/themes/\n"
