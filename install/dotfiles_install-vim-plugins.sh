#!/bin/bash
set -e

# Vundle Install: Intall vim plugins
echo "[dotfiles-install-vim-plugins] Installing Vim plugins using Vundle (it can take some time)..."
vim +PluginInstall +qall

# Install fzf from sources
if [[ `which node &>/dev/null && $?` == 0 ]]; then
  echo "Install CoC Typescript server"
  vim -c "CocInstall coc-tsserver"
fi

# # vim-jsbeautify (https://github.com/maksimr/vim-jsbeautify)
# #   - Quickly format javascript, html and css files
# #   - Supports the editorconfig file
# echo "[dotfiles-install-vim-plugins] Initialize the vim-jsbeautify submodules"
# cd ~/.vim/vundle/vim-jsbeautify
# git submodule update --init --recursive

# # You completme
# #   - Autocomplete for VIM
# if [ -d ~/.vim/vundle/YouCompleteMe ]; then
#   echo "[dotfiles-install-vim-plugins] Install YouCompleteMe"
#   cd ~/.vim/vundle/YouCompleteMe && ./install.sh || true
# else 
#   echo "WARN: YouCompleteMe was not installed cause it was not found in ~/.vim/vundle/YouCompleteMe (probably was disabled in vimrc, ignore if it's the case)"
# fi


# # Syntastic:
# #   - Syntastic depends on some linterns that must be installed separatelly
# #   - JS: standard (https://standardjs.com)
# #   - SASS: sass-lint (https://github.com/sasstools/sass-lint)
# #   - JSON: jsonlint (https://github.com/zaach/jsonlint)
# #   - CSS: stylelint (https://github.com/stylelint/stylelint)
# #   - PYTHON: flake8 (http://flake8.pycqa.org/en/latest)
# echo "[dotfiles-install-vim-plugins] Install Syntastic linterns: JS, SASS, JSON, CSS, PYTHON"
# if ! type npm > /dev/null; then
#   echo "[dotfiles-install-vim-plugins] WARNING: NPM is missing, so JS, SASS, JSON, CSS linterns for Syntastic could not be installed "
# else
#   sudo npm install -g standard sass-lint jsonlint stylelint || true
# fi

# # Flake8: Lintern for Python (used also by syntastic)
# if ! type python3 > /dev/null; then
#   echo "[dotfiles-install-vim-plugins] WARNING: python3 is missing, so the PYTHON lintern for Syntastic could not be installed "
# else
#   python3 -m pip install flake8 || true
# fi

# # Tern for Vim (https://github.com/ternjs/tern_for_vim)
# #   - Tern-based JavaScript editing support
# #   - Go to definition, documentation, find references and rename
# echo "[dotfiles-install-vim-plugins] Install tern for vim (for 'go to definition' functionality for JS)"
# cd ~/.vim/vundle/tern_for_vim
# npm install || true

# # jsctags (https://github.com/ramitos/jsctags)
# #   - Better ctags fot JS
# #   - It's used by majutsushi/tagbar
# echo "[dotfiles-install-vim-plugins] Install jsctags (JS ctags required by majutsushi/tagbar)"
# if ! type npm > /dev/null; then
#   echo "[dotfiles-install-vim-plugins] WARNING: NPM is missing, so jsctags could not be installed (used by majutsushi/tagbar) "
# else
#   sudo npm install -g git+https://github.com/ramitos/jsctags.git || true
# fi

# Install NPM Completion for ZSH
# if git --version &>/dev/null; then
#   echo "Install NPM Completion for ZSH"
#   git clone https://github.com/lukechilds/zsh-better-npm-completion ~/dotfiles/zsh-custom/plugins/zsh-better-npm-completion
# else 
#   echo "WARN: NPM Completion for ZSH cannot be installed because git is not available"
# fi
