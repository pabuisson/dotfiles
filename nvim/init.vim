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

set number          "display line numbers
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
set foldcolumn=auto "show folding column
" === HIDDEN/NON VISIBLE CHARS ===
" multispace option allows to emulate indent lines without needing a dedicated plugin
" source: https://github.com/thaerkh/vim-indentguides
set list
autocmd OptionSet shiftwidth execute 'setlocal listchars=tab:▸\ ,eol:·,tab:│\ '
" === INDENTATION ===
set shiftwidth=2
set tabstop=2       "number of spaces a TAB char counts for (when encountered in a file)
set softtabstop=2   "number of spaces a TAB char counts for (when performing editing operations)
set expandtab       "always use spaces instead of tabs
set shiftround      "always round indentation level to a multiple of the number of spaces
" === LOAD/SAVE VIEWS ===
set viewoptions=cursor
augroup bufferloadsave
  autocmd!
  autocmd BufWinLeave *.* if &filetype !=# 'gitcommit' | mkview! | endif
  autocmd BufWinEnter *.* if &filetype !=# 'gitcommit' | silent! loadview | endif
augroup END
" === FILETYPE SPECIFICS THAT DO NOT HAVE THEIR OWN FT CONFIG FILE ===
augroup filetypes
  autocmd!
  " Cheatsheets are Markdown files with the .cheatmd extension
  " reference: https://elixirforum.com/t/cheatsheets-in-exdoc-v0-29/51255
  autocmd BufNewFile,BufRead *.cheatmd set filetype=markdown
augroup END

" === GENERIC ABBREVIATIONS ===
iabbr >> »
iabbr --> →
iabbr <-- ←

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
augroup END
