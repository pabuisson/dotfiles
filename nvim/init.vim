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

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
augroup END

lua << EOF


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
