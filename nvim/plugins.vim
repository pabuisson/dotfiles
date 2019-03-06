" =================================
" === VUNDLE PLUGINS MANAGEMENT ===
" =================================

filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
" Plug 'KabbAmine/yowish.vim'
" Plug 'jacoborus/tender'
" Plug 'romainl/flattened'
Plug 'mhartington/oceanic-next'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'

" --- Filetype related ---
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'

" --- Plugins ---
" Plug 'MattesGroeger/vim-bookmarks'
" Plug 'Yggdroot/indentLine'
" Plug 'jacquesbh/vim-showmarks'
" Plug 'junegunn/goyo.vim', { 'for': [ 'text', 'markdown' ] }
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-signify'
Plug 'ap/vim-buftabline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'janko-m/vim-test'

call plug#end()


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
\   'ruby': [ 'rubocop' ],
\   'coffeescript': [ 'coffeelint' ]
\}

nmap <silent> <leader>ak <Plug>(ale_previous_wrap)
nmap <silent> <leader>aj <Plug>(ale_next_wrap)

" ----- buftabline -----
" Display only if there are 2 buffers
let g:buftabline_show=1
" Display vim inner buffer number
let g:buftabline_numbers=1
" Highlighting : make visible inactive splits highlighted like any hidden buffer
" so that the inactive split don't look more "highlighted" than the active buffer
hi link BufTabLineActive BufTabLineHidden

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
" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

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
" function! s:goyo_enter()
"   let g:buftabline_show = 0
"   " Needed to update configuration at runtime
"   call buftabline#update(0)
"   " vim default tabline
"   set showtabline=0
" endfunction

" function! s:goyo_leave()
"   let g:buftabline_show = 2
"   " Needed to update configuration at runtime
"   call buftabline#update(0)
"   " vim default tabline
"   set showtabline=2
" endfunction

" let g:goyo_width = 100
" augroup goyo
"   au!
"   autocmd! User GoyoEnter nested call <SID>goyo_enter()
"   autocmd! User GoyoLeave nested call <SID>goyo_leave()
" augroup END


" ----- indentLine -----
" let g:indentLine_char = '┆'
" " let g:indentLine_color_gui = '#222222'
" let g:indentLine_color_term = '122'
" nnoremap <Leader>ti :IndentLinesToggle<CR>
" " https://github.com/Yggdroot/indentLine/issues/58
" let g:indentLine_newVersion=0

" ----- javascript libraries ------
let g:used_javascript_libs = 'jquery,underscore,angularjs'

" ----- vim-markdown -----
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" ----- vim-markdown -----
let g:markdown_enable_spell_checking = 0


" ----- vim-test -----
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "neovim"
