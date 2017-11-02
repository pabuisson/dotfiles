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

call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
" Plug 'GertjanReynaert/cobalt2-vim-theme'
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'jacoborus/tender'
" Plug 'rakr/vim-two-firewatch'
" Plug 'cocopon/iceberg.vim'
Plug 'morhetz/gruvbox'
Plug 'KabbAmine/yowish.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'MaxSt/FlatColor'
Plug 'arcticicestudio/nord-vim'
" --- Filetype related ---
Plug 'tpope/vim-haml',            { 'for': 'haml'     }
Plug 'slim-template/vim-slim',    { 'for': 'slim'     }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown '}
Plug 'kchmck/vim-coffee-script',  { 'for': 'coffee'   }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
" --- Plugins ---
" Plug 'tacahiroy/ctrlp-funky'
" Plug 'MattesGroeger/vim-bookmarks'
" Plug 'jacquesbh/vim-showmarks'
" Plug 'weynhamz/vim-plugin-minibufexpl'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
" Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'junegunn/goyo.vim', { 'for': [ 'text', 'markdown' ] }
Plug 'ap/vim-buftabline'

call plug#end()           " required


" =======================
" === PLUGIN SETTINGS ===
" =======================

" <Leader> set to , instead of \
let mapleader = ","

" ----- ack.vim -----
" Map Ack command to Ack! automatically so that it doesn't open first item by default
ca Ack Ack!
ca ack Ack!

" ----- buftabline -----
" Display only if there are 2 buffers
let g:buftabline_show=1
" Display vim inner buffer number
let g:buftabline_numbers=1

" ----- vim-gitgutter -----
" let g:gitgutter_sign_column_always=1
set signcolumn=yes

" ----- goyo -----
let g:goyo_width=100

" ----- fugitive.vim -----
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gci :Gcommit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR>
nnoremap <leader>gb  :Gblame<CR>

" ----- vim-bookmarks -----
let g:bookmark_auto_save_file  = '$HOME/.config/nvim/bookmarks'
let g:bookmark_highlight_lines = 1
nnoremap ff <Plug>BookmarkToggle
nnoremap fj <Plug>BookmarkNext
nnoremap fk <Plug>BookmarkPrev

" ----- vim-showmarks -----
nnoremap <leader>sm :DoShowMarks<CR>
nnoremap <leader>hm :NoShowMarks<CR>

" ----- Ctrlp -----
" Updates the file list only once the user stops typing
let g:ctrlp_lazy_update = 1
let g:ctrlp_custom_ignore = '\v[\/](\.git|.sass-cache|node_modules|coverage|tmp|log)$'
" Exclude git ignored files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" Open the buffer view
nnoremap <C-b> :CtrlPBuffer<CR>
inoremap <C-b> <ESC>:CtrlPBuffer<CR>
" Map leader-b
nnoremap <leader-b> :CtrlPBuffer<CR>
nnoremap <leader-p> :CtrlPMixed<CR>

" " Don't open files in plugin windows
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" " Open multiple files in hidden buffers
" 0i: do not open any new tab or window, and open additionnal files in hidden buffers
let g:ctrlp_open_multiple_files = '0i'
" let g:ctrlp_extensions = ['undo', 'changes', 'bookmarkdir']
" ----- Ctrlp-funky -----
" let g:ctrlp_funky_syntax_highlight = 1
" nnoremap <Leader>fu :CtrlPFunky<Cr>
" " narrow the list down with a word under cursor
" nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" ----- vim commentary -----
nmap <leader>c gcc
vmap <leader>c gc

" ----- javascript libraries ------
let g:used_javascript_libs = 'jquery,underscore,angularjs'

" ----- ale -----
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = "never"
let g:ale_linters = {
\   'ruby': [ 'rubocop' ]
\}

" ----- indentLine -----
" NOTE: not useful anymore apparently
"       https://github.com/Yggdroot/indentLine/issues/48#issuecomment-310256595
" let g:indentLine_faster = 1
let g:indentLine_char = '┆'
" let g:indentLine_color_gui = '#222222'
let g:indentLine_color_term = '122'
nnoremap <Leader>ti :IndentLinesToggle<CR>


" ----- easy align ----
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" custom alignment rule for quotes
let g:easy_align_delimiters = {
\   "'": {
\       'pattern': "'",
\       'left_margin': 1,
\       'right_margin': 0,
\       'stick_to_left': 0
\   },
\   '"': {
\       'pattern': '"',
\       'left_margin': 1,
\       'right_margin': 0,
\       'stick_to_left': 0
\   },
\ }


" ----- vim-markdown -----
let g:markdown_enable_spell_checking = 0

