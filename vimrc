" ============================================================
"                      — VIMRC FILE —
"
" The original .vimrc file is stored under ~/.vim directory.
" I use a symbolic link to link ~/.vimrc to this location.
"
" ============================================================

set nocompatible
filetype off


" =================================
" === VUNDLE PLUGINS MANAGEMENT ===
" =================================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'  " required
" --- Color schemes ---
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'w0ng/vim-hybrid'
Plugin 'crusoexia/vim-monokai'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'larssmit/vim-getafe'
Plugin 'abra/vim-abra'
Plugin 'zenorocha/dracula-theme', { 'rtp': 'vim/' }
Plugin 'raphamorim/lucario', { 'rtp': 'vim/' }
" --- Filetype related ---
Plugin 'slim-template/vim-slim'
" --- Plugins ---
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'techlivezheng/vim-plugin-minibufexpl'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular.git'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
" Plugin 'vim-bookmarks'
Plugin 'tpope/vim-repeat'
" Plugin 'Lokaltog/vim-easymotion'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/syntastic'
" Plugin 'jeetsukumaran/vim-markology'

call vundle#end()           " required
filetype plugin indent on   " required


" =======================
" === PLUGIN SETTINGS ===
" =======================

" <Leader> set to , instead of \
let mapleader = ","

" ----- indentLine -----
" Is deemed to solved some performance issues I sometimes encountered because
" of this plugin. Still in testing, I may have to remove the plugin
let g:indentLine_faster = 1

" ----- syntastic -----
" let g:syntastic_ruby_checkers = [ 'rubylint' ]

" ----- vim-bookmarks -----
" let g:bookmark_auto_save_file = '$HOME/.vim/bookmarks'
" nmap ff <Plug>BookmarkToggle
" nmap fj <Plug>BookmarkNext
" nmap fk <Plug>BookmarkPrev

" ----- vim-rspec -----
let g:rspec_runner = "os_x_iterm"
map <Leader>rsf :call RunCurrentSpecFile()<CR>
map <Leader>rsn :call RunNearestSpec()<CR>
map <Leader>rss :call RunLastSpec()<CR>
map <Leader>rsa :call RunAllSpecs()<CR>

" ----- Ctrlp -----
" Updates the file list only once the user stops typing
let g:ctrlp_lazy_update = 1
let g:ctrlp_custom_ignore = '\v[\/](\.git|.sass-cache|node_modules|tmp|log)$'
nmap <C-b> :CtrlPBuffer<CR>
imap <C-b> <ESC>:CtrlPBuffer<CR>
" Don't open files in plugin windows
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" Open multiple files in hidden buffers
" 0i: do not open any new tab or window, and open additionnal files in hidden buffers
let g:ctrlp_open_multiple_files = '0i'
let g:ctrlp_extensions = ['undo', 'changes', 'bookmarkdir']

" ----- vim commentary -----
nmap <leader>c gcc
vmap <leader>c gc

