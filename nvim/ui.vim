" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
" For neovim > 0.1.5
set termguicolors


" Default colorscheme

" " -- Palenight --
" color palenight
" let g:palenight_terminal_italics=1

" " -- challenger_deep --
" set bg=dark
" color challenger_deep

" -- Gruvbox --
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
color Gruvbox
set bg=dark
" hi Normal guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE

" " -- Ayu --
" " let ayucolor="mirage" " mirage version of theme
" let ayucolor="dark"   " dark version of theme
" color ayu

" " -- Nord --
" let g:nord_italic = 1
" let g:nord_italic_comments = 1
" color nord

" -- Iceberg --
" color iceberg

" " -- Dracula --
" set bg=dark
" color dracula

" " -- night owl --
" color night-owl
" hi link BufTabLineActive Pmenu
" hi link BufTabLineHidden Pmenu
" hi link BufTabLineFill Pmenu
" " TODO: more distinctive colors maybe?
" " TODO: PR this to nightowl https://github.com/haishanh/night-owl.vim/pulls
" hi DiffAdd ctermfg=149 ctermbg=NONE guifg=#addb67 guibg=NONE
" hi DiffChange ctermfg=222 ctermbg=NONE guifg=#ecc48d guibg=NONE
" hi DiffDelete ctermfg=204 ctermbg=NONE guifg=#ff5874 guibg=NONE

" " -- yowish --
" " https://github.com/KabbAmine/yowish.vim#custom-color-palette-
" let g:yowish = {}
" let g:yowish.term_italic = 1
" let g:yowish.comment_italic = 1
" let g:yowish.colors = {
" \  'background' : ['#1b1d23', 'none'],
" \  'backgroundDark' : ['#1b1d23', 'none'],
" \ }
" color yowish

" " -- oceanic-next --
" let g:oceanic_next_terminal_italic = 1
" color OceanicNext

" " -- one --
" let g:one_allow_italics = 1 " I love italic for comments
" color one

" " -- nightfly --
" let g:nightflyItalics = 0
" color nightfly
" hi NonText guifg=#4b6479 guibg=NONE

" " -- edge --
" " let g:edge_style = 'neon'
" set background=dark
" color edge

" " -- gruvbox-material --
" " available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'hard'
" colorscheme gruvbox-material


" ---------------------

" " -- Ayu light --
" let ayucolor="light"  " for light version of theme
" color ayu

" " -- flattened light --
" color flattened_light
