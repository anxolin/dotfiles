#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
dir=~/dotfiles                    # dotfiles directory
timeStamp=$(date +%F_%R)
olddir=~/dotfiles/backup/backup_$timeStamp             # old dotfiles backup directory
# list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
printf "[dotfiles] Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# Create Vim backupo dir for swap, backup and undo files
mkdir -p ~/.vim/{backup_files,swap_files,undo_files}

# Configure Vim Vundle
git clone https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim

# Dot files install:
#   1. Backup: Move any existing dotfiles to dotfiles_old directory
#   2. Symlink: Create symlinks in the homedir pointing to the dotfile
printf "[dotfiles] Backup all current dotfiles to $olddir'\n"
while read file; do
  mv ~/.$file $olddir
  printf "[dotfiles-$file] Creating symlink'\n"
  ln -s $dir/$file ~/.$file
done < dotfiles.list

install () {
	printf "[dotfiles] Installing all the required software\n"

    # Required software:
    #   - All platforms:
    #         * zsh
    #         * vim
    #         * ag (the silver searcher): Use it to search faster. Replace for ACK
    #         * ctags: Generate tags from code for junToDefinition functionalities
    #         * cmake: Required by you complete me
    #   - Linux
    #         * xclip: Allows to share the clipboard between tmux and the X's
    #   - Mac (Darwin)
    #         * reattach-to-user-namespace: Required for tmux copy-paste integration
    #

    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    printf "[dotfiles] *** Architecture: $platform***\n"
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh vim silversearcher-ag xclip ctags cmake
        fi
 	      if [[ -f /etc/arch-release ]]; then
            sudo pacman -S zsh vim the_silver_searcher xclip ctags cmake
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
		    brew install zsh the_silver_searcher ctags reattach-to-user-namespace cmake
        exit
    fi

	# Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi

    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(printf $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
}

install
