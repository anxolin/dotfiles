#!/bin/bash
set -e

TIMESTAMP=$(date +%F_%R)
VS_USER_DIR="$HOME/Library/Application Support/Code/User"
VS_CONFIG_FILE="$VS_USER_DIR/settings.json"
VS_SNIPPETS_FILE="$VS_USER_DIR/snippets"
VS_CONFIG_BACKUP_FILE="$VS_USER_DIR/settings_$TIMESTAMP.json"
VS_CONFIG_BACKUP_SNIPPETS="$VS_USER_DIR/snippets_$TIMESTAMP"
VS_DOTFILES_DIR="$HOME/dotfiles/vsCode"

echo "Backup VS config file and snippets"
mkdir -p "$VS_USER_DIR/snippets"
touch "$VS_CONFIG_FILE"
mv "$VS_CONFIG_FILE" "$VS_CONFIG_BACKUP_FILE"
mv "$VS_SNIPPETS_FILE" "$VS_CONFIG_BACKUP_SNIPPETS"

echo "Point VS settings and snippets to the one in dotfiles ($VS_DOTFILES_DIR)"
ln -s "$VS_DOTFILES_DIR/settings.json" "$VS_CONFIG_FILE"
ln -s "$VS_DOTFILES_DIR/snippets" "$VS_SNIPPETS_FILE"
