" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
" For neovim > 0.1.5
set termguicolors

if !has('nvim-0.5.0')
  color palenight
  finish
endif

" " -- ayu --
" " let ayucolor="mirage" " mirage version of theme
" let ayucolor="dark"   " dark version of theme
" color ayu

" " -- dracula --
" set bg=dark
" color dracula

" " -- nord --
" let g:nord_italic_comments = 1
" color nord

" " -- oceanic-next --
" color OceanicNext

" " -- material --
" " let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
" let g:material_theme_style = 'darker'
" color material
" hi clear Folded
" hi link Folded Comment

" " -- palenight --
" color palenight
" let g:palenight_terminal_italics=1

 " -- tokyonight --
 " let g:tokyonight_style = 'night' | 'storm'
let g:tokyonight_style = "storm"
let g:tokyonight_italic_functions = 1
colorscheme tokyonight

" ---------------------

" " -- ayu light --
" let ayucolor="light"  " for light version of theme
" color ayu

" " -- material light --
" " let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
" let g:material_theme_style = 'lighter'
" color material

" " -- tokyonight --
" " NOTE: requires neovim >= 0.5.0
" let g:tokyonight_style = "day"
" let g:tokyonight_italic_functions = 1
" colorscheme tokyonight
