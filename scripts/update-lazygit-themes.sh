#!/usr/bin/env bash
# Refresh ~/dotfiles/lazygit/themes/ from catppuccin/lazygit upstream.
# Uses the "mauve" accent to match the catppuccin defaults already in use
# by tmux/nvim. Change ACCENT below to taste (blue, lavender, peach, …).
#
# Symlink in ~/.config/lazygit/config.yml already points here — no further
# install needed. Review with `git -C ~/dotfiles diff lazygit/themes/`.

set -euo pipefail

DEST=~/dotfiles/lazygit/themes
ACCENT="${1:-mauve}"
BASE="https://raw.githubusercontent.com/catppuccin/lazygit/main/themes-mergable"

if ! command -v curl >/dev/null 2>&1; then
  echo "update-lazygit-themes: curl not found" >&2
  exit 1
fi

mkdir -p "$DEST"
for flavor in latte mocha; do
  printf "→ %s/%s\n" "$flavor" "$ACCENT"
  curl -fsSL "$BASE/$flavor/$ACCENT.yml" -o "$DEST/$flavor.yml"
done

printf "\nDone. Review: git -C ~/dotfiles diff lazygit/themes/\n"
