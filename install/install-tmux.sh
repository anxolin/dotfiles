#!/bin/bash
set -e

# Tmux setup
#    NOTE: The tmux installation happens in the general installation "install-apps_Linux.sh" and "install-apps-Mac.sh"

# Backup any previous config
TIME_STAMP=$(date +%F_%R)
BACKUP_DIR=~/dotfiles/backup/tmux_$TIME_STAMP
TMUX_CONF_DIR=~/.tmux

printf "[dotfiles-tmux] Backup old tmux config into '$BACKUP_DIR'\n"
mkdir -p $BACKUP_DIR
mkdir -p $TMUX_CONF_DIR
cp -rf $TMUX_CONF_DIR $BACKUP_DIR 2>/dev/null || :

printf "[dotfiles-tmux] Delete old tmux config\n"
rm -rf $TMUX_CONF_DIR  2>/dev/null || :

printf "[dotfiles-tmux] Install tmux plugin manager: tpm. Clone repository in $TMUX_CONF_DIR/plugins/tpm\n"
git clone https://github.com/tmux-plugins/tpm $TMUX_CONF_DIR/plugins/tpm

printf "[dotfiles-tmux] tmux installed successfully\n"
