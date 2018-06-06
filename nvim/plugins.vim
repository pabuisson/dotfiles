" =================================
" === VUNDLE PLUGINS MANAGEMENT ===
" =================================

filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'kristijanhusak/vim-hybrid-material'
" Plug 'jacoborus/tender'
"
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'rakr/vim-two-firewatch'
Plug 'crusoexia/vim-monokai'
Plug 'ajh17/spacegray.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'KabbAmine/yowish.vim'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'cocopon/iceberg.vim'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

" --- Filetype related ---
Plug 'slim-template/vim-slim',    { 'for': 'slim'     }
" Plug 'gabrielelana/vim-markdown', { 'for': 'markdown '}
Plug 'tpope/vim-haml',            { 'for': 'haml'     }
Plug 'kchmck/vim-coffee-script',  { 'for': 'coffee'   }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'

" --- Plugins ---
" Plug 'MattesGroeger/vim-bookmarks'
" Plug 'jacquesbh/vim-showmarks'
" Plug 'weyhamz/vim-plugin-minibufexpl'
" Plug 'nathanaelkane/vim-indent-guides'
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
" Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
" Plug 'junegunn/goyo.vim', { 'for': [ 'text', 'markdown' ] }
Plug 'ap/vim-buftabline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

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

" ----- ale -----
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = "never"
let g:ale_linters = {
\   'ruby': [ 'rubocop' ]
\}

" ----- vim-bookmarks -----
" let g:bookmark_auto_save_file  = '$HOME/.config/nvim/bookmarks'
" let g:bookmark_highlight_lines = 1
" nnoremap ff <Plug>BookmarkToggle
" nnoremap fj <Plug>BookmarkNext
" nnoremap fk <Plug>BookmarkPrev

" ----- buftabline -----
" Display only if there are 2 buffers
let g:buftabline_show=1
" Display vim inner buffer number
let g:buftabline_numbers=1


" ----- vim commentary -----
nmap <leader>c gcc
vmap <leader>c gc

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

" ----- fugitive.vim -----
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gci :Gcommit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR>
nnoremap <leader>gb  :Gblame<CR>

" ----- fzf -----
nnoremap <C-p> :FZF<CR>
inoremap <C-p> <ESC>:FZF<CR>
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" --- Find in opened buffers ---
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <C-b> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


" ----- gitgutter -----
" let g:gitgutter_sign_column_always=1
set signcolumn=yes

" ----- goyo ------
function! s:goyo_enter()
  let g:buftabline_show = 0
  " Needed to update configuration at runtime
  call buftabline#update(0)
  " vim default tabline
  set showtabline=0
endfunction

function! s:goyo_leave()
  let g:buftabline_show = 2
  " Needed to update configuration at runtime
  call buftabline#update(0)
  " vim default tabline
  set showtabline=2
endfunction

let g:goyo_width = 100
augroup goyo
  au!
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
augroup END


" ----- indentLine -----
" let g:indentLine_char = '┆'
" " let g:indentLine_color_gui = '#222222'
" let g:indentLine_color_term = '122'
" nnoremap <Leader>ti :IndentLinesToggle<CR>
" " https://github.com/Yggdroot/indentLine/issues/58
" let g:indentLine_newVersion=0

" ----- javascript libraries ------
let g:used_javascript_libs = 'jquery,underscore,angularjs'

" ----- lightline.vim -----
" Mode displayed by ligthtline, no need to have Vim display it
set noshowmode
let g:lightline = {
      \   'active': {
      \     'left':  [ ['mode'], ['fugitive', 'filename', 'modified'] ]
      \   },
      \   'separator':    { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
      \   'component_function': {
      \     'filename':   'MyFilename',
      \     'fugitive':   'MyFugitive',
      \     'mode':       'MyMode',
      \     'readonly':   'MyReadOnly',
      \     'modified':   'MyModified'
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

" ----- vim-markdown -----
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" ----- vim-showmarks -----
" nnoremap <leader>sm :DoShowMarks<CR>
" nnoremap <leader>hm :NoShowMarks<CR>

" ----- vim-markdown -----
let g:markdown_enable_spell_checking = 0

