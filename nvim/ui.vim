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

" " -- onenord --
" lua << EOF
" require('onenord').setup({
"   theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
"   borders = true, -- Split window borders
"   fade_nc = false, -- Fade non-current windows, making them more distinguishable
"   styles = {
"     comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
"     strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
"     keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
"     functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
"     variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
"     diagnostics = "underline", -- Style that is applied to diagnostics: see `highlight-args` for options
"   },
"   disable = {
"     background = false, -- Disable setting the background color
"     cursorline = false, -- Disable the cursorline
"     eob_lines = true, -- Hide the end-of-buffer lines
"   },
"   custom_highlights = {}, -- Overwrite default highlight groups
"   custom_colors = {}, -- Overwrite default colors
" })
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

" " -- gruvbox-material --
" set background=light
" " Set contrast. Available values: 'hard', 'medium'(default), 'soft'
" let g:gruvbox_material_background = 'hard'
" color gruvbox-material
