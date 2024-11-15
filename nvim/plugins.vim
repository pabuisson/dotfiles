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
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
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
Plug 'tpope/vim-rhubarb' " vim-fugitive adapter for github
" Plug 'tommcdo/vim-fubitive' " vim-fugitive adapter for bitbucket
Plug 'tpope/vim-fugitive'
Plug 'dominikduda/vim_current_word'
Plug 'rhysd/conflict-marker.vim'

if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'mfussenegger/nvim-lint'

  Plug 'lewis6991/gitsigns.nvim'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/todo-comments.nvim'

  Plug 'backdround/global-note.nvim'

  Plug 'petertriho/nvim-scrollbar'

  Plug 'smoka7/hop.nvim'

  Plug 'lukas-reineke/indent-blankline.nvim'

  " -- nvim-cmp --
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " snippet engine (required for cmp)
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
else
  Plug 'mhinz/vim-signify'
endif

call plug#end()


" =======================
" === PLUGIN SETTINGS ===
" =======================

" " ----- ale -----
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {}

let g:ale_fix_on_save = 1
let g:ale_ruby_syntax_tree_executable = 'bundle'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['syntax_tree', 'prettier'],
\   'elixir': ['mix_format', 'trim_whitespace', 'remove_trailing_lines'],
\   'heex': ['mix_format', 'trim_whitespace', 'remove_trailing_lines'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\}


"----- conflict-marker -----
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
nmap <leader>gcn <Plug>(conflict-marker-next-hunk)
nmap <leader>gcp <Plug>(conflict-marker-prev-hunk)


" ----- current_word -----
let g:vim_current_word#highlight_delay = 800
highlight CurrentWord gui=bold cterm=bold
highlight CurrentWordTwins gui=underline cterm=underline

" " NOTE: below is the native way of doing this, but I couldn't get it to work
" " yet. Will need to dive deeper into this, maybe I can get rid of a plugin
" source: https://chaos.social/@scy/111570077753908537
"
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
nnoremap <leader>gb  :Git blame<CR>
nnoremap <leader>gdv :Gvdiffsplit<CR>
nnoremap <leader>gdh :Gdiffsplit<CR>


" ----- fzf -----
" Escape C-a and C-d in iTerm2 : https://github.com/junegunn/fzf.vim/issues/54
" ---
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

nnoremap <leader>fw :execute 'RgWord '.expand('<cword>')<CR>
nnoremap <leader>fW :execute 'RgWordExact '.expand('<cword>')<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :BCommits<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fo :BLines<CR>
ca rg Rg
ca rgw RgWordExact

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_commits_log_options = '--color=always --format="%C(auto)%h%d %C(green)%as %C(cyan)%an :: %C(reset)%s"'



" ---- vsnip ----
let g:vsnip_snippet_dir = expand("~/.config/nvim/snips")
" mappings
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" ==========================
"       NVIM SPECIFIC
" ==========================

if !has('nvim-0.5')
  finish
end


lua <<EOF
-- ----- global-note -----
-- NOTE: possibility to create a different file by project or git branch, dynamically.
--       Check https://github.com/backdround/global-note.nvim
local global_note = require("global-note")
global_note.setup({
  filename = "vim.md",
  directory = "~/Sync/MEGA/NOTES/",
})
vim.keymap.set("n", "<leader>n", global_note.toggle_note, {
  desc = "Toggle global note",
})

-- ----- hop -----
require('hop').setup()
vim.cmd([[
nnoremap <leader>jw :HopWord<CR>
nnoremap <leader>jc :HopCamelCase<CR>
]])


-- ----- lint -----
-- Solution to use external linters through the native LSP diagnostics
local nvim_lint = require('lint')
-- FIXME: fallback on the default path if this one does not exist
--        I need to dynamically and recursively look for the closest
--        node_modules/ folders to look for the eslint binary
--
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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- ----- cmp -----

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require('cmp')
cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }, {
    { name = 'buffer' },
    { name = 'path' }
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        luasnip = "[SNP]",
        vsnip = "[SNP]",
        nvim_lua = "[LUA]",
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
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- JS / TS
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
-- Ruby
lspconfig.ruby_lsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
-- Elixir
local path_to_elixirls = vim.fn.expand("~/dev/elixir-ls/release/language_server.sh")
lspconfig.elixirls.setup({
  cmd = { path_to_elixirls },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false
    }
  }
})

-- ----- gitsigns -----
require('gitsigns').setup()


-- ----- indent-blankline ----
require("ibl").setup({
  indent = {
    char = "│"
    -- char = "┃" thicker center-aligned char, see :help ibl.config.indent.char for more alternatives
  }
})

-- ----- scrollbar -----
require('scrollbar.handlers.gitsigns').setup()
require('scrollbar').setup()


-- ----- treesitter -----
require('nvim-treesitter.configs').setup({
  ensure_installed = { "javascript", "ruby", "eex", "elixir", "erlang", "heex", "markdown", "markdown_inline", "html", "lua" },
  highlight = { enable = true }
})

require'treesitter-context'.setup{
  max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  multiline_threshold = 2,  -- Maximum number of lines to show for a single context
  trim_scope = 'inner',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
}
-- Creates a fake bottom border under the context
vim.cmd([[
  hi TreesitterContextBottom gui=underline guisp=Grey
  hi TreesitterContextLineNumberBottom gui=underline guisp=Grey
]])


-- ----- todo-comments -----
require("todo-comments").setup({
  keywords = {
    TODO = { icon = "⏺" },
    WARN = { icon = "⏺" },
    NOTE = { icon = "⏺" },
  },
  highlight = {
    pattern = [[.*<(KEYWORDS):?\s+]], -- pattern or table of patterns, used for highlighting (vim regex)
  },
})

EOF
