" *******  BASIC VUNDLE CONFIG *************
let g:solarized_termcolors=16
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}


" *******  Plugins *************

" Colors - Solarized Theme (related conf in plugin conf section)
Plugin 'altercation/vim-colors-solarized'

" Git - Vim Fugitive: 
" 	https://docs.google.com/document/d/1sySUYHuHQO3yBRjIxshIg5_qkkVMq0DXjR4qQLG_Wr4/edit
Plugin 'tpope/vim-fugitive'

" Status bar - Vim Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Ctrl+p - ctrlp.vim - Open files by name
Plugin 'ctrlpvim/ctrlp.vim'

" *******  Key mappings *************
" [command: w!!] Allow to gain root permission within vim
cmap w!! w !sudo tee >/dev/null %



" *******  Load Vundle Plugins  *************
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" *******  Plugin Configuration *************

" Solarized Theme - config
syntax enable
set background=dark
" let g:solarized_termcolors=256 " If you are going to use Solarized in Terminal mode
colorscheme solarized
"call togglebg#map("<F5>")


" Git - Fugitive - config
" set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}


" Status line
" 	http://got-ravings.blogspot.com.es/2008/08/vim-pr0n-making-statuslines-that-own.html
" set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
" set statusline=%t       "tail of the filename
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] "file format
" set statusline+=%h      "help file flag
" set statusline+=%m      "modified flag
" set statusline+=%r      "read only flag
" set statusline+=%y      "filetype
" set statusline+=%=      "left/right separator
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file


" Status bar - Vim airline conf
set laststatus=2 "  Solution for vim-airline doesn't appear until I create a new split problem
let g:airline_theme='solarized'
" :AirlineTheme simple
" let g:airline#extensions#tabline#enabled = 1  " displays all buffers when there's only one tab open

" Ctrp - Open files by name -  confi
let g:ctrlp_map = '<c-p>' " Map ctr+p key to ctrlp
let g:ctrlp_cmd = 'CtrlP'


