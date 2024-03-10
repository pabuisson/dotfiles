" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

function s:SetDarkMode()
  set bg=dark

  " " -- everforest --
  " " -- palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
  " let g:everforest_disable_italic_comment = 1
  " let g:everforest_background = 'hard'
  " " standard hard dark :
  " " fg:  ['#d3c6aa', '223']
  " " bg0: ['#2b3339',   '235'],
  " let g:everforest_colors_override = {
  " \ 'fg':  ['#d6d6d4', '223'],
  " \ 'bg0': ['#182124', '235']
  " \}
  " color everforest
  " " let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#223922 guibg=NONE'
  " " let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#223922 guibg=NONE'

  " " -- kanagawa --
" lua << EOF
  " -- color palette: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
  " local colors = require("kanagawa.colors").setup({theme = "wave"})
  " local palette = colors.palette
  " require('kanagawa').setup({
  "     undercurl = true,
  "     commentStyle = { italic = false },
  "     functionStyle = { bold = true },
  "     keywordStyle = { italic = false },
  "     statementStyle = { bold = true },
  "     colors = {
  "       palette = {
  "           fujiWhite = "#dbd8c5",  -- fg: a bit less saturated
  "           fujiGray = "#6a6b77",   -- more blue-ish, less brown-ish
  "           sumiInk3 = "#202025",   -- bg: more blue-ish, less saturated
  "           sumiInk4 = "#232428",   -- bg_p1: more blue-ish, less saturated
  "       },
  "       theme = {
  "         wave = {
  "           ui = {
  "             pmenu = {
  "               bg = palette.sumiInk5,
  "             },
  "           },
  "         },
  "       },
  "     }
  " })
  " vim.cmd('color kanagawa-wave')
" EOF

" lua << EOF
"   require("monokai-pro").setup({
"     styles = {
"       comment = { italic = false },
"       keyword = { italic = false }, -- any other keyword
"       type = { italic = false }, -- (preferred) int, long, char, etc
"       storageclass = { italic = false }, -- static, register, volatile, etc
"       structure = { italic = false }, -- struct, union, enum, etc
"       parameter = { italic = false }, -- parameter pass in function
"       annotation = { italic = false },
"       tag_attribute = { italic = false }, -- attribute of tag in reactjs
"     },
"     devicons = false,
"     filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
"   })
"   vim.cmd('color monokai-pro')
" EOF

" lua << EOF
"   require 'nordic' .setup {
"     italic_comments = false,
"     reduced_blue = true,
"     -- This callback can be used to override the colors used in the palette.
"     -- on_palette = function(palette) return palette end,
"     -- Override the styling of any highlight group.
"     override = {},
"   }
"   vim.cmd('color nordic')
" EOF

  " " -- oceanic next --
  " let g:oceanic_next_terminal_bold = 0
  " color OceanicNext
  " let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#3e5759 guibg=NONE'
  " let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#3e5759 guibg=NONE'

  " -- onedark --
lua << EOF
  require('onedark').setup {
    -- Choose between 'dark', 'darker', 'cool', 'deep',
    -- Don't like 'warm' or 'warmer'
    style = 'deep',
    code_style = {
      keywords = 'bold',
      comments = 'none'
    },
    colors = {
      fg = '#d2d2d2',
    }
  }
  require('onedark').load()
EOF

  return
endfunction

function s:SetLightMode()
  set bg=light

  " " -- everforest --
  " " palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
  " let g:everforest_background = 'hard'
  " let g:everforest_colors_override = {
  " \ 'fg':  ['#40494f', '242'],
  " \ 'bg0': ['#fefffc', '230'],
  " \}
  " color everforest
  " let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c9c0 guibg=NONE'
  " let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c9c0 guibg=NONE'

  " -- onedark --
lua << EOF
  require('onedark').setup {
    style = 'light',
    code_style = {
      comments = 'none',
      keywords = 'bold',
    },
    colors = {
      fg = '#454555',
      green = '#299e75',
      red = '#c65959',
      blue = '#5677c4', --275ad1',
      yellow = '#ce993d'
    },
  }
  require('onedark').load()
EOF
  " let g:indentguides_conceal_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c0c9 guibg=NONE'
  " let g:indentguides_specialkey_color = 'ctermfg=151 ctermbg=NONE guifg=#c0c0c9 guibg=NONE'

  return
endfunction


function s:MacOsUIMode()
  let s:result = system('defaults read -g AppleInterfaceStyle')
  if s:result =~ 'Dark'
    return 'Dark'
  else
    return 'Light'
  endif
endfunction

if has('nvim-0.5')
  if s:MacOsUIMode() == 'Light'
    call s:SetLightMode()
  else
    call s:SetDarkMode()
  endif
else
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  color OceanicNext
  finish
endif
