" ============================================================
"                   — NEOVIMRC FILE —
"
" The original .vimrc file is stored under ~/.vim directory.
" I use a symbolic link to link ~/.vimrc to this location.
"
" ============================================================

filetype off


" =================================
" === VUNDLE PLUGINS MANAGEMENT ===
" =================================

" set the runtime path to include Vundle and initialize
" set rtp="$HOME/.nvim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.nvim/after"
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin('~/.config/nvim/bundle')
Plugin 'gmarik/Vundle.vim'  " required

" --- Color schemes ---
Plugin 'morhetz/gruvbox'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'zenorocha/dracula-theme', { 'rtp': 'vim/' }
Plugin 'KabbAmine/yowish.vim'
Plugin 'GertjanReynaert/cobalt2-vim-theme'
Plugin 'joshdick/onedark.vim'
Plugin 'jdkanani/vim-material-theme'
Plugin 'Wutzara/vim-materialtheme'
Plugin 'vivkin/flatland.vim'
Plugin 'MaxSt/FlatColor'
Plugin 'raphamorim/lucario', { 'rtp': 'vim/' }
" Plugin 'zeis/vim-kolor'
" Plugin 'chriskempson/vim-tomorrow-theme'
" Plugin 'edubxb/vim-getafe'
" Plugin 'mkarmona/colorsbox'
" Plugin 'w0ng/vim-hybrid'
" Plugin 'mhartington/oceanic-next'
" Plugin 'nanotech/jellybeans.vim'
" Plugin 'freeo/vim-kalisi'
" Plugin 'ashton/.vim'
" Plugin 'larssmit/vim-getafe'
" --- Filetype related ---
Plugin 'tpope/vim-haml'
Plugin 'slim-template/vim-slim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/javascript-libraries-syntax.vim'
" --- Plugins ---
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'techlivezheng/vim-plugin-minibufexpl'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular.git'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'Raimondi/delimitMate'
Plugin 'terryma/vim-multiple-cursors'
" Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/syntastic'
Plugin 'jacquesbh/vim-showmarks'
Plugin 'janko-m/vim-test'
Plugin 'AndrewRadev/splitjoin.vim'

call vundle#end()           " required
filetype plugin indent on   " required


" =======================
" === PLUGIN SETTINGS ===
" =======================

" <Leader> set to , instead of \
let mapleader = ","

" ----- ack.vim -----
" Map Ack command to Ack! automatically so that it doesn't open first item by default
ca Ack Ack!
ca ack Ack!

" ----- vim-gitgutter -----
let g:gitgutter_sign_column_always=1

" ----- vim-test -----
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
let test#strategy = "neovim"

" ----- vim-bookmarks -----
let g:bookmark_auto_save_file  = '$HOME/.config/nvim/bookmarks'
let g:bookmark_highlight_lines = 1
nmap ff <Plug>BookmarkToggle
nmap fj <Plug>BookmarkNext
nmap fk <Plug>BookmarkPrev

" ----- Ctrlp -----
" Updates the file list only once the user stops typing
let g:ctrlp_lazy_update = 1
let g:ctrlp_custom_ignore = '\v[\/](\.git|.sass-cache|node_modules|coverage|tmp|log)$'
nmap <C-b> :CtrlPBuffer<CR>
imap <C-b> <ESC>:CtrlPBuffer<CR>
" Don't open files in plugin windows
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" Open multiple files in hidden buffers
" 0i: do not open any new tab or window, and open additionnal files in hidden buffers
let g:ctrlp_open_multiple_files = '0i'
let g:ctrlp_extensions = ['undo', 'changes', 'bookmarkdir']
" ----- Ctrlp-funky -----
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" ----- vim commentary -----
nmap <leader>c gcc
vmap <leader>c gc

" ----- javascript libraries ------
let g:used_javascript_libs = 'jquery,underscore,angularjs'

" ----- syntastic -----
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
let g:syntastic_coffee_checkers = [ 'coffeelint' ]
let g:syntastic_coffee_coffeelint_args = "--csv --file /Users/pabuisson/coffeelint-altagem.json"
let g:syntastic_ruby_checkers = [ 'rubocop' ]
" let g:syntastic_haml_checkers = ['haml_lint']

