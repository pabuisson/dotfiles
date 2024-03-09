" ============================================================
"                   — NEOVIMRC FILE —
"
" The original .vimrc file is stored under ~/.vim directory.
" I use a symbolic link to link ~/.vimrc to this location.
"
" ============================================================

source $HOME/.config/nvim/statusline.vim
source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/ui.vim
source $HOME/.config/nvim/functions.vim


" ================
" === SETTINGS ===
" ================

set nu              "display line numbers
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set autowrite       "auto write to buffer when switching
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=120
set cursorline      "highlight current line
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
set ignorecase      "ignore case for search and such
set smartcase       "don't ignore case if there's an uppercase letter in the pattern
set scrolloff=4     "displays at least 4 lines around the cursor even when top/bottom of screen
set clipboard+=unnamed
set showmatch       "show matching parenthese
" === HIDDEN/NON VISIBLE CHARS ===
set list
set listchars=tab:▸\ ,eol:¬
" === INDENTATION ===
set sw=2
set ts=2    "number of spaces a TAB char counts for (when encountered in a file)
set sts=2   "number of spaces a TAB char counts for (when performing editing operations)
set et      "always use spaces instead of tabs
set shiftround  "always round indentation level to a multiple of the number of spaces
" === LOAD/SAVE VIEWS ===
set viewoptions=cursor
augroup bufferloadsave
  autocmd!
  " au BufWinLeave *.* mkview!
  " au BufWinEnter *.* silent! loadview
  " NOTE: testing this, may help me get rid of the setpos I do on gitcommits
  autocmd BufWinLeave *.* if &filetype !=# 'gitcommit' | mkview! | endif
  autocmd BufWinEnter *.* if &filetype !=# 'gitcommit' | silent! loadview | endif
augroup END
