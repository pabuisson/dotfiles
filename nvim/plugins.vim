filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
Plug 'sainnhe/everforest'
Plug 'mhartington/oceanic-next'

if has('nvim')
  Plug 'rebelot/kanagawa.nvim'
  Plug 'navarasu/onedark.nvim'
endif
" --- Filetype related ---
" Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

" --- Plugins ---
Plug 'ap/vim-buftabline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'dominikduda/vim_current_word'

if has('nvim')
  " -- treesitter and lsp --
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'mfussenegger/nvim-lint'
  Plug 'saghen/blink.cmp', { 'tag': 'v1.2.0' }
  " -- formatter --
  " NOTE: can't use for now, see configuration section for more details
  " Plug 'stevearc/conform.nvim'

  " -- plenary and plugins depending on it --
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/todo-comments.nvim'

  " -- other plugins --
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'smoka7/hop.nvim'
  Plug 'nvimdev/indentmini.nvim'
  Plug 'stevearc/aerial.nvim'
  Plug 'dstein64/nvim-scrollview'
else
  Plug 'mhinz/vim-signify'
endif

call plug#end()


" =======================
" === PLUGIN SETTINGS ===
" =======================

" " ----- ale -----
let g:ale_linters_explicit = 1
let g:ale_linters = {}
let g:ale_fix_on_save = 1
let g:ale_ruby_syntax_tree_executable = 'bundle'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['remove_trailing_lines', 'trim_whitespace', 'syntax_tree', 'prettier'],
\   'elixir': ['mix_format', 'trim_whitespace', 'remove_trailing_lines'],
\   'heex': ['mix_format', 'trim_whitespace', 'remove_trailing_lines'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\}


" ----- current_word -----
let g:vim_current_word#highlight_delay = 800
highlight CurrentWord gui=bold cterm=bold
highlight CurrentWordTwins gui=underline cterm=underline

" " NOTE: below is the native way of doing this, but I couldn't get it to work
" " yet. Will need to dive deeper into this, maybe I can get rid of a plugin
" source: https://chaos.social/@scy/111570077753908537
" set updatetime=1000
" " TODO: trigger document_highlight only if the LSP server supports this
" autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
" autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
" " NOTE: shouldn't we do that for CursorMovedI too?
" autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
" highlight LspReferenceRead  guibg=#d20000
" highlight LspReferenceWrite guibg=#d20000


" ----- fugitive.vim -----
nnoremap <leader>gst :Git<CR>
nnoremap <leader>gci :Git commit<CR>
nnoremap <leader>gr  :Gread<CR>
nnoremap <leader>gw  :Gwrite<CR>
nnoremap <leader>gbf :Git blame<CR>
nnoremap <leader>gdv :Gvdiffsplit<CR>
nnoremap <leader>gdh :Gdiffsplit<CR>


" ----- fzf -----
" Escape C-a and C-d in iTerm2 : https://github.com/junegunn/fzf.vim/issues/54

let $FZF_DEFAULT_OPTS="--bind ctrl-k:prev-history,ctrl-j:next-history"
let g:fzf_vim = { 'preview_window': ['right,50%', 'ctrl-p'] }
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_commits_log_options = '--color=always --format="%C(auto)%h%d %C(green)%as %C(cyan)%an :: %C(reset)%s"'

" Search with ripgrep for the word under the cursor
" Source: https://coffeeandcontemplation.dev/2020/11/13/fuzzy-finding-in-vim/
command! -bang -nargs=* RgWordExact
  \ call fzf#vim#grep(
  \   'rg -F -w --column --line-number --no-heading --color=always -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* RgWord
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* RgDefWithArg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always "^\s*\b(def|defp|defmodule)\b [\w\.]*\b'.<q-args>.'\b"', 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* RgDefFn
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always "^\s*\b(def|defp)\b"', 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* RgDefMod
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always "^\s*\bdefmodule\b"', 1,
  \   fzf#vim#with_preview(), <bang>0)

" Find usage of word under cursor, excluding fn and module definition
command! -bang -nargs=* RgFindReferences
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --pcre2 "^(?!(.*\b(def|defp|defmodule|alias|require|spec)\b)|(\s*#)).*\b'.<q-args>.'\b"', 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <leader>fw :execute 'RgWord '.expand('<cword>')<CR>
nnoremap <leader>fW :execute 'RgWordExact '.expand('<cword>')<CR>
nnoremap <leader>fd :execute 'RgDefWithArg '.expand('<cword>')<CR>
nnoremap <leader>fr :execute 'RgFindReferences '.expand('<cword>')<CR>
nnoremap <leader>fme :execute 'RgDefFn'<CR>
nnoremap <leader>fmo :execute 'RgDefMod'<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :BCommits<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fo :BLines<CR>
ca rg Rg
ca rgw RgWordExact


" ----- projectionist -----
nnoremap <leader>a :A<CR>


