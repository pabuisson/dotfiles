" vim: foldmethod=marker

lua << EOF

-- Package list {{{
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
  -- VIM PLUGINS
  gh('tpope/vim-surround'),
  gh('tpope/vim-repeat'),
  gh('tpope/vim-eunuch'),
  gh('tpope/vim-rhubarb'),
  gh('tpope/vim-fugitive'),
  gh('tpope/vim-projectionist'),
  gh('dominikduda/vim_current_word'),
  gh('dense-analysis/ale'),
  gh('junegunn/fzf'),
  gh('junegunn/fzf.vim'),
  -- THEMES
  -- gh('sainnhe/everforest'),
  gh('projekt0n/github-nvim-theme'),
  gh('rebelot/kanagawa.nvim'),
  gh('navarasu/onedark.nvim'),
  -- NEOVIM STANDALONE
  -- gh('stevearc/aerial.nvim'),
  -- gh('dstein64/nvim-scrollview'),
  gh('stevearc/conform.nvim'),
  gh('sindrets/diffview.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('smoka7/hop.nvim'),
  gh('nvimdev/indentmini.nvim'),
  gh('echasnovski/mini.tabline'),
  { src = gh('saghen/blink.cmp'), version = 'v1.10.0' },
  -- TREESITTER
  -- LSP & TREESITTER
  gh('nvim-treesitter/nvim-treesitter'),
  gh('nvim-treesitter/nvim-treesitter-context'),
  gh('williamboman/mason.nvim'),
  -- NOTE: should not be needed anymore
  -- gh('williamboman/mason-lspconfig.nvim'),
  gh('neovim/nvim-lspconfig'),
  gh('mfussenegger/nvim-lint'),
  -- PLUGINS WITH DEPS
  gh('nvim-lua/plenary.nvim'),
  -- depends on plenary and treesitter
  gh('zbirenbaum/copilot.lua'),
  gh('giuxtaposition/blink-cmp-copilot'),
  { src = gh('olimorris/codecompanion.nvim'), version = 'main' }
})
-- }}}

-- Post install {{{
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'fzf' then
      vim.fn.call('fzf#install', {})
    end

    if ev.data.spec.name == 'nvim-treesitter' then
      vim.cmd('TSUpdate')
    end
  end
})
-- }}}


-- ---------------------------------------------------------------------------
--  NOTE: migrating to vim.pack + updating config for neovim 0.12
--        still not sure if I get rid of these ones, or not
--
-- Plug 'elixir-editors/vim-elixir', { 'for': ['elixir', 'heex'] }
-- Plug 'kevinhwang91/nvim-hlslens'
-- ---------------------------------------------------------------------------

EOF


"" =======================
""     PLUGIN SETTINGS
"" =======================

