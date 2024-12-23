" ====================
" === UI SETTINGS ====
" ====================

" Enable true colors for better colorschemes
set termguicolors

function s:SetDarkMode()
  set bg=dark

   "" -- everforest --
   "" -- palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
   "let g:everforest_disable_italic_comment = 1
   "let g:everforest_background = 'hard'
   "" standard hard dark :
   "" fg:  ['#d3c6aa', '223']
   "" bg0: ['#2b3339',   '235'],
   "let g:everforest_colors_override = {
   "\ 'fg':  ['#d6d6d4', '223'],
   "\ 'bg0': ['#191e23', '235']
   "\}
   "color everforest

"" -- kanagawa --
"lua << EOF
"  -- palette: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
"  local colors = require("kanagawa.colors").setup({theme = "wave"})
"  local palette = colors.palette
"  require('kanagawa').setup({
"      undercurl = true,
"      commentStyle = { italic = false },
"      keywordStyle = { italic = false },
"      functionStyle = { bold = true },
"      statementStyle = { bold = true },
"      colors = {
"        palette = {
"            fujiWhite = "#dbd8c5",  -- fg: a bit less saturated
"            fujiGray = "#7c7e8c",   -- more blue-ish, less brown-ish
"            sumiInk3 = "#222123",   -- bg: more blue-ish, less saturated
"            sumiInk4 = "#232428",   -- bg_p1: more blue-ish, less saturated
"        },
"        theme = {
"          wave = {
"            ui = {
"              pmenu = {
"                bg = palette.sumiInk5,
"              },
"            },
"          },
"        },
"      }
"  })
"  vim.cmd('color kanagawa-wave')
"EOF

"" -- nightfox --
"lua << EOF
"  require('nightfox').setup({
"    options = {
"      styles = { keywords = "bold" },
"    },
"    palettes = {
"      -- Custom duskfox with black background
"      nordfox = {
"        bg1 = "#1c2026", -- Black background
"        bg3 = "#2c333f",
"      }
"    },
"    specs = {},
"    groups = {},
"  })
"  -- DARK: nightfox, nordfox // LIGHT: dayfox, dawnfox
"  -- not too fond of the other ones
"  -- vim.cmd("colorscheme nightfox")
"  vim.cmd("colorscheme nordfox")
"EOF

" -- onedark --
lua << EOF
  require('onedark').setup {
    -- Choose between 'dark', 'darker', 'cool', 'deep'
    -- Don't like 'warm' or 'warmer'
    style = 'cool',
    code_style = {
      comments = 'none',
      keywords = 'none',
    },
    colors = {
      fg = '#d2d2d2', -- whiter foreground color
      comment_gray = '#667788'
    },
    highlights = {
      ["comments"] = {fg = '$comment_gray', fmt = 'none'},
      ["@comment"] = {fg = '$comment_gray', fmt = 'none'},
    }
  }
  require('onedark').load()
EOF

  return
endfunction

function s:SetLightMode()
  set bg=light

   "" -- everforest --
   "" palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
   "let g:everforest_background = 'hard'
   "let g:everforest_colors_override = {
   "\ 'fg':  ['#40494f', '242'],
   "\ 'bg0': ['#fefffc', '230'],
   "\}
   "color everforest

  " -- onedark --
lua << EOF
  require('onedark').setup {
    style = 'light',
    code_style = {
      comments = 'none',
      keywords = 'bold',
    },
    colors = {
      green = '#1d936a',
      red = '#c65959',
      blue = '#2d689b',
      yellow = '#ce993d'
    },
  }
  require('onedark').load()
EOF

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

function s:SetMode()
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
endfunction

augroup lightdarkmode
  autocmd!
  autocmd WinEnter * call s:SetMode()
augroup END

call s:SetMode()
