" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

if !has('nvim-0.5')
  color OceanicNext
  finish
endif

" " -- dracula --
" set bg=dark
" color dracula

" -- everforest --
set bg=dark
let g:everforest_background = 'hard'
color everforest

" " -- gruvbox-material --
" set background=dark
" " Set contrast. Available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'hard'
" color gruvbox-material

" " -- nightfox
" lua <<EOF
" local nightfox = require('nightfox')
" -- This function set the configuration of nightfox. If a value is not passed in the setup function
" -- it will be taken from the default configuration above
" nightfox.setup({
"   fox = "duskfox", -- change the colorscheme to use nordfox
" })
" nightfox.load()
" EOF

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

" " -- palenight --
" color palenight
" let g:palenight_terminal_italics=1

" ---------------------

" " -- everforest --
" set bg=light
" let g:everforest_background = 'hard'
" colorscheme everforest
" let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'
" let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c6c6c6 guibg=NONE'

" " -- gruvbox-material --
" set background=light
" " Set contrast. Available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'hard'
" color gruvbox-material