" " ----- ale ----- {{{
" NOTE: I've already migrated linting to nvim-lint, and I'm currently migrating
"       formatting to conform.nvim. ale is great but does a lot of things (lint,
"       fix, LSP...) and either I only use it, or I stop using it entirely.
" FIXME: (2025-07) can't migrate mix format yet, it prepends log lines to the
"        formatted files look into it and maybe configure differently or make
"        a PR to conform.nvim
let g:ale_linters_explicit = 1
let g:ale_linters = {}
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'elixir': ['mix_format'],
\   'heex': ['mix_format'],
\   'eelixir': ['mix_format']
\}
" }}}

lua << EOF
-- ----- vim_current_word ----- {{{
vim.api.nvim_set_hl(0, "CurrentWord", { underline=true, bold=true }),
vim.api.nvim_set_hl(0, "CurrentWordTwins", { underline=true, bold=true })
-- }}}

-- ----- fugitive.vim ----- {{{
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>gst', ':Git<CR>', opts)
vim.keymap.set('n', '<leader>gci', ':Git commit<CR>', opts)
vim.keymap.set('n', '<leader>gr',  ':Gread<CR>', opts)
vim.keymap.set('n', '<leader>gw',  ':Gwrite<CR>', opts)
vim.keymap.set('n', '<leader>gbf', ':Git blame<CR>', opts)
vim.keymap.set('n', '<leader>gdv', ':Gvdiffsplit<CR>', opts)
vim.keymap.set('n', '<leader>gdh', ':Gdiffsplit<CR>', opts)
-- }}}
EOF

" ----- fzf / fzf.vim ----- {{{
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
command -nargs=* RgWithArg
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always -- '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview(), 0)

command -nargs=* RgExactWithArg
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
  \   'rg --column --line-number --no-heading --color=always "^\s*\b(def|defp|defmacro)\b"',
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
nnoremap <leader>fw :execute 'RgWithArg '.expand('<cword>')<CR>
nnoremap <leader>fW :execute 'RgExactWithArg '.expand('<cword>')<CR>
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
ca rgw RgExact
" }}}


" ----- projectionist -----
nnoremap <leader>a :A<CR>


" ==========================
"       NVIM SPECIFIC
" ==========================

lua <<EOF

-- ----- neovim built-in ----- {{{
-- avoids many “Press ENTER” interruptions
-- avoids delays from warnings like W10
-- highlights the command line as you type
-- exposes the pager as a regular buffer + window
require('vim._core.ui2').enable({
  enable = true
})
-- }}}

-- -- ----- aerial ----- {{{
-- -- NOTE: neovim LSP is supposed to provide this but I couldn't get it to work yet.
-- -- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.document_symbol()
-- require("aerial").setup({
--   layout = {
--     min_width = 20,
--     width = 0.2,
--     max_width = 50
--   },
--   nerd_font = true,
--   post_jump_cmd = "normal! zt",
-- })
-- vim.keymap.set("n", "<leader>ft", "<cmd>call aerial#fzf()<CR>")
-- vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")
-- }}}

-- ----- blink ----- {{{
require("blink.cmp").setup({
  enabled = function()
    return not vim.tbl_contains({ "gitcommit" }, vim.bo.filetype)
  end,
  keymap = { preset = 'enter' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'omni', 'copilot' },
    per_filetype = {
      crystal = { 'path', 'snippets', 'buffer', 'cmdline', 'omni', 'copilot' },
    },
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      },
    },
  },
  completion = {
    menu = { border = 'single' },
    documentation = { window = { border = 'single' } },
    -- https://cmp.saghen.dev/configuration/completion#list
    list = {
      selection = { preselect = true, auto_insert = false }
    },
  },
  signature = {
    window = { border = 'single' }
  },
})
-- }}}

-- ----- codecompanion & copilot ----- {{{
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    elixir = true,
    ruby = true,
    ["*"] = false
  }
})
require("codecompanion").setup({
  tools = {
    ["file_search"] = {
      opts = { require_cmd_approval = false, },
    },
    ["grep_search"] = {
      opts = {
        require_approval_before = true,
        require_cmd_approval = true,
      }
    }
  }
})
vim.keymap.set("n", "<leader>ccc", "<cmd>CodeCompanionChat<CR>")
-- }}}

