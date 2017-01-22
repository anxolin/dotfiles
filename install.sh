#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
dir=~/dotfiles                    # dotfiles directory
timeStamp=$(date +%F_%R)
olddir=~/dotfiles/backup/backup_$timeStamp             # old dotfiles backup directory
files="bashrc vimrc vim zshrc oh-my-zsh tmux.conf editorconfig gitconfig"    # list of files/folders to symlink in homedir
#files="bashrc vimrc vim zshrc oh-my-zsh private scrotwm.conf Xresources"

##########

# create dotfiles_old in homedir
printf "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
printf "done\n"

# change to the dotfiles directory
printf "Changing to the $dir directory ..."
cd $dir
printf "done\n"

# Create Vim backupo dir for swap, backup and undo files
mkdir -p ~/.vim/{backup_files,swap_files,undo_files}

# Configure Vim Vundle
git clone https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    printf "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    printf "Creating symlink to $file in home directory.\n"
    ln -s $dir/$file ~/.$file
done

install () {
	printf "Installing all the required software\n"

    # Required software:
    #   - All platforms: 
    #         * zsh
    #         * vim
    #         * ag (the silver searcher): Use it to search faster. Replace for ACK
    #         * ctags: Generate tags from code for junToDefinition functionalities
    #   - Linux
    #         * xclip: Allows to share the clipboard between tmux and the X's
    #   - Mac (Darwin)
    #         * reattach-to-user-namespace: Required for tmux copy-paste integration
    #        

    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    printf "*** Architecture: $platform***\n"
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh vim silversearcher-ag xclip ctags
        fi
 	      if [[ -f /etc/arch-release ]]; then
            sudo pacman -S zsh vim the_silver_searcher xclip ctags
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
		brew install zsh the_silver_searcher ctags reattach-to-user-namespace
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
