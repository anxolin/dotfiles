" See NeoVim Help Options
"     https://neovim.io/doc/user/options.html
" 
" Some directories
"   ~/.local/share/nvim/


set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/dotfiles/vimrc

" See provider-python and provider-clipboard for additional software you
" might need to use some features.

" See vim differences