" ----- lightline.vim -----
" Mode is now displayed by ligthtline, no need to have Vim display it
set noshowmode
let g:lightline = {
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

" -- NEOVIM DEFAULTS --
" set ai
" set encoding=utf-8
" set mouse=a         "enables mouse in all four modes (normal/visuel/insert/command-line)
" set hlsearch
" set incsearch   "show matchs as I type
" set nocompatible
" syntax on
" filetype plugin indent on
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" ---------------------
" TEMP: need to enable this, work in progress, this should become the default
"       setting again once mouse=a is good enough for a majority of users
set mouse=a
" ---------------------
set nu              "display line numbers
set rnu             "relative line numbers
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set hidden          "buffer behavior (allow to switch to other buffer even if current has been modified)
set autowrite       "auto write to buffer when switching
set vb              "visual bell instead of audio
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=100
set foldcolumn=1    "always enable foldcolumn
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
" set nrformats=    "interpret all digits as decimals (even when prefixed with 0)
set gdefault        "global replaces as default
set laststatus=2    "always display status line
set ignorecase      "ignore case for search and such
set cursorline      "highlight current line
set scrolloff=3     "displays at least 4 lines around the cursor even when top/bottom of screen
set clipboard+=unnamed
set showmatch       "show matching parenthese
" set lazyredraw      "redraw only when we need to
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
set viewoptions=cursor,folds

" TODO Move this where it belongs, once it'll be working
" function! NotGblame()
"   " Do not loadview on fugitive git blames
"   let filename = expand('%')
"   if expand('%') =~ 'fugitiveblame'
"     return 0
"   endif
"   return 1
" endfunction

au BufWinLeave *.* mkview!
au BufWinEnter *.* silent! loadview
" au BufWinLeave *.* if NotGblame() | mkview!  | endif
" au BufWinEnter *.* if NotGblame() | loadview | endif
" au BufWinEnter *.* if NotGblame() | silent! loadview | endif


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
  au BufRead,BufNewFile *.es6    set ft=javacript
  au BufRead,BufNewFile Gemfile* set ft=ruby

  " Comment settings depending on filetype
  au FileType coffee       set commentstring=#\ %s
  au FileType haml         set commentstring=/\ %s
  " au FileType slim         set commentstring=/\ %s

  " Specific syntax highlights
  au BufRead,BufEnter,BufNewFile match Todo /REFACTOR\|NOTE/
  au FileType markdown           match Todo /TODO\|NOTE/
  au FileType coffee,sass        match Error /;/
  au FileType coffee,javascript  match Todo /console\.(warn|info|log)/
  au FileType ruby               match Todo /binding\.pry/
  " FIXME this abbr is applied to all filetypes
  au FileType coffee,javascript  iabbr log console.log

  " Other settings
  " Removes all autocommands for BufEnter on commit messages (au!) and set
  " cursor position on the first char
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  au FileType gitcommit set tw=85
  au FileType markdown  set sw=4 ts=4 sts=4 et wrap
  au FileType sass      match Error /\w:\S/
  " Do not hide quotes in JSON files
  let g:vim_json_syntax_conceal = 0
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
nnoremap <esc> :nohlsearch<Bar>:echo<CR>
" Copy current file name to the clipboard
nnoremap <leader>yf :let @+ = expand("%:p")<CR>
"
" All buffers delete
nnoremap <leader>bda :%bd!<CR>
nnoremap <leader>bwa :%bw!<CR>
" Buffer delete to the right
nnoremap <leader>bdl :.+,$bd!<CR>
nnoremap <leader>bwl :.+,$bw!<CR>
" TODO: buffer delete all but current one
" TODO: buffer delete to the left

" Copy whole file
nnoremap <leader>ya ggVGy

" Firefox-like buffer cycle behaviour
nnoremap <C-S-tab> :bp<cr>
inoremap <C-S-tab> <ESC>:bp<cr>i
nnoremap <C-tab> :bn<cr>
inoremap <C-tab> <ESC>:bn<cr>i
" Vim specific buffer cycle behaviour
nnoremap <C-l> :bn<CR>
inoremap <C-l> <ESC>:bn<CR>
" FIXME: Doesn't work anymore in neovim
nnoremap <C-h> :bp<CR>
inoremap <C-h> <ESC>:bp<CR>

"Goes 1l down even with wrap enabled
nnoremap j gj
"Goes 1l up even with wrap enabled
nnoremap k gk

" Move current line down/up
" <Alt-k>
vnoremap Ï :m '>+1<CR>gv=gv
nnoremap Ï :m .+1<CR>
" <Alt-j>
vnoremap È :m '<-2<CR>gv=gv
nnoremap È :m .-2<CR>

" Map arrow keys
nnoremap <S-Tab> <<
nnoremap <Tab> >>
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv
nnoremap <Up> <Nop>
vnoremap <Up> <Nop>
nnoremap <Down> <Nop>
vnoremap <Down> <Nop>

" Reset display
" nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" Should reset syntax highlight
nnoremap <leader>s :syntax sync fromstart<CR>:redraw!<CR>

" Enable/disable relative numbering
nnoremap <leader>n :set rnu<CR>
nnoremap <leader>nn :set nornu<CR>

" ====================
" === UI SETTINGS ====
" ====================

" vim-gitgutter : always good-looking gutter column
highlight clear SignColumn
au ColorScheme * highlight clear SignColumn

" Enable true colors for better colorschemes
" For neovim > 0.1.5
set termguicolors


" Default colorscheme
" --  --
" colorscheme Gruvbox
" set bg=dark
" let g:gruvbox_contrast_dark='hard'
" " let g:gruvbox_contrast_light='soft'
" let g:gruvbox_bold=0
" --
" -- Yowish --
" color yowish
" let g:yowish = {
" \ 'ctrlp': 1,
" \ 'unite': 0,
" \ 'agit':  0,
" \ 'nerdtree': 0
" \ }
" -- One half dark --
" color onehalfdark
" let g:lightline.colorscheme='onehalfdark'
" -- Oceanic Next --
" set bg=dark
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext


" let g:lightline.colorscheme='PaperColor'
" " let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" " let ayucolor="dark"   " for dark version of theme
" colorscheme ayu


" Italics for my favorite color scheme
colorscheme palenight
let g:lightline.colorscheme='materia'
let g:palenight_terminal_italics=1

" colorscheme flatcolor
" let g:lightline = { 'colorscheme': 'flatcolor' }