" ==========================
"       NVIM SPECIFIC
" ==========================

if !has('nvim-0.5')
  finish
end

lua <<EOF

-- ----- aerial -----
-- NOTE: neovim LSP is supposed to provide this but I couldn't get it to work yet.
-- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.document_symbol()
require("aerial").setup({
  layout = {
    min_width = 20,
    width = 0.2,
    max_width = 50
  },
  nerd_font = true,
  post_jump_cmd = "normal! zt",
})
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")


-- ----- blink -----
require("blink.cmp").setup({
  keymap = { preset = 'enter' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})

-- -- ----- conform -----
-- -- FIXME: can't use right now, mix format prepends log lines to the formatted files...
-- -- TODO: ruby: syntax_tree / prettier ruby
-- require("conform").setup({
--   formatters_by_ft = {
--     elixir = { 'mix', 'trim_whitespace', 'trim_newlines' },
--     heex = { 'mix', 'trim_whitespace', 'trim_newlines' },
--     javascript = { 'prettier' },
--     typescript = { 'prettier' }
--   },
--   format_on_save = {
--     lsp_format = "fallback",
--     timeout_ms = 1500,
--   },
-- })

-- ----- hop -----
require('hop').setup()
vim.keymap.set("n", "<leader>jw", "<cmd>HopWord<CR>")
vim.keymap.set("n", "<leader>jl", "<cmd>HopLine<CR>")
vim.keymap.set("n", "<leader>jc", "<cmd>HopCamelCale<CR>")


-- ----- lint -----
-- Solution to use external linters through the native LSP diagnostics
local nvim_lint = require('lint')
-- FIXME: fallback on the default path if this one does not exist
--        I need to dynamically and recursively look for the closest
--        node_modules/ folders to look for the eslint binary
-- Check: https://github.com/mfussenegger/nvim-lint/issues/482
--
-- ⬇ maybe put these in my autocmd hook?
-- local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
-- local client = get_clients({ bufnr = 0 })[1] or {}
-- lint.try_lint(nil, { cwd = client.root_dir })
--------------------------------------------------------------------
local stylelint = nvim_lint.linters.stylelint
local eslint = nvim_lint.linters.eslint
stylelint.cmd = "./assets/node_modules/.bin/stylelint"
eslint.cmd = "./e2e/node_modules/.bin/eslint"
nvim_lint.linters_by_ft = {
  ruby = {'rubocop'},
  css = {'stylelint'},
  scss = {'stylelint'},
  javascript = {'eslint'},
  javascriptreact = {'eslint'},
  typescript = {'eslint'},
  typescriptreact = {'eslint'}
}
-- Autocmd to trigger linting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- ----- mason, mason-lspconfig & lspconfig -----
require("mason").setup()
require("mason-lspconfig").setup({
  automatic_installation = true
})

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  -- NOTE: these should already be set, but isn't
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'grr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gdd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
end

-- Setup lspconfig.
local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require('lspconfig')
lspconfig.ts_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.ruby_lsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
-- NOTE: should be able to use lexical/bin/start_lexical.sh but I get an error if
--       I use this, so I ended up using the one located in _build
--       |-> https://github.com/lexical-lsp/lexical/issues/799
local path_to_lexical = vim.fn.expand("~/dev/lexical/_build/dev/package/lexical/bin/start_lexical.sh")
lspconfig.lexical.setup({
  cmd = { path_to_lexical },
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function(fname)
    return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
  end,
  settings = {}
})


-- ----- gitsigns -----
require('gitsigns').setup()
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>gph', ':Gitsigns preview_hunk<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gbl', ':Gitsigns blame_line<CR>', opts)


-- ----- indentmini -----
require("indentmini").setup()


-- ----- scrollview -----
require('scrollview.contrib.gitsigns').setup()
require('scrollview').setup({
  excluded_filetypes = {},
  signs_on_startup = {'conflicts', 'cursor', 'diagnostics', 'loclist', 'marks', 'quickfix', 'search'},
  diagnostics_severities = {vim.diagnostic.severity.ERROR}
})


-- ----- treesitter -----
require('nvim-treesitter.configs').setup({
  ensure_installed = { "javascript", "ruby", "eex", "elixir", "erlang", "heex", "markdown", "markdown_inline", "html", "lua", "typescript" },
  highlight = { enable = true }
})

-- ----- treesitter-context -----
require('treesitter-context').setup{
  max_lines = 3,
  multiline_threshold = 2,
  trim_scope = 'inner',
}
-- Creates a fake bottom border under the context
vim.cmd([[
  hi TreesitterContextBottom gui=underline guisp=Grey
  hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
]])


-- ----- todo-comments -----
require("todo-comments").setup({
  keywords = {
    TODO = { icon = "⬣" },
    WARN = { icon = "▲" },
    FIXME = { icon = "▲" },
    NOTE = { icon = "⏺" },
  },
})

EOF
