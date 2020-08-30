#!/bin/bash
set -e

# Brew dependencies
# brew install zsh the_silver_searcher ctags reattach-to-user-namespace cmake
brew_dependencies=( zsh the_silver_searcher ctags reattach-to-user-namespace cmake )
for package in "${brew_dependencies[@]}"
do  
  if brew ls --versions myformula > /dev/null; then
	  echo "Installing $package with brew..."
    brew install $package
  else
    echo "$package is already installed"
  fi
done

# Install fzf
if [[ `which fzf &>/dev/null && $?` != 0 ]]; then  
  source ~/dotfiles/install/install-fzf.sh
fi
