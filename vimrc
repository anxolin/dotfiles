" a******  BASIC VUNDLE CONFIG *************
" Use Vim, vi is not compatible
set nocompatible              " be iMproved, required
filetype off                  " required

" Enable syntax highlight and plugin support
syntax enable
filetype plugin on

" Activate mouse
set mouse=a

" Autoread: Detect changes done by external applications
set autoread
" TODO: Make vim notice automatically if an external app has changed the file
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-events
" |VimResized|    after the Vim window size changed
" |FocusGained|   Vim got input focus
" |FocusLost|   Vim lost input focus
" |CursorHold|    the user doesn't press a key for a while
" |CursorHoldI|   the user doesn't press a key for a while in Insert mode
" |CursorMoved|   the cursor was moved in Normal mode
" |CursorMovedI|    the cursor was moved in Insert mode
" |WinEnter|    after entering another window
" |WinLeave|    before leaving a window
" |TabEnter|    after entering another tab page
" |TabLeave|    before leaving a tab page
" |CmdwinEnter|   after entering the command-line window
" |CmdwinLeave|   before leaving the command-line 


" TempFiles: Change backup dir for .swp files
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" Indentation without hard tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" copy/paste integration
set clipboard=unnamed

" Spell: Enable spell suggestions
" set spelllang=en,es
set spell

" Enable wild menu: Display all matching options when we press tab (e.g. :find *.js) 
set wildmenu

" Bind K to :grep under the cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Highlight a word on double click
map <2-LeftMouse> :set hlsearch<CR>*
imap <2-LeftMouse> :set hlsearch<CR><c-o>*
set hlsearch
nnoremap <F3> :set hlsearch!<CR>

" Maketags: Use ctags generate app to
command! Maketags !ctags -R .

" SNIPPETS:
"   Read an empty HTML template and move cursor to title
" nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" Vundle: Plugin manager
"   Brief help
"     :PluginList       - lists configured plugins
"     :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"     :PluginSearch foo - searches for foo; append `!` to refresh local cache
"     :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
"   see :h vundle for more details or wiki for FAQ
"   Put your non-Plugin stuff after this line
"
" Vundle installation: set the runtime path to include Vundle and initialize
set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" Vundle: let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Autoread: Enables autoread (reload the file if it has changed autside)
"Plugin 'djoshea/vim-autoread'
"Plugin 'Carpetsmoker/auto_autoread.vim'

" Syntastic: Lintern
Plugin 'vim-syntastic/syntastic'

" *******  Plugins *************
" Solarized: Colors - Solarized Theme (related conf in plugin conf section)
Plugin 'altercation/vim-colors-solarized'

" Javascript:  syntax highlighting and improved indentation.
"Plugin 'pangloss/vim-javascript'

" Javscript Tern: tern_for_vim: Tern is a stand-alone code-analysis engine
"  for JS
"Plugin 'marijnh/tern_for_vim'
Plugin 'ternjs/tern_for_vim'

" Taglist: List of tags in the current file
"     http://vim-taglist.sourceforge.net/
"Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'

" Jsbeautifier: Format JS, HTML and CSS with jsbeautifier
Plugin 'maksimr/vim-jsbeautify'

" Fugitive: Git - Vim Fugitive:
" 	https://docs.google.com/document/d/1sySUYHuHQO3yBRjIxshIg5_qkkVMq0DXjR4qQLG_Wr4/edit
Plugin 'tpope/vim-fugitive'

" Airline: Status bar - Vim Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Ctrlp: Ctrl+p - ctrlp.vim - Open files by name
Plugin 'ctrlpvim/ctrlp.vim'

" NerdTree: File explorer
Plugin 'scrooloose/nerdtree'

" Youcompleteme:
"   Multilingual code-completion, goTo declaration, view documentation, rename variables
"   Plugin 'Valloric/YouCompleteMe'

" Ternjs: Javascript editting support,  Jump to the definitio, Look up the
" 	documentation,  Find the type of the thing under the cursor, references to the variable
"	Rename the variable
" Plugin 'ternjs/tern_for_vim'


" *******  Key mappings *************
" [command: w!!] Allow to gain root permission within vim
cmap w!! w !sudo tee >/dev/null %



" *******  Load Vundle Plugins  *************
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" *******  Plugin Configuration *************
" NerdTree conf
" 	auto-open on startup
"autocmd vimenter * NERDTree
"	auto-open if there are no files
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"	How can I open NERDTree automatically when vim starts up on opening a directory?
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"	Bind C-n key to NerdTree
map <C-n> :NERDTreeToggle<CR>


" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
" 	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
" 	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction
"
" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')



" Solarized Theme - config
set background=dark
" let g:solarized_termcolors=256 " If you are going to use Solarized in Terminal mode
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized


" Javascript:  syntax highlighting and improved indentation.
" 			   pangloss/vim-javascript'
"	Enable JSDocs (http://usejsdoc.org)
"let g:javascript_plugin_jsdoc = 1
"	Enables syntax highlighting for Flow (https://flowtype.org)
"let g:javascript_plugin_flow = 1
"	Enables code folding based on our syntax file.
" set foldmethod=syntax
" Identention
" :h cino-:
" :h 'indentkeys
"call togglebg#map("<F5>")

" vim-jsbeautify: HTML, CSS, JS formatter
autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" Lintern - syntastic config
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_javascript_checkers = ['standard']
"nnoremap <C-L> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
nnoremap <C-L> :SyntasticCheck<CR>
nnoremap <C-L><C-L> :SyntasticReset<CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" tagList: List all tags in a window
"   :TlistOpen
"nnoremap <silent> <F8> :TlistToggle<CR>
"let Tlist_GainFocus_On_ToggleOpen = 1

" Tagbar: tags for majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>


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


" Ctrp - Open files by name
let g:ctrlp_map = '<c-p>' " Map ctr+p key to ctrlp
let g:ctrlp_cmd = 'CtrlP'
"   Ignore .gitignore files
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_user_command = [
"     \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
"     \ 'find %s -type f'
"     \ ]


" " Change colors for ctrl-p cursor
" let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }
" function BrightHighlightOn()
"   hi CursorLine guibg=darkred
" endfunction
"
" function BrightHighlightOff()
"   hi CursorLine guibg=#191919
" endfunction

" Use ag instead of grep, in the :grep command
if executable('ag')
  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>


  " Use ag (the_silver_searcher) instead of ack
  let g:ackprg = 'ag --vimgrep'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
   let g:ctrlp_user_command = [
      \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
      \ 'ag %s -l --nocolor -g ""'
      \ ]

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif



