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
  au BufWinLeave *.* mkview!
  au BufWinEnter *.* silent! loadview
augroup END

augroup ftgroup
  autocmd!

  " Disable editorconfig for yaml file, for work
  " (otherwise it messes up the whitespaces in yaml files)
  au BufRead,BufNewFile *.yml let b:editorconfig = v:false

  " Specific filetype settings
  " FIXME: these don't work. the ft is still not set correctly
  " au BufRead,BufNewFile *.slim set ft=slim
  " au BufRead,BufNewFile *.haml set ft=haml
  " au BufRead,BufNewFile *.yml set ft=yaml

  " Custom highlightings
  " So that all assert matchers are highlighted as keywords
  au FileType ruby match Keyword /assert_\w\+/
  au FileType ruby match ErrorMsg /binding\.pry\|pry\|byebug\|debugger/

  " Custom abbreviation for certain filetypes
  au FileType ruby abbr fsl # frozen_string_literal: true
  au FileType ruby abbr logmethod puts(__method__.to_s.center(50, '-'))
  au FileType ruby iabbr <buffer> bdp binding.pry
  au FileType ruby iabbr <buffer> mlog puts __method__.to_s.center(40, '-')
  au FileType ruby iabbr <buffer> itdo it "" doend<esc>k0f"a
  au FileType ruby iabbr <buffer> descdo describe "" doend<esc>k0f"a

  " Other custom settings
  au FileType crystal   set sw=2 ts=2 sts=2 et wrap
  au FileType gitcommit set tw=85
  au FileType markdown  set sw=4 ts=4 sts=4 et wrap

  " Removes all autocommands on commit messages (au!) + set cursor position on the first char
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END
