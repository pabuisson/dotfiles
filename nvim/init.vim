" ============================================================
"                   — NEOVIMRC FILE —
"
" The original .vimrc file is stored under ~/.vim directory.
" I use a symbolic link to link ~/.vimrc to this location.
"
" ============================================================

source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/ui.vim
source $HOME/.config/nvim/functions.vim


" ================
" === SETTINGS ===
" ================

set mouse=a         "enable mouse for all modes
set nu              "display line numbers
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set hidden          "buffer behavior (allow to switch to other buffer even if current has been modified)
set autowrite       "auto write to buffer when switching
set vb              "visual bell instead of audio
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=120
set cursorline      "highlight current line
set foldcolumn=1    "always enable foldcolumn
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
set ignorecase      "ignore case for search and such
set smartcase       "don't ignore case if there's an uppercase letter in the pattern
set scrolloff=4     "displays at least 4 lines around the cursor even when top/bottom of screen
set clipboard+=unnamed
set showmatch       "show matching parenthese
set lazyredraw      "redraw only when we need to (especially on macros, registers and such)
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
set viewoptions=cursor
augroup bufferloadsave
  au!
  au BufWinLeave *.* mkview!
  au BufWinEnter *.* silent! loadview
augroup END
" === STATUS LINE ===
set laststatus=2
set noshowmode
set statusline=%#Pmenu#
set statusline+=%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffAdd#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffText#%{(mode()=='r')?'\ \ REPLACE\ ':''}
set statusline+=%#Cursor#%{IsVisual()?'\ \ VISUAL\ ':''}
set statusline+=%#Pmenu#
set statusline+=┊\ %f
set statusline+=%{&modified?'\ [+]\ ':''}
set statusline+=\ ┊\ %{GitInfo()}
" switch to the right side
set statusline+=%=
set statusline+=%{gutentags#statusline('','','\ 🗯:\ ')}
set statusline+=\ ┊\ %l/%L
set statusline+=\ \┊\ %p%%

function! IsVisual()
  return mode() == 'v' || mode() == ''
endfunction

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return 'g:'.fugitive#head()
  else
    return ''
  endif
endfunction


" ==============================
" === FILE SPECIFIC SETTINGS ===
" ==============================

" Ensures the autocmds are only applied once.
augroup configgroup
  autocmd!  

  " Specific filetype settings
  au BufRead,BufNewFile *.slim set ft=slim
  au BufRead,BufNewFile *.yml set ft=yaml

  " Specific syntax highlights
  au FileType ruby match ErrorMsg /binding\.pry\|pry\|byebug/
  au FileType ruby ab fsl # frozen_string_literal: true

  " Other settings
  " Removes all autocommands for BufEnter on commit messages (au!) and set
  " cursor position on the first char
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  au FileType gitcommit set tw=85
  au FileType markdown  set sw=4 ts=4 sts=4 et wrap
  au FileType crystal   set sw=2 ts=2 sts=2 et wrap
augroup END
