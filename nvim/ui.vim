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

" -- Gruvbox --
" colorscheme Gruvbox
" set bg=dark
" let g:gruvbox_contrast_dark='hard'
" " let g:gruvbox_contrast_light='soft'
" let g:lightline.colorscheme='gruvbox'

" -- One half dark --
" color onehalfdark
" let g:lightline.colorscheme='onehalfdark'

" -- Oceanic Next --
" set bg=dark
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext
" let g:lightline.colorscheme='oceanicnext'

" -- Ayu --
" " let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" " let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
" let g:lightline.colorscheme='wombat'

" -- Palenight --
colorscheme palenight
let g:lightline.colorscheme='one'
let g:palenight_terminal_italics=1

" -- Two firewatch --
" set bg=dark
" let g:two_firewatch_italics=1
" colorscheme two-firewatch
" let g:lightline.colorscheme='twofirewatch'
