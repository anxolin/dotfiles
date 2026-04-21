#!/bin/bash
set -e

###############################################################################
# dotfiles_backup.sh — copy current home-side dotfiles into ~/dotfiles/backup/
# and prune old backups so the dir doesn't grow unbounded.
###############################################################################

DOT_FILES=~/dotfiles
cd "$DOT_FILES"

TIME_STAMP=$(date +%F_%R)
BACKUP_BASE=~/dotfiles/backup
BACKUP_DIR="$BACKUP_BASE/backup_$TIME_STAMP"
KEEP=10  # how many backups to retain per prefix (backup_, nvim_, tmux_)

# --- 1. Snapshot current home-side dotfiles
printf "[dotfiles-backup] Creating backup dir '%s'\n" "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

printf "[dotfiles-backup] Backing up current dotfiles to %s\n" "$BACKUP_DIR"
while read FILE; do
  # dotfiles.list entries can be paths (e.g. "zsh/zshrc"); the home-side
  # file uses just the basename (e.g. ~/.zshrc).
  TARGET=".$(basename "$FILE")"
  cp -rf "$HOME/$TARGET" "$BACKUP_DIR" 2>/dev/null || :
done < dotfiles.list

# --- 2. Retention: keep only the most recent $KEEP backups per prefix.
# Backups are created by different install scripts with these prefixes.
for prefix in backup nvim tmux; do
  # -1t: one-per-line sorted by mtime, newest first.
  # tail -n +$((KEEP + 1)): everything beyond the KEEP most recent.
  ls -1t "$BACKUP_BASE" 2>/dev/null | grep "^${prefix}_" | tail -n +$((KEEP + 1)) | while read old; do
    rm -rf "$BACKUP_BASE/$old"
  done
done

printf "[dotfiles-backup] Retention policy applied (keep last %d per prefix)\n" "$KEEP"
