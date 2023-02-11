" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

if !has('nvim-0.5')
  color OceanicNext
  finish
endif

" -- deus --
set background=dark    " Setting dark mode
color deus

" " -- everforest --
" set bg=dark
" let g:everforest_disable_italic_comment = 1
" let g:everforest_background = 'hard'
" " standard hard dark :
" " fg:  ['#d3c6aa', '223']
" " bg0: ['#2b3339',   '235'],
" let g:everforest_colors_override = {
" \ 'fg':  ['#d8d0c0', '223'],
" \ 'bg0': ['#202529', '235']
" \}
" color everforest

" " -- kanagawa --
" lua << EOF
" -- color palette: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
" vim.cmd("set bg=dark")
" require('kanagawa').setup({
"     undercurl = true,
"     commentStyle = { italic = false },
"     functionStyle = { bold = true },
"     keywordStyle = { italic = false },
"     statementStyle = { bold = true },
"     specialReturn = true,       -- special highlight for the return keyword
"     specialException = true,    -- special highlight for exception handling keywords
"     colors = {
"       fujiWhite = "#dbd8c5",  -- a bit less saturated
"       fujiGray = "#6a6b77",   -- more blue-ish, less brown-ish
"     },
"     overrides = {},
" })
" vim.cmd('color kanagawa')
" EOF

" " -- oceanic-next --
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext
" " hi link BufTabLineCurrent PmenuSbar
" hi link BufTabLineActive PmenuSbar
" hi link BufTabLineHidden Pmenu
" hi link BufTabLineFill StatusLine

" " -- onedark --
" lua << EOF
" vim.cmd("set bg=dark")
" require('onedark').setup {
"   -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
"   style = 'cool',
"   code_style = {
"     functions = 'bold',
"     keywords = 'bold',
"     comments = 'none',
"   },
"   colors = {
"     fg = '#cbcbcb',
"     grey = '#5f6e87'
"   },
" }
" require('onedark').load()
" EOF

" ---------------------

" " -- everforest --
" set bg=light
" let g:everforest_background = 'hard'
" " standard hard light 'bg0': ['#fff9e8',   '230'],
" let g:everforest_colors_override = {
" \ 'bg0': ['#fffef4', '230']
" \}
" color everforest
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
