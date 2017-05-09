#!/bin/bash
############################i#####################################
# This script initialize the Vim modules that require extra steps 
##################################################################

# vim-jsbeautify 
echo "Initialize the vim-jsbeautify submodules"
cd ~/.vim/bundle/vim-jsbeautify
git submodule update --init --recursive


# Standard Lintern - Used by Syntastic
# IMPORTANT: It asumes that npm is installed
sudo npm install -g standard sass-lint jsonlint stylelint

# Lintern for Python: Flake8
#python3.6 -m pip install flake8
echo "You should also install flake8. ex.  python3.6 -m pip install flake8"


# Required for tern
cd ~/.vim/bundle/tern_for_vim
npm install

# jsctags: Is a better ctags fot JS. It's used by majutsushi/tagbar
sudo npm install -g git+https://github.com/ramitos/jsctags.git

