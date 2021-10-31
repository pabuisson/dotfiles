filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kaicataldo/material.vim'
Plug 'sainnhe/everforest'
Plug 'mhartington/oceanic-next'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'rmehri01/onenord.nvim'
if has('nvim-0.5')
  Plug 'folke/tokyonight.nvim'
else
  Plug 'ghifarit53/tokyonight-vim'
endif
" --- Filetype related ---
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'
Plug 'gabrielelana/vim-markdown'
" --- Plugins ---
Plug 'ap/vim-buftabline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-repeat'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
" NOTE: can I replace that with lspconfig / treesitter ?
Plug 'ludovicchabant/vim-gutentags'
" brew install universal-ctags
Plug 'thaerkh/vim-indentguides'
if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  " npm install -g typescript typescript-language-server
  " gem install solargraph
  Plug 'nvim-lua/plenary.nvim' "prerequisite for gitsigns
  Plug 'lewis6991/gitsigns.nvim'
  " -- nvim-cmp --
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
else
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " https://github.com/neoclide/coc-tsserver
  " :CocInstall coc-tsserver
  " https://github.com/neoclide/coc-eslint
  " :CocInstall coc-eslint
  Plug 'mhinz/vim-signify'
endif

call plug#end()


" =======================
" === PLUGIN SETTINGS ===
" =======================

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
" NOTE: commented on oct 2021 to see if it makes a diff today
" hi link BufTabLineActive BufTabLineHidden


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
" Escape C-a and C-d in iTerm2 : https://github.com/junegunn/fzf.vim/issues/54
" ---
" Search with ripgrep for the word under the cursor
" Source: https://coffeeandcontemplation.dev/2020/11/13/fuzzy-finding-in-vim/
command! -bang -nargs=* RgCurrentWord
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <leader>fw :execute 'RgCurrentWord '.expand('<cword>')<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :BCommits<CR>
nnoremap <leader>fl :Lines<CR>
ca rg Rg

" Layout / Sizing
" hidden by default, ctrl-/ to toggle
let g:fzf_preview_window = ['right:40%', 'ctrl-/']

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_commits_log_options = '--color=always --format="%C(auto)%h%d %C(green)%as %C(cyan)%an :: %C(reset)%s"'


" ----- gutentags -----
" let g:gutentags_trace = 1
let g:gutentags_cache_dir = '~/.local/share/nvim/ctags'
if executable('rg')
  " Ignore gitignore files by using rg
  let g:gutentags_file_list_command = 'rg --files'
endif


" ----- javascript libraries ------
let g:used_javascript_libs = 'react'


" =================================
"       NVIM 0.5.0 SPECIFIC
" =================================

if !has('nvim-0.5')
  finish
end

" ----- lspconfig -----
" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
lua <<EOF
local nvim_lsp = require('lspconfig')
nvim_lsp.tsserver.setup{}
nvim_lsp.solargraph.setup{}
EOF

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" ----- gitsigns -----
lua <<EOF
require('gitsigns').setup()
EOF

" ----- cmp -----
set completeopt=menu,menuone,noselect

lua <<EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {},
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.tsserver.setup{}
require'lspconfig'.solargraph.setup{}
EOF

" ----- treesitter -----
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "ruby" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
