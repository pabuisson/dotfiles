" ============================================================
"                   — NEOVIMRC FILE —
"
" The original .vimrc file is stored under ~/.vim directory.
" I use a symbolic link to link ~/.vimrc to this location.
"
" ============================================================

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/ui.vim
source $HOME/.config/nvim/mappings.vim


" ================
" === SETTINGS ===
" ================

" TEMP: need to enable this, work in progress, this should become the default
"       setting again once mouse=a is good enough for a majority of users
set mouse=a
" ---------------------
set nu              "display line numbers
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set hidden          "buffer behavior (allow to switch to other buffer even if current has been modified)
set autowrite       "auto write to buffer when switching
set vb              "visual bell instead of audio
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=100
" set cursorline      "highlight current line (/!\ Performances on iterm !)
set foldcolumn=1    "always enable foldcolumn
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
" set nrformats=    "interpret all digits as decimals (even when prefixed with 0)
set ignorecase      "ignore case for search and such
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
set viewoptions=cursor
augroup bufferloadsave
  au!
  au BufWinLeave *.* mkview!
  au BufWinEnter *.* silent! loadview
  " au BufWinLeave *.* if NotGblame() | mkview!  | endif
  " au BufWinEnter *.* if NotGblame() | loadview | endif
  " au BufWinEnter *.* if NotGblame() | silent! loadview | endif
augroup END
" === STATUS LINE ===
set laststatus=2
set noshowmode
set statusline=
set statusline+=[%{g:currentmode[mode()]}]
set statusline+=[%n]
set statusline+=\ %f
" switching to right side
set statusline+=%=
set statusline+=%{GitInfo()}\ \|
set statusline+=\ %c\ :
set statusline+=\ %l
set statusline+=/
set statusline+=%L
set statusline+=\ \|\ %p%%

let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

function! GitInfo()
  let git = fugitive#head()
  if git != ''
    return 'g:'.fugitive#head()
  else
    return ''
endfunction

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

augroup customfunctions
  au!
  au BufWrite * :call StripTrailingWhitespaces()
  au BufWrite * :call ReplaceNonUnicodeWhitespaces()
augroup END


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

nnoremap <Leader>w :call HandleURI()<CR>


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

nnoremap <Leader>co :call CountOccurrences()<CR>


" ===================
" === Format JSON ===
" ===================

" TODO: replace "nil" with "null" and "=>" with ":"
com! FormatJSON %!python -m json.tool


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
  au FileType coffee set commentstring=#\ %s
  au FileType haml   set commentstring=/\ %s
  " au FileType slim   set commentstring=/\ %s

  " Specific syntax highlights
  " au BufRead,BufEnter,BufNewFile match Todo /REFACTOR\|NOTE\|TODO/
  " au FileType coffee,sass        match Error /;/
  " au FileType coffee,javascript  match Todo /console\.(warn|info|log)/
  " au FileType ruby               match Todo /binding\.pry/
  " au FileType coffee,javascript  iabbr log console.log

  " Other settings
  " Removes all autocommands for BufEnter on commit messages (au!) and set
  " cursor position on the first char
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  au FileType gitcommit set tw=85
  au FileType markdown  set sw=4 ts=4 sts=4 et wrap
  au FileType crystal   set sw=2 ts=2 sts=2 et wrap
  au FileType sass      match Error /\w:\S/
augroup END
