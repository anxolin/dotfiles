#!/bin/bash
set -e

# Symlink the glow config into glow's platform config dir. glow itself is
# installed by the platform-specific apps script.
#   macOS: ~/Library/Preferences/glow/glow.yml
#   Linux: ~/.config/glow/glow.yml

if ! command -v glow >/dev/null 2>&1; then
  printf "[dotfiles-glow] glow not installed — skipping\n"
  exit 0
fi

SRC=~/dotfiles/glow/glow.yml
# glow prints its resolved default config path in --help
DST="$(glow config --help 2>&1 | grep -o '/[^ )]*glow\.yml' | head -1)"
[ -n "$DST" ] || { printf "[dotfiles-glow] could not resolve config path — skipping\n"; exit 0; }

mkdir -p "$(dirname "$DST")"
rm -rf "$DST"
ln -s "$SRC" "$DST"
printf "[dotfiles-glow] Linked %s -> %s\n" "$DST" "$SRC"
