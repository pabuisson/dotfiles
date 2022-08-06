" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

if !has('nvim-0.5')
  color OceanicNext
  finish
endif


" " -- everforest --
" set bg=dark
" let g:everforest_background = 'hard'
" " standard hard dark : fg = ['#d3c6aa',   '223']
" let g:everforest_colors_override = {
"       \ 'fg': ['#d8d0c0', '223'],
"       \}
" color everforest

" " -- oceanic-next --
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext
" " hi link BufTabLineCurrent PmenuSbar
" hi link BufTabLineActive PmenuSbar
" hi link BufTabLineHidden Pmenu
" hi link BufTabLineFill StatusLine

" -- onedark --
set bg=dark
lua << EOF
require('onedark').setup {
  -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  style = 'cool',
  code_style = {
    keywords = 'bold',
  },
  colors = {
    fg = '#cbcbcb',
    grey = '#536177'
  },
}
require('onedark').load()
EOF

" " -- palenight --
" let g:palenight_terminal_italics=1
" color palenight

" ---------------------

" " -- everforest --
" set bg=light
" let g:everforest_background = 'hard'
" colorscheme everforest
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
