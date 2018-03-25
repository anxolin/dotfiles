#!/bin/bash
set -e

# dotfiles directory
DOT_FILES=~/dotfiles

PLATFORM=$(uname);
printf "[dotfiles] *** INSTALL DOT FILES ($PLATFORM) ***\n"

# Backup Dotfiles
source "$DOT_FILES/install/dotfiles_backup.sh"

# Wipe previous dotfiles and instal new ones
source "$DOT_FILES/install/dotfiles_wipe-and-install.sh"
if [[ $PLATFORM == 'Darwin' ]]; then
  # Visual Studio Code dotfiles is handled separately
  source "$DOT_FILES/install/dotfiles_wipe-and-install-visual-studio-mac.sh"
fi

# Install apps
#   TODO: Ask whether to install or not
if [[ $PLATFORM == 'Linux' ]]; then
  source "$DOT_FILES/install/install-apps_Linux.sh"
elif [[ $PLATFORM == 'Darwin' ]]; then
  source "$DOT_FILES/install/install-apps_Mac.sh"
fi

# Install vim plugins
source "$DOT_FILES/install/dotfiles_install-vim-plugins.sh"
