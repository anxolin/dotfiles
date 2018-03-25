#!/bin/bash
set -e

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

# dotfiles directory
DOT_FILES=~/dotfiles
cd $DOT_FILES

########## Variables
TIME_STAMP=$(date +%F_%R)
BACKUP_DIR=~/dotfiles/backup/backup_$TIME_STAMP             # old dotfiles backup directory
# list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
printf "[dotfiles-backup] Creating backup dir '$BACKUP_DIR'\n"
mkdir -p $BACKUP_DIR

# Dot files install:
#   1. Backup: Copy any existing dotfiles to dotfiles_old directory
#   2. Symlink: Create symlinks in the homedir pointing to the dotfile
printf "[dotfiles-backup] Backup all current dotfiles to $BACKUP_DIR'\n"
while read FILE; do
  cp -r ~/.$FILE $BACKUP_DIR
done < dotfiles.list
