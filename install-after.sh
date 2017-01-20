#!/bin/bash
############################i#####################################
# This script initialize the Vim modules that require extra steps 
##################################################################

# vim-jsbeautify 
echo "Initialize the vim-jsbeautify submodules"
cd ~/.vim/bundle/vim-jsbeautify
git submodule update --init --recursive


