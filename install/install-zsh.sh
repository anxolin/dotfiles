#!/bin/bash
set -e

# Install Oh My Zsh + plugins/themes into the standard OMZ layout (~/.oh-my-zsh).
# Previously vendored as git submodules inside the dotfiles repo; moved out so
# dotfiles/zsh/ only holds user-written config.

OMZ_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$OMZ_DIR/custom"

# Abort quietly if zsh isn't installed — some hosts don't have it yet.
command -v zsh >/dev/null 2>&1 || {
  echo "[install-zsh] zsh not installed yet; skipping OMZ install"
  exit 0
}

# --- Oh My Zsh ----------------------------------------------------------------
if [ -d "$OMZ_DIR" ]; then
  echo "[install-zsh] OMZ already present at $OMZ_DIR"
else
  echo "[install-zsh] Installing Oh My Zsh (unattended)"
  # --unattended prevents the installer from starting a zsh session at the end
  # and from overwriting ~/.zshrc (we manage that ourselves).
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Custom plugins / themes --------------------------------------------------
clone_if_missing() {
  local repo="$1" dest="$2" label="$3"
  if [ -d "$dest" ]; then
    echo "[install-zsh] $label already present at $dest"
  else
    echo "[install-zsh] Cloning $label"
    git clone --depth 1 "$repo" "$dest"
  fi
}

clone_if_missing \
  https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k" \
  "Powerlevel10k theme"

clone_if_missing \
  https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" \
  "zsh-syntax-highlighting"

clone_if_missing \
  https://github.com/zsh-users/zsh-autosuggestions.git \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions" \
  "zsh-autosuggestions"

# Symlink user-written themes from the dotfiles repo into OMZ's custom/themes dir
mkdir -p "$ZSH_CUSTOM/themes"
ln -sf "$HOME/dotfiles/zsh/anxo.zsh-theme" "$ZSH_CUSTOM/themes/anxo.zsh-theme"

echo "[install-zsh] Done. OMZ + plugins installed to $OMZ_DIR"
