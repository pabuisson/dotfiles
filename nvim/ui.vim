" ====================
" === UI SETTINGS ====
" ====================

" vim-gitgutter : always good-looking gutter column
highlight clear SignColumn
au ColorScheme * highlight clear SignColumn

" Enable true colors for better colorschemes
" For neovim > 0.1.5
set termguicolors


" Default colorscheme

" " -- Palenight --
" colorscheme palenight
" let g:palenight_terminal_italics=1

" " -- challenger_deep --
" set bg=dark
" color challenger_deep

" -- Gruvbox --
" " let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_contrast_light='soft'
" colorscheme Gruvbox
" set bg=dark

" -- Ayu --
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" -- Nord --
" colorscheme nord
" let g:nord_italic = 1
" let g:nord_italic_comments = 1
" let g:nord_comment_brightness = 2

" -- Oceanic Next --
" set bg=dark
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext

" -- Dracula --
" set bg=dark
" colorscheme dracula

" -- Deep space --
" let g:deepspace_italics=1
" set bg=dark
" colorscheme deep-space

" ---------------------

" -- Ayu light --
" let ayucolor="light"  " for light version of theme
" colorscheme ayu

" -- flattened light --
" colorscheme flattened_light
