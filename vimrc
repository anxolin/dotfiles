" **********s   BASIC CONFIG      **********

" Use Vim, vi is not compatible
set nocompatible              " be iMproved, required
filetype off                  " required

" UTF8 Encoding
set encoding=utf-8

" History
set history=80

" Enable line numbers
set number

" Enable syntax highlight and plugin support
syntax enable

" filetype: Enable plugin
"   * Detects the filetype (using the extension or the hashbang)
"   * Allows to hightlights depending on the filetype   
"   * Uses filetypes plugins depending on the language (cames with defaults
"     for common languages)
"   * Apply language specific idengt rules see :filetype-indent-on
filetype plugin on


" TempFiles: Change backup dir for .swp files
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

" Indentation without hard tabs
set expandtab
set shiftwidth=2
set softtabstop=2

" Vertical ruler at 80
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


" Identations for Python - PEP8
" au BufNewFile,BufRead *.py
"     \ set tabstop=4
"     \ set softtabstop=4
"     \ set shiftwidth=4
"     \ set textwidth=79
"     \ set expandtab
"     \ set autoindent
"     \ set fileformat=unix

" Identation for JS, HTML and CSS
" au BufNewFile,BufRead *.js, *.html, *.css
"     \ set tabstop=2
"     \ set softtabstop=2
"     \ set shiftwidth=2


" copy/paste integration
"   * in order to work vim must have been compiled with the clipboard flag
"       :echo has('clipboard')
"   * important, for working with tmux it's important to have 
"       reattach-to-user-namespace
set clipboard=unnamed

" Make backspace work like most other apps (allows to remove the <br> chars of
" the previous line)
set backspace=2 

" Activate mouse
set mouse=a

" Automatically jump to end of text you pasted:
"   This way you can paste many times with pppppp... 
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Use c-a and c-e for the "go-to begin/end" of the line in editing mode 
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I

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


" Spell: Enable spell suggestions
" set spelllang=en,es
set spell

" Enable wild menu: Display all matching options when we press tab (e.g. :find *.js) 
set wildmenu



" **********     LEADER and custom MAPPINGS     **********
" Set SPACE as the leader key
" let mapleader = "\<Space>"
let mapleader=" "


" Leader mappings:
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"   open a new file
nnoremap <Leader>o :CtrlP<CR>
"   save file
" nnoremap <Leader>w :w<CR>
"   Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Python"
""au FileType python setlocal expandtab textwidth=79 tabstop=8 softtabstop=4
au FileType python map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Quick way to move lines of text up or down (alt-j)
" Windows, Linux: Alt+jk
" https://unix.stackexchange.com/questions/73669/what-are-the-characters-printed-when-altarrow-keys-are-pressed
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv
" " Windows, Linux: Alt+Arrows
" nnoremap <A-Down> :m .+1<CR>==
" nnoremap <A-Up> :m .-2<CR>==
" inoremap <A-Down> <Esc>:m .+1<CR>==gi
" inoremap <A-Up> <Esc>:m .-2<CR>==gi
" vnoremap <A-Down> :m '>+1<CR>gv=gv
" vnoremap <A-Up> :m '<-2<CR>gv=gv
" " Mac: Alt+jk
" nnoremap ¶ :m .+1<CR>==
" nnoremap § :m .-2<CR>==
" inoremap ¶ <Esc>:m .+1<CR>==gi
" inoremap § <Esc>:m .-2<CR>==gi
" vnoremap ¶ :m '>+1<CR>gv=gv
" vnoremap § :m '<-2<CR>gv=gv

" Enter visual line mode 
"nmap <Leader><Leader> V

" Easymotion
map <Leader> <Plug>(easymotion-prefix)

" Use vim expand region with v key: /terryma/vim-expand-region
"   Use v for selecting a letter, vv to select a word, and so on...
"   Use c-v to decrese selection
"     The default was: + and _
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Bind K to :grep under the cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Ignore case by default when searching
set ignorecase

" Search: Hightlight increasilly while typing
set incsearch

" Highlight a word on double click (also using *)
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


" *******  Plugins *************

" Plugin that jumps to the matching HTML tag or if/else/elseif using %
packadd! matchit

" Vundle: let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Autoread: Enables autoread (reload the file if it has changed autside)
"Plugin 'djoshea/vim-autoread'
"Plugin 'Carpetsmoker/auto_autoread.vim'

" Syntastic: Lintern
" Plugin 'vim-syntastic/syntastic'
" Disabled to try w0rp/ale since vim8 upgrade

" w0rp/ale
Plugin 'w0rp/ale'

" Solarized: Colors - Solarized Theme (related conf in plugin conf section)
Plugin 'altercation/vim-colors-solarized'

" Javascript:  syntax highlighting and improved indentation.
"Plugin 'pangloss/vim-javascript'

