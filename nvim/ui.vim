" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
" For neovim > 0.1.5
set termguicolors

if !has('nvim-0.5.0')
  color OceanicNext
  finish
endif

" " -- ayu --
" " let ayucolor="mirage|dark" "
" let ayucolor="mirage"
" color ayu

" " -- dracula --
" set bg=dark
" color dracula

" " -- nord --
" let g:nord_italic_comments = 1
" color nord

" -- oceanic-next --
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
" hi default link BufTabLineCurrent         TabLineSel
" buffer ouvert mais pas en édition. doit être moins visible
" Doit pas être underlined
" hi default link BufTabLineHidden          TabLine
" hi default link BufTabLineFill            TabLineFill
color OceanicNext
" hi link BufTabLineCurrent PmenuSbar
hi link BufTabLineActive PmenuSbar
hi link BufTabLineHidden Pmenu
hi link BufTabLineFill StatusLine

" " -- palenight --
" color palenight
" let g:palenight_terminal_italics=1

" " -- tokyonight --
" " let g:tokyonight_style = 'night' | 'storm'
" let g:tokyonight_style = "storm"
" let g:tokyonight_italic_keywords = 0
" color tokyonight

" ---------------------

" " -- ayu light --
" let ayucolor="light"  " for light version of theme
" color ayu

" " -- material light --
" let g:material_theme_style = 'lighter'
" color material

" " -- tokyonight --
" let g:tokyonight_italic_keywords = 0
" let g:tokyonight_day_brightness = 1.0
" let g:tokyonight_style = "day"
" color tokyonight