" ----- indentLine -----
let g:indentLine_faster = 1

" ----- vim-markdown -----
let g:markdown_enable_spell_checking = 0

" ----- lightline.vim -----
" Mode is now displayed by ligthtline, no need to have Vim display it
set noshowmode
let g:lightline = {
      \   'colorscheme': 'flatcolor',
      \   'active': {
      \     'left':  [ ['mode'], ['fugitive', 'readonly', 'filename', 'modified'], ['ctrlpmark'] ],
      \     'right': [ ['lineinfo'], ['percent'], [ 'filetype' ] ]
      \   },
      \   'separator':    { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
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
" -- NEOVIM DEFAULTS --
" set ai
" set encoding=utf-8
" set mouse=a         "enables mouse in all four modes (normal/visuel/insert/command-line)
" set hlsearch
" set incsearch   "show matchs as I type
" set nocompatible
" ---------------------
set nu
set undolevels=100
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set hidden          "buffer behavior (allow to switch to other buffer even if current has been modified)
set vb              "visual bell instead of audio
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=100
set foldcolumn=1    "always enable foldcolumn
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
" set nrformats=    "interpret all digits as decimals (even when prefixed with 0)
set gdefault    "global replaces as default
set laststatus=2    "always display status line
set ignorecase      "ignore case for search and such
set relativenumber
set cursorline      "highlight current line
set scrolloff=3     "displays at least 4 lines around the cursor even when top/bottom of screen
set clipboard+=unnamed
set showmatch       "show matching parenthese
set lazyredraw      "redraw only when we need to
" === HIDDEN/NON VISIBLE CHARS ===
set list
set listchars=tab:▸\ ,eol:¬
match Error /\%o240/   "associate non-unicode space with the Error class
" === INDENTATION ===
set sw=2
set ts=2    "number of spaces a TAB char counts for (when encountered in a file)
set sts=2   "number of spaces a TAB char counts for (when performing editing operations)
set et      "always use spaces instead of tabs
" === LOAD/SAVE VIEWS ===
set viewoptions="cursors,fold"
set viewoptions-=options       "do not save current view specific options


" TODO Move this where it belongs, once it'll be working
" TODO Move this where it belongs, once it'll be working
function! NotGblame()
  " Do not loadview on fugitive git blames
  let filename = expand('%')
  if expand('%') =~ 'fugitiveblame'
    return 0
  endif
  return 1
endfunction

au BufWinLeave *.* if NotGblame() | mkview!          | endif
au BufWinEnter *.* if NotGblame() | silent! loadview | endif


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
  " On Mac OS, typing alt+space insert a non-regular space character that's not visible but
  " can generate random errors. Let's replace them with regular spaces on save
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

au BufWrite * :call StripTrailingWhitespaces()
au BufWrite * :call ReplaceNonUnicodeWhitespaces()


" ===============================================
" === Open URIs with default Mac OS behaviour ===
" ===============================================
" FIXME: Doesn't work for md links because of parentheses
"        -> Should be fixed

function! HandleURI()
  let s:uri = matchstr( getline("."), "[a-z]*:\/\/[^ >,;:'\)]*" )
  echo s:uri
  if s:uri != ""
	  exec "!open \"" . s:uri . "\""
  else
	  echo "No URI found in line."
  endif
endfunction

map <Leader>w :call HandleURI()<CR>


" ==============================================
" === Count occurrences of word under cursor ===
" ==============================================

function! CountOccurrences()
  " 1. Retrieve cursor position
  let l = line('.')
  let c = col('.')
  " 2. count occurrences
  let word = expand('<cword>')
  execute '%s/'.word.'//gn'
  " 3. Restore cursor position
  call cursor(l, c)
endfunction

map <Leader>co :call CountOccurrences()<CR>



" ==============================
" === FILE SPECIFIC SETTINGS ===
" ==============================

" Ensures the autocmds are only applied once.
augroup configgroup
  " Clears all the autocmds for the current group
  autocmd!

  " Specific filetype settings
  au BufRead,BufNewFile *.md     set ft=markdown
  au BufRead,BufNewFile *.todo   set ft=todo
  au BufRead,BufNewFile *.scss   set ft=scss
  au BufRead,BufNewFile *.sass   set ft=sass
  au BufRead,BufNewFile *.coffee set ft=coffee
  au BufRead,BufNewFile Gemfile* set ft=ruby

  " Comment settings depending on filetype
  au FileType coffee       set commentstring=#\ %s
  au FileType haml         set commentstring=/\ %s
  au FileType slim         set commentstring=/\ %s

  " Specific syntax highlights
  au BufRead,BufEnter,BufNewFile match Todo /REFACTOR/
  au FileType coffee,sass        match Error /;/
  au FileType coffee,javascript  match Todo /debugger\|console\.(warn|info|log)/
  au FileType ruby               match Todo /binding\.pry/
  " FIXME this abbr is applied to all filetypes
  au FileType coffee,javascript  iabbr log console.log

  " Other settings
  " Removes all autocommands for BufEnter on commit messages (au!) and set
  " cursor position on the first char
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  au FileType gitcommit set tw=85
  au FileType markdown  set sw=4 ts=4 sts=4 et wrap tw=100
  au FileType sass      match Error /\w:\S/
augroup END

" ===============================
" === SHORTCUTS CONFIGURATION ===
" ===============================

" Personal <Leader> mappings
nnoremap <leader>vrc  :e $MYVIMRC<CR>
nnoremap <leader>s :w<CR>
" File explorer
nnoremap <leader>e :Explore<CR>
" Undo last search (to remove the highlighting)
nnoremap <leader>su :nohlsearch<Bar>:echo<CR>
" Copy current file name to the clipboard
nnoremap <leader>yf :let @+ = expand("%:p")<CR>
"
" All buffers delete
nmap <leader>bda :%bd!<CR>
nmap <leader>bwa :%bw!<CR>
" Buffer delete to the right
nmap <leader>bdl :.+,$bd!<CR>
nmap <leader>bwl :.+,$bw!<CR>
" TODO: buffer delete all but current one
" TODO: buffer delete to the left

" Copy whole file
nmap <leader>ya ggVGy

" Firefox-like buffer cycle behaviour
nmap <C-S-tab> :bp<cr>
imap <C-S-tab> <ESC>:bp<cr>i
nmap <C-tab> :bn<cr>
imap <C-tab> <ESC>:bn<cr>i
" Vim specific buffer cycle behaviour
nmap <C-l> :bn<CR>
imap <C-l> <ESC>:bn<CR>
" FIXME: Doesn't work anymore in neovim
nmap <C-h> :bp<CR>
imap <C-h> <ESC>:bp<CR>

"Goes 1l down even with wrap enabled
nnoremap j gj
"Goes 1l up even with wrap enabled
nnoremap k gk

" Move current line down/up
" <Alt-k>
vmap Ï :m '>+1<CR>gv=gv
nmap Ï :m .+1<CR>
" <Alt-j>
vmap È :m '<-2<CR>gv=gv
nmap È :m .-2<CR>

" Map arrow keys
nmap <S-Tab> <<
nmap <Tab> >>
vmap <S-Tab> <gv
vmap <Tab> >gv
nmap <Up> <Nop>
vmap <Up> <Nop>
nmap <Down> <Nop>
vmap <Down> <Nop>



" ====================
" === UI SETTINGS ====
" ====================

" vim-gitgutter : always good-looking gutter column
highlight clear SignColumn
au ColorScheme * highlight clear SignColumn

" Enable true colors for better colorschemes
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" Enable cursor shape so that the cursor changes between insert/normal modes
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Default colorscheme
" -- Gruvbox --
colorscheme Gruvbox
set bg=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=0
" --
" -- Yowish --
" color yowish
" let g:yowish = {
"   \ 'ctrlp': 1,
"   \ 'unite': 0,
"   \ 'agit':  0,
"   \ 'nerdtree': 0
"   \ }

" color onedark