" ----- lightline.vim -----
" Mode is now displayed by ligthtline, no need to have Vim display it
set noshowmode
let g:lightline = {
      \   'colorscheme': 'wombat',
      \   'active': {
      \     'left':  [ ['mode'], ['fugitive', 'readonly', 'filename', 'modified'], ['ctrlpmark'] ],
      \     'right': [ ['lineinfo'], ['percent'], [ 'filetype' ] ]
      \   },
      \   'separator':    { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
      \   'component_function': {
      \     'filename':   'MyFilename',
      \     'fugitive':   'MyFugitive',
      \     'mode':       'MyMode',
      \     'readonly':   'MyReadOnly',
      \     'modified':   'MyModified',
      \     'ctrlpmark':  'CtrlPMark'
      \   },
      \   'component_visible_condition': {
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \   }
      \ }
function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction
function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
       \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != fname ? fname : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
       \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction
let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction
function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction



" ================
" === SETTINGS ===
" ================

syntax on
set ai
set number
set relativenumber
set undolevels=100
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set hidden          "buffer behavior (allow to switch to other buffer even if current has been modified)
set mouse=a         "enables mouse in all four modes (normal/visuel/insert/command-line)
set vb              "visual bell instead of audio
set encoding=utf-8
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=85
set foldcolumn=1    "always enable foldcolumn
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
set nrformats=      "interpret all digits as decimals (even when prefixed with 0)
" === HIDDEN/NON VISIBLE CHARS ===
set list
set listchars=tab:▸\ ,eol:¬
match Error /\%o240/   "associate non-unicode space with the Error class
" === INDENTATION ===
set sw=2
set ts=2    "number of spaces a TAB char counts for (when encountered in a file)
set sts=2   "number of spaces a TAB char counts for (when performing editing operations)
set et      "always use spaces instead of tabs
" === SEARCH AND REPLACE ===
set hlsearch
set gdefault    "global replaces as default
set incsearch   "show matchs as I type
" === STATUS LINE ===
set laststatus=2    "always display status line
" === LOAD/SAVE VIEWS ===
set viewoptions="cursor,fold"
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview
" === SPECIFIC SYNTAX HIGHLIGHTS ===
match Todo /debugger\|console.log\|binding.pry/
match Todo /REFACTOR/
" ====
set sessionoptions="buffers,curdir,folds,resize"



" ======================================
" ===   Delete trailing whitespace   ===
" === and weird mac alt+space spaces ===
" ======================================

function! StripTrailingWhitespaces()
  "1. Save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  "2. Do the business:
  %s/\s\+$//e
  "3. Clean up: restore search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! ReplaceNonUnicodeWhitespaces()
  " On Mac OS, typing alt+space insert a non-regular space character that's
  " not visible but can generate random errors. Let's replace them with
  " regular spaces on save
  "1. Save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  "2. Do the business:
  %s/\%o240/ /e
  "3. Clean up: restore search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWrite * :call StripTrailingWhitespaces()
autocmd BufWrite * :call ReplaceNonUnicodeWhitespaces()


" ===============================================
" === Open URIs with default Mac OS behaviour ===
" ===============================================
" FIXME: Doesn't work for md links because of parentheses

function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction

map <Leader>w :call HandleURI()<CR>



" ==============================
" === FILE SPECIFIC SETTINGS ===
" ==============================

" Specific filetype settings
autocmd BufRead,BufNewFile *.md     set ft=markdown
autocmd BufRead,BufNewFile *.todo   set ft=todo
autocmd BufRead,BufNewFile *.scss   set ft=scss
autocmd BufRead,BufNewFile *.sass   set ft=sass
autocmd BufRead,BufNewFile *.coffee set ft=coffee
autocmd BufRead,BufNewFile Gemfile* set ft=ruby

" Settings depending on filetype
autocmd FileType coffee       set commentstring=#\ %s
autocmd FileType haml         set commentstring=/\ %s
autocmd FileType slim         set commentstring=/\ %s
"
autocmd FileType coffee,sass  match Error /;/
" Removes all autocommands for BufEnter on commit messages (au!) and set
" cursor position on the first char
autocmd FileType gitcommit    au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
autocmd FileType gitcommit    set tw=80
autocmd FileType markdown     set sw=4 ts=4 sts=4 et wrap
autocmd FileType sass         match Error /\w:\S/

" ===============================
" === SHORTCUTS CONFIGURATION ===
" ===============================

" Personal <Leader> mappings
nnoremap <leader>vrc  :e $MYVIMRC<CR>
nnoremap <leader>s :w<CR>
" File explorer
nnoremap <leader>e :Explore<CR>
" Undo last search (to remove the highlighting)
nnoremap <leader>su :nohlsearch<CR>
" Copy current file name to the clipboard
nnoremap <leader>yf :let @+ = expand("%:p")<CR>

" Firefox-like buffer cycle behaviour
nmap <C-S-tab> :bp<cr>
imap <C-S-tab> <ESC>:bp<cr>i
nmap <C-tab> :bn<cr>
imap <C-tab> <ESC>:bn<cr>i
" Vim specific buffer cycle behaviour
nmap <C-l> :bn<cr>
imap <C-l> <esc>:bn<cr>
nmap <C-h> :bp<cr>
imap <C-h> <esc>:bp<cr>

" Move current line down/up
" <Alt-k>
vmap Ï :m .+1<CR>
nmap Ï :m .+1<CR>
" <Alt-j>
vmap È :m .-2<CR>
nmap È :m .-2<CR>


" Wrapping the current word
nmap " bi"<ESC>ea"<ESC>
" nmap ' bi'<ESC>ea'<ESC>
nmap ( bi(<ESC>ea)<ESC>

"Goes 1l up/down even with wrap enabled
nnoremap k gk
nnoremap j gj

" Abbreviations
iab bgrep background-repeat
iab bgcol background-color
iab bgpos background-position

" TODO: buffer delete to the right
" TODO: buffer delete to the left
" TODO: buffer delete all but current one



" =====================
" === GUI SETTINGS ====
" =====================

" vim-gitgutter : always good-looking gutter column
highlight clear SignColumn
autocmd ColorScheme * highlight clear SignColumn


" Default colorscheme
colorscheme IR_Black
set bg=dark

if has("gui_running")

  " Default GUI colorscheme
  let g:solarized_contrast="high"
  let g:solarized_visibility="low"
  set bg=dark
  colorscheme solarized


  set columns=120 lines=60
  set linespace=1           " +1px between lines

  if has('mac')
    set guifont=Inconsolata\ for\ Powerline:h14
    " set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline:h11
  elseif has('unix')
    set guifont=Inconsolata\ 11
  endif
endif

