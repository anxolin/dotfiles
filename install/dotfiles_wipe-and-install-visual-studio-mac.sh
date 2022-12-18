#!/bin/bash
set -e

# Directories
#     Official VS Config dir:               ~/Library/Application\ Support/Code/User/
#     Dotfiles (versioned config files):    ~/dotfiles/vscode
CONFIG_FILES=("settings.json" "keybindings.json")

TIMESTAMP=$(date "+%Y.%m.%d-%H.%M")
VS_USER_DIR="$HOME/Library/Application Support/Code/User"
VS_DOTFILES_DIR="$HOME/dotfiles/vscode"


echo "[dotfiles-visual-studio] Backup VS config file and snippets"
[ -d "$VS_USER_DIR" ] || mkdir -p "$VS_USER_DIR"

for CONFIG_FILE in ${CONFIG_FILES[*]}; do
    echo "[dotfiles-visual-studio]   - Backup $CONFIG_FILE"
    [ -f "$VS_USER_DIR/$CONFIG_FILE" ] && cp "$VS_USER_DIR/$CONFIG_FILE" "$VS_USER_DIR/${CONFIG_FILE}__$TIMESTAMP" || true
done

echo "[dotfiles-visual-studio] Point VS settings and snippets to the one in dotfiles ($VS_DOTFILES_DIR)"
for CONFIG_FILE in ${CONFIG_FILES[*]}; do
    echo "[dotfiles-visual-studio]   - Create Link to "$VS_DOTFILES_DIR/$CONFIG_FILE" from "$VS_USER_DIR/$CONFIG_FILE""
    [ -f "$VS_USER_DIR/$CONFIG_FILE" ] && rm "$VS_USER_DIR/$CONFIG_FILE" || true
    ln -s "$VS_DOTFILES_DIR/$CONFIG_FILE" "$VS_USER_DIR/$CONFIG_FILE"
done

# Re-create link to the snippets
#echo "[dotfiles-visual-studio]   - Point snippets dir to $VS_DOTFILES_DIR/snippets"
#[ -L "$VS_USER_DIR/snippets" ] && rm "$VS_USER_DIR/snippets" || true
#ln -s "$VS_DOTFILES_DIR/snippets" "$VS_USER_DIR/snippets"

