"  **********   BASIC CONFIG      **********

" Use Vim, vi is not compatible
set nocompatible              " be iMproved, required
filetype off                  " required

" UTF8 Encoding
set encoding=UTF-8

" History
set history=80

" Enable line numbers
set number

" Do not wrap lines and when scroll horilzontally, show 25 chars of context
set nowrap
set sidescroll=25

" If we are in the:
"   - last char and press `l` (or right arrow) we jump to next line's first char
"   - first char and press `h` (or left arrow) we jump to the previous last
"     char
"   - IMPORTANT: Some people recommend against using the 'h' and 'l' also.
"     this for breaking some plugin no sure why, so I'll leave it as a test :)
set whichwrap=b,s,<,>,[,],h,l

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

" Set 2 spaces for tabs
set ts=2

" Spaces instead of tabs
set expandtab
set shiftwidth=2
set softtabstop=2

if has("gui_running")
  set linespace=6
endif

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
set backspace=indent,eol,start

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
" The next lines are commented, because I wanted to use lead-P for ctrlp
" plugin, while I reasign ctrl-p to fzf files dialog
"nmap <Leader>p "+p
"nmap <Leader>P "+P
"vmap <Leader>p "+p
"vmap <Leader>P "+P

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


function HasPlugins(name)
  return isdirectory($HOME . '/dotfiles/vim/bundle/' . a:name)
endfunction

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

" If Vundle plugin is present
if HasPlugins('Vundle.vim')
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
  "     https://github.com/majutsushi/tagbar
  "Plugin 'taglist.vim': https://github.com/majutsushi/tagbar/wiki
  Plugin 'majutsushi/tagbar'

  " Jsbeautifier: Format JS, HTML and CSS with jsbeautifier
  Plugin 'maksimr/vim-jsbeautify'

  " Format: vim-autoformat: Formats using any external formatter
  Plugin 'Chiel92/vim-autoformat'

  " Solidity
  Plugin 'tomlion/vim-solidity'


  " Python
  "Plugin 'nvie/vim-flake8'

  " Scala: scala integration - https://github.com/derekwyatt/vim-scala
  "     :SortScalaImports - Sorting of import statements
  "Plugin 'derekwyatt/vim-scala'


  " Fugitive: Git - Vim Fugitive:
  "   https://docs.google.com/document/d/1sySUYHuHQO3yBRjIxshIg5_qkkVMq0DXjR4qQLG_Wr4/edit
  Plugin 'tpope/vim-fugitive'

  " Airline: Status bar - Vim Airline
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'

  " FLZ for vim
  "   fzf#install() makes sure that you have the latest binary, but it's optional, so you can omit it if you use a plugin manager that doesn't support hooks.
  Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plugin 'junegunn/fzf.vim'

  " Ctrlp: Ctrl+p - ctrlp.vim - Open files by name
  Plugin 'ctrlpvim/ctrlp.vim'

  " Ctrlp: Extension to allow to delete open buffers (ctrlp_bdelete)
  Plugin 'j5shi/ctrlp_bdelete.vim'

  " NerdTree: File explorer
  Plugin 'scrooloose/nerdtree'  

  " vim-nerdtree-syntax-highlight
  "   Meant to be use with vim-devicons. Adds better icons and colours
  Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

  " Autocomplete: Youcompleteme:
  "   Multilingual code-completion, goTo declaration, view documentation, rename variables
  "Plugin 'Valloric/YouCompleteMe'
  "Plugin 'davidhalter/jedi-vim'

  " Ternjs: Javascript editting support,  Jump to the definitio, Look up the
  "   documentation,  Find the type of the thing under the cursor, references to the variable
  " Rename the variable
  " Plugin 'ternjs/tern_for_vim'

  " Async run: skywind3000/asyncrun.vim
  Plugin 'skywind3000/asyncrun.vim'

  " Vim expand region: Allows to selects blocks of code and increase the
  " selection to next block easily
  Plugin 'terryma/vim-expand-region'

  " Move fast using <leader> <leader>
  Plugin 'easymotion/vim-easymotion'

  " Vim-devicons: 
  "   IMPORTANT: Needs to go last
  "   Add nice icons to NERDTree, vim-airline, CtrlP, powerline, 
  "   denite, unite, lightline.vim, vim-startify, vimfiler, vim-buffet and flagship.
  Plugin 'ryanoasis/vim-devicons'

  " *******  Key mappings *************
  " [command: w!!] Allow to gain root permission within vim
  cmap w!! w !sudo tee >/dev/null %

  " *******  Load Vundle Plugins  *************
  " All of your Plugins must be added before the following line
  call vundle#end()            " required
  filetype plugin indent on    " required
endif



" *******  Plugin Configuration *************

" Solarized Theme - config
set background=dark
" let g:solarized_termcolors=256 " If you are going to use Solarized in Terminal mode
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
silent! colorscheme solarized

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



