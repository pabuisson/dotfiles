" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

if !has('nvim-0.5')
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  color OceanicNext
  finish
endif

" " -- edge --
" set bg=dark
" let g:edge_style = 'neon'
" let g:edge_better_performance = 1
" let g:edge_disable_italic_comment = 1
" color edge
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#444466 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#444466 guibg=NONE'

" " -- everforest --
" " -- palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
" set bg=dark
" let g:everforest_disable_italic_comment = 1
" let g:everforest_background = 'hard'
" " standard hard dark :
" " fg:  ['#d3c6aa', '223']
" " bg0: ['#2b3339',   '235'],
" let g:everforest_colors_override = {
" \ 'fg':  ['#d8d8d6', '223'],
" \ 'bg0': ['#202326', '235']
" \}
" color everforest

" -- kanagawa --
lua << EOF
-- color palette: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
require('kanagawa').setup({
    undercurl = true,
    commentStyle = { italic = false },
    functionStyle = { bold = true },
    keywordStyle = { italic = false },
    statementStyle = { bold = true },
    colors = {
      palette = {
          fujiWhite = "#dbd8c5",  -- a bit less saturated
          fujiGray = "#6a6b77",   -- more blue-ish, less brown-ish
      }
    }
})
vim.cmd('color kanagawa-wave')
EOF

" " -- oceanic next --
" let g:oceanic_next_terminal_bold = 1
" color OceanicNext
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#444466 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#444466 guibg=NONE'

" " -- onedark --
" lua << EOF
" vim.cmd("set bg=dark")
" require('onedark').setup {
"   -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
"   style = 'cool',
"   code_style = {
"     keywords = 'bold',
"   },
"   colors = {
"     fg = '#ebebee',
"     grey = '#5f6e87'
"   },
" }
" require('onedark').load()
" EOF
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#444466 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#444466 guibg=NONE'

" ---------------------

" " -- edge --
" set bg=light
" let g:edge_style = 'neon'
" let g:edge_better_performance = 1
" let g:edge_disable_italic_comment = 1
" color edge
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c0c9 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c0c9 guibg=NONE'

" " -- everforest --
" " palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
" set bg=light
" let g:everforest_background = 'hard'
" let g:everforest_colors_override = {
" \ 'fg':  ['#526068', '242'],
" \ 'bg0': ['#fefffc', '230'],
" \}
" color everforest
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c9c0 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c9c0 guibg=NONE'

" " -- onedark --
" lua << EOF
" vim.cmd("set bg=light")
" require('onedark').setup {
"   -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
"   style = 'light',
"   colors = {
"     fg = '#555566',
"     green = '#5a9e58',
"     red = '#c65959',
"     blue = '#275ad1',
"     yellow = '#ce993d'
"   },
" }
" require('onedark').load()
" EOF
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c0c9 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c0c9 guibg=NONE'
