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
  "" bg0: ['#2b3339', '235'],
  "let g:everforest_colors_override = {
  "\ 'fg':  ['#d6d6cf', '223'],
  "\ 'bg0': ['#1d211f', '235']
  "\}
  "color everforest

"" -- kanagawa --
"lua << EOF
"  -- palette: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
"  require('kanagawa').setup({
"    undercurl = true,
"    commentStyle = { italic = false },
"    keywordStyle = { italic = false },
"    functionStyle = { bold = false },
"    statementStyle = { bold = false },
"    colors = {
"      palette = {
"        -- TODO: these should ideally only be customized for the wave theme, not for all themes
"        --       but I only use the wave theme anyway so I guess it's good enough for now
"        fujiWhite = "#dbd8c9",  -- whiter foreground color
"        fujiGray = "#76747a",   -- more blue/purple comment color
"      },
"      theme = {}
"    }
"  })
"  vim.cmd.colorscheme('kanagawa-wave')
"EOF

" -- onedark --
lua << EOF
  --- Merges a table into another table. Returns a whole new table.
  -- @param t1 first table
  -- @param t2 second table
  -- @return a new table containing t2 values merged into t1
  function merge(t1, t2)
    local result = {}
    for k, v in pairs(t1) do result[k] = v end
    for k, v in pairs(t2) do result[k] = v end
    return result
  end
  -- dark, darker, cool, deep, warm or warmer
  local style = 'dark'
  local palette = require("onedark.palette")
  require('onedark').setup {
    style = style,
    code_style = {
      comments = 'none',
      keywords = 'none',
      functions = 'none'
    },
    colors = merge(palette[style], {
      fg = '#d8dee9',  -- whiter foreground color → nordic.nvim white1
      lighter_gray = "#6c7689", -- new color used for comments
    }),
    highlights = {
      ["comments"] = {fg = '$lighter_gray', fmt = 'none'},
      ["@comment"] = {fg = '$lighter_gray', fmt = 'none'},
    }
  }
  require('onedark').load()
EOF


" -- mini.indent --
hi IndentLine guifg=#444455
hi IndentLineCurrent guifg=#777788
" --- hop.nvim ---
hi! HopNextKey guifg=#ff521b gui=bold
hi! HopNextKey1 guifg=#fc9e4f gui=bold
hi! HopNextKey2 guifg=#edd382 gui=bold

  return
endfunction

function s:SetLightMode()
  set bg=light

  "" -- everforest --
  "" palette: https://github.com/sainnhe/everforest/blob/master/autoload/everforest.vim
  "let g:everforest_disable_italic_comment = 1
  "let g:everforest_background = 'hard'
  "let g:everforest_colors_override = {
  "\ 'fg':  ['#40494f', '242'],
  "\ 'bg0': ['#fffbf7', '230'],
  "\ 'bg1': ['#faf7f0', '230'],
  "\ 'bg2': ['#f5f0ee', '230'],
  "\}
  "color everforest

  " -- onedark --
lua << EOF
  --- Merges a table into another table. Returns a whole new table.
  -- @param t1 first table
  -- @param t2 second table
  -- @return a new table containing t2 values merged into t1
  function merge(t1, t2)
    local result = {}
    for k, v in pairs(t1) do result[k] = v end
    for k, v in pairs(t2) do result[k] = v end
    return result
  end
  local style = 'light'
  local palette = require("onedark.palette")
  require('onedark').setup {
    style = style,
    code_style = {
      comments = 'none',
      keywords = 'none',
      functions = 'none',
    },
    colors = merge(palette[style], {
      -- bg0 = '#fefffd',
      green = '#1d936a',
      red = '#ce4646',
      blue = '#2d689b',
      -- orange = '#bf7c42',
      yellow = '#c69d43'
    }),
  }
  require('onedark').load()
EOF

" Colors are applied automatically based on user-defined highlight groups.
" There is no default value.

" -- mini.indent --
hi IndentLine guifg=#bbbbbb
hi IndentLineCurrent guifg=#888888
" --- hop.nvim ---
hi! HopNextKey guifg=#cc3f46 gui=bold
hi! HopNextKey1 guifg=#bf702f gui=bold
hi! HopNextKey2 guifg=#e0b22a gui=bold

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
    color retrobox
    finish
  endif
endfunction

augroup lightdarkmode
  autocmd!
  autocmd WinEnter * call s:SetMode()
augroup END

call s:SetMode()