" NerdTree conf
if HasPlugins('nerdtree')
  " Bind C-n key to NerdTree
  map <C-n> :NERDTreeToggle<CR>
  map <C-m> :NERDTreeFind<CR>
  
  " Show file always in tree automatically 
  "autocmd BufWinEnter * NERDTreeFind
  
  " Open nerd tree as an only window, with the current file
  " selected
  fun! NewTreeOpen()
    NERDTreeFind
    wincmd o
    let g:NERDTreeQuitOnOpen=1
  endfun
  nmap <silent><leader>no :call NewTreeOpen()<CR>
endif

" Tern: tern mappings
if HasPlugins('tern_for_vim')
  nnoremap <silent> <F2> :TernRefs<CR>
  nnoremap <silent> <F3> :TernDef<CR>
endif

" Ale lintern (https://github.com/w0rp/ale)
if HasPlugins('ale')
  "let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
  nmap <silent> <C-k> <Plug>(ale_previous_wrap)
  nmap <silent> <C-j> <Plug>(ale_next_wrap)
endif

" " Lintern - syntastic config (disable to use Ale instead)
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

" Tagbar: Display tags in a window
"   https://github.com/majutsushi/tagbar
if HasPlugins('tagbar')
  nmap <F8> :TagbarToggle<CR>
endif

" Git - Fugitive - config
if HasPlugins('vim-fugitive')
  " set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
endif

" Status bar - Vim airline conf
if HasPlugins('vim-airline')
  set laststatus=2 "  Solution for vim-airline doesn't appear until I create a new split problem
  let g:airline_theme='solarized'
  " :AirlineTheme simple
  " let g:airline#extensions#tabline#enabled = 1  " displays all buffers when there's only one tab open

  " Status line
  "   http://got-ravings.blogspot.com.es/2008/08/vim-pr0n-making-statuslines-that-own.html
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
endif

" ctrlp_bdelete: Close open bufferes extension by j5shi/ctrlp_bdelete
"   https://github.com/d11wtq/ctrlp_bdelete.vim
if HasPlugins('ctrlp_bdelete.vim')
  "   Select the buffer and close it with ctrl-2 (also works with ctrl-z multi
  "   selection)
  call ctrlp_bdelete#init()
endif

" Ctrlp: Open files by name
if HasPlugins('ctrlp.vim')
  let g:ctrlp_map =  '<c-p>' "     Map ctr+p key to ctrlp (will be overrided by fzf below)
  let g:ctrlp_map =  '<leader>p' " Map <leader>+p key to ctrlp
  let g:ctrlp_cmd = 'CtrlP'

  " Ctrlp: Open with ctrl-b the buffers (will be overrided by fzf below)
  map <c-b> :CtrlPBuffer<CR>

  " Ctrlp: Open with ctrl-p (will be overrided by fzf below)
  map <c-p> :CtrlP<CR>

  " Ctrlp: Ignore .gitignore files
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  let g:ctrlp_user_command = [
      \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
      \ 'find %s -type f'
      \ ]
endif


" FZF config
"   fzf provides fuzzy search menus for buffers and files
"   Uses fzf bin, the fzf.vim plugin, and some hack function to add images
if executable('fzf')
  " fzf config
  map <leader>P :GFiles<CR>
  map <C-p> :Files<CR>
  map <C-b> :Buffers<CR>  

  if executable('devicon-lookup') 
    map <C-p> :call FZFWithDevIcons()<CR>

    " Small hack for adding icons to fzf
    "   - fzf for now doesn't have a  dev-icons integration
    "   - The code below substitutes the :Files command
    function! FZFWithDevIcons()
      let l:fzf_files_options = ' -m --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview "bat --color always --style numbers {2..}"'

      function! s:files()
        let l:files = split(system($FZF_DEFAULT_COMMAND.'| devicon-lookup'), '\n')
        return l:files
      endfunction

      function! s:edit_file(items)
        let items = a:items
        let i = 1
        let ln = len(items)
        while i < ln
          let item = items[i]
          let parts = split(item, ' ')
          let file_path = get(parts, 1, '')
          let items[i] = file_path
          let i += 1
        endwhile
        call s:Sink(items)
      endfunction

      let opts = fzf#wrap({})
      let opts.source = <sid>files()
      let s:Sink = opts['sink*']
      let opts['sink*'] = function('s:edit_file')
      let opts.options .= l:fzf_files_options
      call fzf#run(opts)
    endfunction
  endif
endif

" Easy motion (https://github.com/easymotion/vim-easymotion)
if HasPlugins('vim-easymotion')
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
endif

" Disable the formatting to test 'Chiel92/vim-autoformat'

" vim-jsbeautify: HTML, CSS, JS formatter
if HasPlugins('vim-autoformat')
  " Format: Formats using configurable external formatters: Chiel92/vim-autoformat
  "     c-f                       Auto format
  "     gg=G                      manually autoindent
  "     :retab                    retab
  "     :RemoveTrailingSpaces     remove trailing whitespace
  noremap <c-f> gg=G``
  let g:formatter_yapf_style = 'pep8'
endif

" TODOS:
"     - Find and replace: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"
