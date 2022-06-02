" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

if !has('nvim-0.5')
  color OceanicNext
  finish
endif

" set bg=dark
" -- everforest --
set bg=dark
let g:everforest_background = 'hard'
color everforest


" " -- nord --
" let g:nord_italic_comments = 1
" color nord

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
" require('onedark').setup {
"   -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
"   style = 'cool',
"   -- Change code style ---
"   -- Options are italic, bold, underline, none
"   -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
"   code_style = {
"     comments = 'none',
"     keywords = 'bold',
"   },
"   -- Customize colors
"   colors = {
"     fg = '#cccccc'
"   },
" }
" require('onedark').load()
" EOF

" -- palenight --
let g:palenight_terminal_italics=1
color palenight

" ---------------------

" " -- everforest --
" set bg=light
" let g:everforest_background = 'hard'
" colorscheme everforest
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
