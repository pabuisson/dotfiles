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
" --  --
" colorscheme Gruvbox
" set bg=dark
" let g:gruvbox_contrast_dark='hard'
" " let g:gruvbox_contrast_light='soft'
" let g:gruvbox_bold=0
" -- Yowish --
color yowish
let g:yowish = {
\ 'agit':  0,
\ 'ctrlp': 0,
\ 'unite': 0,
\ 'nerdtree': 0
\ }
let g:lightline.colorscheme='yowish'
" -- One half dark --
" color onehalfdark
" let g:lightline.colorscheme='onehalfdark'
" -- Oceanic Next --
" set bg=dark
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext
" -- Ayu --
" " let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" " let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
" -- Palenight --
" colorscheme palenight
" let g:lightline.colorscheme='materia'
" let g:palenight_terminal_italics=1