" Javascript Tern: tern_for_vim: Tern is a stand-alone code-analysis engine
"    :TernDef: Jump to the definition of the thing under the cursor.
"    :TernDoc: Look up the documentation of something.
"    :TernType: Find the type of the thing under the cursor.
"    :TernRefs: Show all references to the variable or property under the cursor.
"    :TernRename: Rename the variable under the cursor.
Plugin 'ternjs/tern_for_vim'

" Taglist: List of tags in the current file
"     http://vim-taglist.sourceforge.net/
"Plugin 'taglist.vim': https://github.com/majutsushi/tagbar/wiki
"     Javascript: jsctags (depends on Tern) 
Plugin 'majutsushi/tagbar'

" Jsbeautifier: Format JS, HTML and CSS with jsbeautifier
Plugin 'maksimr/vim-jsbeautify'

" Format: vim-autoformat: Formats using any external formatter
Plugin 'Chiel92/vim-autoformat'

" Python
"Plugin 'nvie/vim-flake8'

" Scala: scala integration - https://github.com/derekwyatt/vim-scala
"     :SortScalaImports - Sorting of import statements
Plugin 'derekwyatt/vim-scala'


" Fugitive: Git - Vim Fugitive:
" 	https://docs.google.com/document/d/1sySUYHuHQO3yBRjIxshIg5_qkkVMq0DXjR4qQLG_Wr4/edit
Plugin 'tpope/vim-fugitive'

" Airline: Status bar - Vim Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Ctrlp: Ctrl+p - ctrlp.vim - Open files by name
Plugin 'ctrlpvim/ctrlp.vim'

" Ctrlp: Extension to allow to delete open buffers (ctrlp_bdelete)
Plugin 'j5shi/ctrlp_bdelete.vim'

" NerdTree: File explorer
Plugin 'scrooloose/nerdtree'

" Autocomplete: Youcompleteme:
"   Multilingual code-completion, goTo declaration, view documentation, rename variables
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'

" Ternjs: Javascript editting support,  Jump to the definitio, Look up the
" 	documentation,  Find the type of the thing under the cursor, references to the variable
"	Rename the variable
" Plugin 'ternjs/tern_for_vim'

" Async run: skywind3000/asyncrun.vim
Plugin 'skywind3000/asyncrun.vim'

" Vim expand region: Allows to selects blocks of code and increase the
" selection to next block easily
Plugin 'terryma/vim-expand-region'

" Move fast using <leader> <leader>
Plugin 'easymotion/vim-easymotion'

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
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
silent! colorscheme solarized


" Disable the formatting to test 'Chiel92/vim-autoformat'
" " C-f vim-jsbeautify: HTML, CSS, JS formatter
" autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
" autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
" autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
" autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
" autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

" Format: Formats using configurable external formatters: Chiel92/vim-autoformat
"     c-f                       Auto format
"     gg=G                      manually autoindent
"     :retab                    retab
"     :RemoveTrailingSpaces     remove trailing whitespace
"noremap <c-f> :Autoformat<CR>
noremap <c-f> gg=G``
let g:formatter_yapf_style = 'pep8'
" let g:autoformat_autoindent = 0
" let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" Tern: tern mappings
nnoremap <silent> <F2> :TernRefs<CR>
nnoremap <silent> <F3> :TernDef<CR>


" " Lintern - syntastic config
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" let g:syntastic_javascript_checkers = ['standard']
" "nnoremap <C-L> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
" nnoremap <C-L> :SyntasticCheck<CR>
" nnoremap <C-L><C-L> :SyntasticReset<CR>
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 

" Ale lintern
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

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

" Ctrlp: Close open bufferes extension by j5shi/ctrlp_bdelete
"   Select the buffer and close it with ctrl-2 (also works with ctrl-z multi
"   selection)
call ctrlp_bdelete#init()


" Ctrlp: Open files by name
let g:ctrlp_map = '<c-p>' " Map ctr+p key to ctrlp
let g:ctrlp_cmd = 'CtrlP'

" Ctrlp: Open with ctrl-b the buffers
map <c-b> :CtrlPBuffer<CR>

" Ctrlp: Ignore .gitignore files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_user_command = [
    \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f'
    \ ]


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


" " Quick run via <F5>
" nnoremap <F5> :call <SID>compile_and_run()<CR>
" augroup SPACEVIM_ASYNCRUN
"     autocmd!
"     " Automatically open the quickfix window
"     autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
" augroup END
" 
" function! s:compile_and_run()
"     exec 'w'
"     if &filetype == 'c'
"         exec "AsyncRun! gcc % -o %<; time ./%<"
"     elseif &filetype == 'cpp'
"        exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
"     elseif &filetype == 'java'
"        exec "AsyncRun! javac %; time java %<"
"     elseif &filetype == 'sh'
"        exec "AsyncRun! time bash %"
"     elseif &filetype == 'python'
"        exec "AsyncRun! time python %"
"     endif
" endfunction


" Easy motion config ------------
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <leader>2 <Plug>(easymotion-overwin-f2)

" Open search box
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" TODOS:
"     - Find and replace: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"
