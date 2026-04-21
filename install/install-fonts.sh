#!/bin/bash
set -e

# Install JetBrains Mono Nerd Font (patched with ~3500 extra glyphs for p10k,
# lazygit, nvim-web-devicons, etc.).
#
# macOS: Homebrew cask (keeps font up-to-date via `brew upgrade --cask`).
# Linux: Download latest patched release from ryanoasis/nerd-fonts into
#        ~/.local/share/fonts/ (per-user, no sudo required).
#
# Not sourcing-safe — invoked as a script from install.sh.

FONT_NAME="JetBrainsMono"
FONT_DISPLAY="JetBrains Mono Nerd Font"

case "$(uname -s)" in
  Darwin)
    if ! command -v brew &>/dev/null; then
      echo "[install-fonts] Homebrew not installed; skipping font install"
      exit 0
    fi
    # Two paths to "already installed":
    #   1. brew knows about the cask
    #   2. font files exist in ~/Library/Fonts (e.g. from a prior manual install)
    # Either way, skip — avoids the "already a Font at …" error on re-runs.
    if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
      echo "[install-fonts] $FONT_DISPLAY already installed via brew cask"
    elif ls "$HOME/Library/Fonts/"JetBrainsMono*NerdFont*.ttf &>/dev/null; then
      echo "[install-fonts] $FONT_DISPLAY .ttf files already present in ~/Library/Fonts; skipping brew install"
      echo "[install-fonts] (To convert to a brew-managed install: rm those .ttf files and re-run this script)"
    else
      echo "[install-fonts] Installing $FONT_DISPLAY via brew cask"
      brew install --cask font-jetbrains-mono-nerd-font
    fi
    ;;

  Linux)
    FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
    if [ -d "$FONT_DIR" ] && ls "$FONT_DIR"/*.ttf &>/dev/null; then
      echo "[install-fonts] $FONT_DISPLAY already present at $FONT_DIR"
    else
      mkdir -p "$FONT_DIR"
      TMP_ZIP=$(mktemp -u /tmp/nerdfont-XXXXXX).zip
      URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
      echo "[install-fonts] Downloading $FONT_DISPLAY: $URL"
      curl -fL -o "$TMP_ZIP" "$URL"
      unzip -oq "$TMP_ZIP" -d "$FONT_DIR"
      rm -f "$TMP_ZIP"
      if command -v fc-cache &>/dev/null; then
        fc-cache -f "$FONT_DIR"
      fi
      echo "[install-fonts] Installed $FONT_DISPLAY to $FONT_DIR"
    fi
    ;;

  *)
    echo "[install-fonts] Unsupported OS: $(uname -s); skipping"
    ;;
esac
