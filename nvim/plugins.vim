filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/everforest'
Plug 'mhartington/oceanic-next'
Plug 'drewtempelmeyer/palenight.vim'
if has('nvim-0.5')
  Plug 'navarasu/onedark.nvim'
else
  Plug 'joshdick/onedark.vim'
endif
" --- Filetype related ---
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'sheerun/vim-polyglot'
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
" --- Plugins ---
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-signify'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fubitive'
Plug 'ap/vim-css-color', { 'for': ['css', 'sass', 'scss'] }
Plug 'dense-analysis/ale'
" " NOTE: can I replace gutentags with lspconfig ?
" Plug 'ludovicchabant/vim-gutentags'
" brew install universal-ctags
Plug 'thaerkh/vim-indentguides'
if has('nvim-0.5')
  " NOTE: treesitter brings problems with % matching for ruby
  " stuff inside comments or 'it' tests are matched as if they were keywords
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'neovim/nvim-lspconfig'

  " -- nvim-cmp --
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " snippet engine (required)
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
endif

call plug#end()


" =======================
" === PLUGIN SETTINGS ===
" =======================

" " ----- ale -----
let g:ale_disable_lsp = 1

" Disable linting: handled by native LSP
let g:ale_linters_explicit = 1
let g:ale_linters = {}

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier']
\}


" ----- buftabline -----
" Display only if there are 2 buffers
let g:buftabline_show=1
" Display vim inner buffer number
let g:buftabline_numbers=1


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
nnoremap <leader>fo :BLines<CR>
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


" " ----- gutentags -----
" " let g:gutentags_trace = 1
" let g:gutentags_cache_dir = '~/.local/share/nvim/ctags'
" if executable('rg')
"   " Ignore gitignore files by using rg
"   let g:gutentags_file_list_command = 'rg --files'
" endif


" ----- javascript libraries ------
let g:used_javascript_libs = 'react'


" =================================
"       NVIM 0.5.0 SPECIFIC
" =================================

if !has('nvim-0.5')
  finish
end

" ----- lspconfig -----
" TODO: setup a "peek definition" shortcut
" It exists in lspsaga, but should be possible with only lspconfig?

lua <<EOF
require("nvim-lsp-installer").setup {
  automatic_installation = true -- automatically install language servers setup below for lspconfig
}

local nvim_lsp = require('lspconfig')
nvim_lsp.tsserver.setup{}
nvim_lsp.solargraph.setup{}
nvim_lsp.crystalline.setup{}

local signs = { Error = "❗️", Warn = "🔸", Hint = "🔹", Info = "🔹" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> ge <cmd>lua vim.diagnostic.setloclist()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_next()<CR>

" ----- cmp -----
set completeopt=menu,menuone,noselect

lua <<EOF
local cmp = require'cmp'

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- Add source to the result
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]"
      })[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }, {
    { name = 'buffer' },
  })
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
-- NOTE: in the wiki, language servers are "setup{}" aftrer the update_capabilities but in my config it's not the case
-- not sure if it will work but if it does not, it may be a reason why
EOF

" ----- treesitter -----
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "ruby", "elixir", "comment" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