-- ----- conform ----- {{{
-- FIXME: (2025-07) can't use mix format right now, it prepends log lines to the formatted files
--       look into it and maybe configure differently or make a PR to conform.nvim
require("conform").setup({
  formatters_by_ft = {
    -- elixir = { 'mix' },
    -- heex = { 'mix' },
    ruby = { 'syntax_tree' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    css = { 'prettier' },
    scss = { 'prettier' },
    ['*'] = { 'trim_whitespace', 'trim_newlines' }
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
})
-- }}}

-- ---- diffview ---- {{{
require('diffview').setup({
  use_icons = false,
  enhanced_diff_hl = true,
  file_panel = {
    listing_style = 'list',  -- 'list' or 'tree'
  }
})
vim.keymap.set('n', '<leader>dvo', '<cmd>DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>dvc', '<cmd>DiffviewClose<CR>')
-- }}}

-- ----- hop ----- {{{
require('hop').setup()
vim.keymap.set("n", "<leader>jw", "<cmd>HopWord<CR>")
vim.keymap.set("n", "<leader>jl", "<cmd>HopLine<CR>")
vim.keymap.set("n", "<leader>jc", "<cmd>HopCamelCale<CR>")
-- }}}

-- -- ----- hslens ----- {{{
-- -- TODO: still not sure if I keep this one, migrate to another one, or drop entirely
-- require('hlslens').setup()
-- local kopts = {noremap = true, silent = true}
-- vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
-- vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
-- }}}

-- ----- lint ----- {{{
-- Solution to use external linters through the native LSP diagnostics
local nvim_lint = require('lint')
-- FIXME: fallback on the default path if phoenix one does not exist
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
eslint.cmd = "./assets/node_modules/.bin/eslint"
nvim_lint.linters_by_ft = {
  -- TODO: can I add rubocop back?
  ruby = {},
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
-- }}}

-- ----- LSP: mason, and lspconfig ----- {{{
require("mason").setup()
-- -- TODO: still not sure if I keep this one, migrate to another one, or drop entirely
-- require("mason-lspconfig").setup()
-- -- Enable the LSP servers I do use
-- vim.lsp.enable({'ruby_lsp', 'expert', 'ts_ls'})

-- Enable installed LSP servers: maps the LSP name to the config name
-- to be able to call the builtin `vim.lsp.enable` for the config
-- Replaces mason-lspconfig, more or less
-- src: https://www.reddit.com/r/neovim/comments/1p0a576/comment/nphwtrg/
-- another src: https://www.reddit.com/r/neovim/comments/1p1y73n/automatically_downloading_and_installing_lsps/
local installed_packs = require("mason-registry").get_installed_packages()
local lsp_config_names = vim.iter(installed_packs):fold({}, function(acc, pack)
	table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
	return acc
end)
vim.lsp.enable(lsp_config_names)
-- Customize key mappings when LSP gets attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- NOTE: to check if a LSP feature is available
    -- local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- if client:supports_method('textDocument/implementation') then

    local opts = { buffer = args.buf, noremap = true, silent = true }

    -- FIXME: do I even use this?
    -- -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Redefine LSP and diagnostics keymappings
    vim.keymap.set('n', 'grd', function()
      vim.lsp.buf.definition()
      vim.cmd('normal! zt') -- move the definition to the top of screen
    end, opts)

    -- Remap K to customize the hover border
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({ border = 'rounded' })
      end, opts)
  end
})
-- }}}

-- ----- gitsigns ----- {{{
local gitsigns = require('gitsigns')
gitsigns.setup({
  preview_config = { border = 'single' }
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>hj', function() gitsigns.nav_hunk('next') end, opts)
vim.keymap.set('n', '<leader>hk', function() gitsigns.nav_hunk('prev') end, opts)
vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, opts)
vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, opts)
vim.keymap.set('n', '<leader>bf', function() gitsigns.blame_line({ full = true }) end, opts)
-- Other features that could be useful / replace other plugins
-- vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, opts)
-- vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, opts)
-- }}}

-- ----- indentmini ----- {{{
require("indentmini").setup()
-- }}}

-- -- TODO: still not sure if I keep this one, migrate to another one, or drop entirely
-- -- ----- scrollview ----- {{{
-- require('scrollview.contrib.gitsigns').setup()
-- require('scrollview').setup({
--   excluded_filetypes = {},
--   signs_on_startup = { 'conflicts', 'cursor', 'diagnostics', 'keywords', 'marks', 'search' },
--   diagnostics_severities = { vim.diagnostic.severity.WARN }
-- })
-- }}}

-- ----- mini.tabline ----- {{{
require('mini.tabline').setup()
-- }}}

-- ----- treesitter ----- {{{
require('nvim-treesitter').install({
  'javascript', 'typescript', 'html',
  'elixir', 'eex', 'erlang', 'heex',
  'ruby',
  'markdown', 'markdown_inline',
  'lua',
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript', 'typescript', 'html', 'css',
    'elixir', 'heex',
    'ruby',
    'markdown',
    'lua'
  },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
-- }}}

-- ----- treesitter-context ----- {{{
require('treesitter-context').setup({
  max_lines = 3,
  multiline_threshold = 2,
  trim_scope = 'inner',
})
-- Creates a fake bottom border under the context
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  callback = function(args)
    -- NOTE: ensures the 'fg' used in highlights is updated when I switch theme
    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true, sp='fg' })
    vim.api.nvim_set_hl(0, 'TreesitterContextLineNumberBottom', { underline = true, sp='fg' })
  end
})
-- }}}
EOF
