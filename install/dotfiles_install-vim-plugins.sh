#!/bin/bash
set -e

# Vundle Install: Intall vim plugins
echo "[dotfiles-install-vim-plugins] Installing Vim plugins using Vundle (it can take some time)..."
vim +PluginInstall +qall

# vim-jsbeautify (https://github.com/maksimr/vim-jsbeautify)
#   - Quickly format javascript, html and css files
#   - Supports the editorconfig file
echo "[dotfiles-install-vim-plugins] Initialize the vim-jsbeautify submodules"
cd ~/.vim/bundle/vim-jsbeautify
git submodule update --init --recursive

# You completme
#   - Autocomplete for VIM
echo "[dotfiles-install-vim-plugins] Install YouCompleteMe"
cd ~/.vim/bundle/YouCompleteMe && ./install.sh || true

# Syntastic:
#   - Syntastic depends on some linterns that must be installed separatelly
#   - JS: standard (https://standardjs.com)
#   - SASS: sass-lint (https://github.com/sasstools/sass-lint)
#   - JSON: jsonlint (https://github.com/zaach/jsonlint)
#   - CSS: stylelint (https://github.com/stylelint/stylelint)
#   - PYTHON: flake8 (http://flake8.pycqa.org/en/latest)
echo "[dotfiles-install-vim-plugins] Install Syntastic linterns: JS, SASS, JSON, CSS, PYTHON"
if ! type npm > /dev/null; then
  echo "[dotfiles-install-vim-plugins] WARNING: NPM is missing, so JS, SASS, JSON, CSS linterns for Syntastic could not be installed "
else
  sudo npm install -g standard sass-lint jsonlint stylelint || true
fi

# Flake8: Lintern for Python (used also by syntastic)
if ! type python3.6 > /dev/null; then
  echo "[dotfiles-install-vim-plugins] WARNING: python3 is missing, so the PYTHON lintern for Syntastic could not be installed "
else
  python3.6 -m pip install flake8 || true
fi

# Tern for Vim (https://github.com/ternjs/tern_for_vim)
#   - Tern-based JavaScript editing support
#   - Go to definition, documentation, find references and rename
echo "[dotfiles-install-vim-plugins] Install tern for vim (for 'go to definition' functionality for JS)"
cd ~/.vim/bundle/tern_for_vim
npm install || true

# # jsctags (https://github.com/ramitos/jsctags)
# #   - Better ctags fot JS
# #   - It's used by majutsushi/tagbar
# echo "[dotfiles-install-vim-plugins] Install jsctags (JS ctags required by majutsushi/tagbar)"
# if ! type npm > /dev/null; then
#   echo "[dotfiles-install-vim-plugins] WARNING: NPM is missing, so jsctags could not be installed (used by majutsushi/tagbar) "
# else
#   sudo npm install -g git+https://github.com/ramitos/jsctags.git || true
# fi

# Install NPM Completion
if git --version &>/dev/null; then
  git clone https://github.com/lukechilds/zsh-better-npm-completion.git ~/.zsh-better-npm-completion
fi