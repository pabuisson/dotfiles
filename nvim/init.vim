" ============================================================
"                   — NEOVIMRC FILE —
"
" The original .vimrc file is stored under ~/.vim directory.
" I use a symbolic link to link ~/.vimrc to this location.
"
" ============================================================

source $HOME/.config/nvim/statusline.vim
source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/ui.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/neovide.vim


" ================
" === SETTINGS ===
" ================

set number          "display line numbers
set nobackup        "don't write backup files
set noswapfile      "don't write swap files (careful, all text will be in memory !)
set autowrite       "auto write to buffer when switching
set linebreak       "don't cut words at the end of lines
set nowrap          "don't wrap long lines
set colorcolumn=120
set cursorline      "highlight current line
let g:netrw_list_hide= '\.DS_Store$, *\.scssc$, *\.sassc$, \.sass-cache\/'
set ignorecase      "ignore case for search and such
set smartcase       "don't ignore case if there's an uppercase letter in the pattern
set scrolloff=4     "displays at least 4 lines around the cursor even when top/bottom of screen
set clipboard+=unnamed
set showmatch       "show matching parenthese
set foldcolumn=auto "show folding column
set signcolumn=yes
" Which column to wrap at with `gq`
set textwidth=90
set formatoptions-=t
set modeline
set modelines=2
" === HIDDEN/NON VISIBLE CHARS ===
" multispace option allows to emulate indent lines without needing a dedicated plugin
" source: https://github.com/thaerkh/vim-indentguides
set list
setlocal listchars=tab:▸\ ,eol:·
" === INDENTATION ===
set shiftwidth=2
set tabstop=2       "number of spaces a TAB char counts for (when encountered in a file)
set softtabstop=2   "number of spaces a TAB char counts for (when performing editing operations)
set expandtab       "always use spaces instead of tabs
set shiftround      "always round indentation level to a multiple of the number of spaces
" === LOAD/SAVE VIEWS ===
set viewoptions=cursor
augroup bufferloadsave
  autocmd!
  autocmd BufWinLeave *.* if &filetype !=# 'gitcommit' | mkview! | endif
  autocmd BufWinEnter *.* if &filetype !=# 'gitcommit' | silent! loadview | endif
augroup END
" === FILETYPE SPECIFICS THAT DO NOT HAVE THEIR OWN FT CONFIG FILE ===
augroup filetypes
  autocmd!
  " Cheatsheets are Markdown files with the .cheatmd extension
  " reference: https://elixirforum.com/t/cheatsheets-in-exdoc-v0-29/51255
  autocmd BufNewFile,BufRead *.cheatmd set filetype=markdown
augroup END

" === GENERIC ABBREVIATIONS ===
iabbr >> »
iabbr --> →
iabbr <-- ←

lua << EOF


-- --------------------------------------
-- ----- DIAGNOSTIC CONFIGURATION   -----
-- ----- USED BY NVIM-LINT AND SUCH -----
-- --------------------------------------
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dj', vim.diagnostic.get_next, opts)
vim.keymap.set('n', '<leader>dk', vim.diagnostic.get_prev, opts)

-- Some more diagnostics tuning, initially copy-pasted and adapted from
-- https://tduyng.com/blog/neovim-basic-setup/#my-diagnostics-configuration
vim.api.nvim_set_hl(0, "DiagnosticErrorLine",{ bg = '#51202a', blend = 20 })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = '#3b3b1b', blend = 15 })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = '#1f3342', blend = 10 })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = '#1e2e1e', blend = 10 })
vim.diagnostic.config({
  -- keep underline & severity_sort on for quick scanning
  underline = true,
  severity_sort = true,
  update_in_insert = false, -- less flicker
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  -- Nvim 0.11+ — dim whole line
  linehl = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
    [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
    [vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
    [vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
  },
})


-- ------------------------------------------
-- ----- BRIEFLY HIGHLIGHT YANKED TEXT -----
-- ------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ timeout=400 })
  end
})


-- ---------------------------------
-- HIGHLIGHT TODO, NOTE, FIXME, ETC.
-- ---------------------------------
--
-- NOTE: for a cleaner version (for instance, to avoid highlighting todos
--       when they're not part of a comment), would need to use Treesitter.
--       But this version should be good enough for now.

local function set_todo_highlights()
  vim.api.nvim_set_hl(0, 'TodoComment', { fg = '#ff9800', bold = true, bg = 'bg' })
  vim.api.nvim_set_hl(0, 'FixmeComment', { fg = '#f44336', bold = true, bg = 'bg' })
  vim.api.nvim_set_hl(0, 'NoteComment', { fg = '#2196f3', bold = true, bg = 'bg' })
end

local ns = vim.api.nvim_create_namespace("todo_highlight")
local patterns = {
  TODO = "TodoComment",
  FIXME = "FixmeComment",
  NOTE = "NoteComment",
}

local function highlight_todos(bufnr)
  -- Remove former extmarks
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for lnum, line in ipairs(lines) do
    for keyword, hl in pairs(patterns) do
      local from = 1
      while true do
        -- match "TODO:" / "FIXME:" / "NOTE:"
        local start_col, end_col = line:find(keyword .. ":", from)
        if not start_col then break end

        -- extmarks are bound to the buffer and don't disappear
        -- when opening a split, for instance
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, start_col - 1, {
          end_col = start_col + #keyword,
          hl_group = hl,
        })

        from = end_col + 1
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "WinNew", "TextChanged", "BufWritePost" }, {
  callback = function(args)
    -- NOTE: setting the highlights on every event is a bit too much,
    --       but they kept getting clearer by "something" when I
    --       use splits for instance, and I lose all highlighting
    set_todo_highlights()
    highlight_todos(args.buf)
  end,
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function(args)
    -- NOTE: ensures the "bg" used in highlights is updated when I switch theme
    set_todo_highlights()
  end
})

EOF
