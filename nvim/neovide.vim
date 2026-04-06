lua << EOF
if vim.g.neovide then
  vim.o.guifont = "JetbrainsMono Nerd Font:h14"

  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_short_animation_length = 0

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('i', '<D-v>', '<ESC>"+Pi') -- Paste insert mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
end
EOF
