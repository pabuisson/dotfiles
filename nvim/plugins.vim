filetype off
call plug#begin('~/.config/nvim/plugged')

" --- Color schemes ---
Plug 'sainnhe/everforest'

if has('nvim')
  Plug 'rebelot/kanagawa.nvim'
  Plug 'navarasu/onedark.nvim'
endif
" --- Filetype related ---
" Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

" --- Plugins ---
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
  Plug 'saghen/blink.cmp', {'tag': 'v1.5.1'}
  " -- formatter --
  Plug 'stevearc/conform.nvim'

  " -- plenary and plugins depending on it --
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/todo-comments.nvim'
  " -- codecompanion.nvim --
  " depends on plenary and treesitter
  Plug 'github/copilot.vim'
  Plug 'olimorris/codecompanion.nvim', { 'branch': 'main' }

  " -- other plugins --
  Plug 'echasnovski/mini.tabline'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'smoka7/hop.nvim'
  Plug 'nvimdev/indentmini.nvim'
  Plug 'stevearc/aerial.nvim'
  Plug 'dstein64/nvim-scrollview'
endif

call plug#end()


" =======================
" === PLUGIN SETTINGS ===
" =======================

" " ----- ale -----
" NOTE: I've already migrated linting to nvim-lint, and I'm currently in the
" process of migrating formatting to conform.nvim. ale is great but does a lot
" of things (lint, fix, LSP...) and either I only use it, or I stop using it
" altogether.
" FIXME: (2025-07-11) can't migrate mix format yet, it prepends log lines to the formatted files
"       look into it and maybe configure differently or make a PR to conform.nvim
let g:ale_linters_explicit = 1
let g:ale_linters = {}
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'elixir': ['mix_format'],
\   'heex': ['mix_format'],
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
command -nargs=* RgWordWithArg
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always -- '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview(), 0)

command -nargs=* RgWordExactWithArg
  \ call fzf#vim#grep(
  \   'rg -F -w --column --line-number --no-heading --color=always -- '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview(), 0)

command -nargs=* RgDefWithArg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always "^\s*\b(def|defp|defmodule)\b [\w\.]*\b'.<q-args>.'\b"',
  \   1,
  \   fzf#vim#with_preview(), 0)

command -nargs=* RgDefFn
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always "^\s*\b(def|defp)\b"',
  \   1,
  \   fzf#vim#with_preview(), 0)

command -nargs=* RgDefMod
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always "^\s*\bdefmodule\b"',
  \   1,
  \   fzf#vim#with_preview(), 0)

command -nargs=* RgFindReferencesWithArg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --pcre2 "^(?!(.*\b(def|defp|defmodule|alias|require|spec)\b)|(\s*#)).*\b'.<q-args>.'\b"', 1,
  \   fzf#vim#with_preview(), 0)
nnoremap <leader>fw :execute 'RgWordWithArg '.expand('<cword>')<CR>
nnoremap <leader>fW :execute 'RgWordExactWithArg '.expand('<cword>')<CR>
nnoremap <leader>fd :execute 'RgDefWithArg '.expand('<cword>')<CR>
nnoremap <leader>fr :execute 'RgFindReferencesWithArg '.expand('<cword>')<CR>
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
  enabled = function()
    return not vim.tbl_contains({ "gitcommit" }, vim.bo.filetype)
  end,
  keymap = { preset = 'enter' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'omni' },
  },
})


-- ----- codecompanion -----
require("codecompanion").setup()
vim.keymap.set("n", "<leader>ccc", "<cmd>CodeCompanionChat<CR>")


-- ----- conform -----
-- FIXME: (2025-07-11) can't use mix format right now, it prepends log lines to the formatted files
--       look into it and maybe configure differently or make a PR to conform.nvim
require("conform").setup({
  formatters_by_ft = {
    -- elixir = { 'mix' },
    -- heex = { 'mix' },
    ruby = { 'syntax_tree' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    ['*'] = { 'trim_whitespace', 'trim_newlines' }
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
})


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
  elixir = {'credo'},
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
    -- Don't throw an error if linter is missing or fails
    require("lint").try_lint(nil, { ignore_errors = true })
  end,
})
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)


-- ----- lsp: mason, mason-lspconfig -----
require("mason").setup()
require("mason-lspconfig").setup()
-- Enable the LSP servers I do use
vim.lsp.enable({'ruby_lsp', 'nextls', 'ts_ls'})
-- Customize key mappings when LSP gets attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { noremap=true, silent=true }
    local keymap_opts = { buffer = args.buf, noremap = true, silent = true }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Redefine LSP and diagnostics keymappings
    vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gdd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', opts)
    -- Remapping K to customize the hover border
    -- TODO: what's the difference between vim.keymap.set and vim.api.nvim_buf_set_keymap
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({ border = 'single' })
    end)
  end
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

-- ----- (mini.)tabline -----
require('mini.tabline').setup()


-- ----- treesitter -----
require('nvim-treesitter.configs').setup({
  -- NOTE: yaml, markdown and markdown_inline are required for CodeCompanion
  ensure_installed = { "javascript", "ruby", "eex", "elixir", "erlang", "heex", "markdown", "markdown_inline", "html", "lua", "typescript", "yaml" },
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
