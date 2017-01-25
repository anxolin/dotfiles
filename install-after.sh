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
sudo npm install -g standard


# Required for tern
cd ~/.vim/bundle/tern_for_vim
npm install

