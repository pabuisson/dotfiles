" =================================
" === VUNDLE PLUGINS MANAGEMENT ===
" =================================

filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
Plug 'haishanh/night-owl.vim'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kaicataldo/material.vim'
Plug 'drewtempelmeyer/palenight.vim'
" --- Neovim < 0.5 ---
" Plug 'ghifarit53/tokyonight-vim'
" --- Neovim 0.5 ---
Plug 'folke/tokyonight.nvim'

" --- Filetype related ---
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'
Plug 'gabrielelana/vim-markdown'

" --- Plugins ---
Plug 'ap/vim-buftabline'
Plug 'Raimondi/delimitMate'
Plug 'mhinz/vim-signify'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" TODO: get rid of this
Plug 'mileszs/ack.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'thaerkh/vim-indentguides'
Plug 'junegunn/goyo.vim', { 'for': [ 'text', 'markdown' ] }
Plug 'junegunn/limelight.vim', { 'for': ['markdown'] }
" -- Neovim 0.5.0 --
if has('nvim-0.5.0')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'neovim/nvim-lspconfig'
  " npm install -g typescript typescript-language-server
else
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " https://github.com/neoclide/coc-tsserver
  " :CocInstall coc-tsserver
  " https://github.com/neoclide/coc-eslint
  " :CocInstall coc-eslint
endif

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
\   'javascript': ['eslint'],
\   'crystal': ['ameba', 'crystal']
\}

let g:ale_fixers = {
\   'ruby': ['prettier'],
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

" ----- fugitive.vim -----
nnoremap <leader>gst :Git<CR>
nnoremap <leader>gci :Git commit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR>
nnoremap <leader>gb  :Git blame<CR>

" ----- fzf -----
" nnoremap <C-p> :FZF<CR>
" nnoremap <C-b> :Buffers<CR>
" nnoremap <C-t> :Tags<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fc :BCommits<CR>
nnoremap <leader>fo :FZFBuffersLines<CR>

let g:fzf_preview_window = ['right:40%']
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_commits_log_options = '--color=always --format="%C(auto)%h%d %s %C(green)%as %C(cyan)(%an)"'

ca rg Rg

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

let g:goyo_width = 100
let g:limelight_default_coefficient = 0.8
" augroup goyo
"   au!
"   autocmd! User GoyoEnter nested call <SID>goyo_enter()
"   autocmd! User GoyoLeave nested call <SID>goyo_leave()
" augroup END

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

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

" ----- javascript libraries ------
let g:used_javascript_libs = 'react'

" ----- rainbow_parentheses ------
" Activation based on file type
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup rainbow_lisp
  autocmd!
  autocmd FileType ruby,javascript RainbowParentheses
augroup END


" =================================
"       NVIM 0.5.0 SPECIFIC
" =================================

if !has('nvim-0.5.0')
  finish
end

" ----- lspconfig -----
" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
lua <<EOF
require'lspconfig'.tsserver.setup{}
EOF


" ----- treesitter -----
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "ruby" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF

