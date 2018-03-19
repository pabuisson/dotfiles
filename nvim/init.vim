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

