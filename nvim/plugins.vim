" =================================
" === VUNDLE PLUGINS MANAGEMENT ===
" =================================

filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
Plug 'mhartington/oceanic-next'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'KabbAmine/yowish.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'haishanh/night-owl.vim'
Plug 'rakr/vim-one'
Plug 'cocopon/iceberg.vim'
Plug 'sainnhe/edge'
Plug 'bluz71/vim-nightfly-guicolors'

" --- Filetype related ---
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'

" --- Plugins ---
" Plug 'junegunn/vim-easy-align'
" Plug 'junegunn/goyo.vim', { 'for': [ 'text', 'markdown' ] }
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-signify'
Plug 'ap/vim-buftabline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'janko-m/vim-test'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" =======================
" === PLUGIN SETTINGS ===
" =======================

" ----- ack.vim -----
" Map Ack command to Ack! automatically so that it doesn't open first item by default
ca Ack Ack!
ca ack Ack!
" nnoremap <leader>a :Ack!<CR>

" ----- ale -----
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = "never"

" Only run linters from ale_linters
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'javascript': ['eslint']
\}

" \   'ruby': ['rubocop'],
let g:ale_fixers = {
\   'javascript': ['prettier']
\}
" Run fixers on save
let g:ale_fix_on_save = 1

" nnoremap <silent> <leader>ak <Plug>(ale_previous_wrap)
" nnoremap <silent> <leader>aj <Plug>(ale_next_wrap)

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
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)
" " custom alignment rule for quotes
" let g:easy_align_delimiters = {
" \   "'": {
" \       'pattern': "'",
" \       'left_margin': 1,
" \       'right_margin': 0,
" \       'stick_to_left': 0
" \   },
" \   '"': {
" \       'pattern': '"',
" \       'left_margin': 1,
" \       'right_margin': 0,
" \       'stick_to_left': 0
" \   },
" \ j

" ----- fugitive.vim -----
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gci :Gcommit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR>
nnoremap <leader>gb  :Gblame<CR>

" ----- fzf -----
" nnoremap <C-p> :FZF<CR>
" nnoremap <C-b> :Buffers<CR>
" nnoremap <C-t> :Tags<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fc :BCommits<CR>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_commits_log_options = '--color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr (%cn)"'


" " ----- goyo ------
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


" ----- javascript libraries ------
let g:used_javascript_libs = 'jquery,underscore,react'

" ----- vim-test -----
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "neovim"


" ----- gutentags -----
let g:gutentags_cache_dir = '~/.local/share/nvim/ctags'

function! s:get_gutentags_status(mods)
  let l:msg = ''
  if index(a:mods, 'ctags') >= 0
    let l:msg .= '♨'
  endif
  if index(a:mods, 'cscope') >= 0
    let l:msg .= '♺'
  endif
  return l:msg
endfunction
