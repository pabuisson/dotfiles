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
"  -- local colors = require("kanagawa.colors").setup({theme = "wave"})
"  -- local palette = colors.palette
"  require('kanagawa').setup({
"    undercurl = true,
"    commentStyle = { italic = false },
"    keywordStyle = { italic = false },
"    functionStyle = { bold = false },
"    statementStyle = { bold = false }
"    -- TODO: more blue comment color
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

  local style = 'dark'
  local palette = require("onedark.palette")

  require('onedark').setup {
    -- Choose between 'dark', 'darker', 'cool', 'deep'
    -- Don't like 'warm' or 'warmer'
    style = style,
    code_style = {
      comments = 'none',
      keywords = 'bold',
      functions = 'bold'
    },
    colors = merge(palette[style], {
      fg = '#d8dee9',  -- whiter foreground color → nordic.nvim white1
      bg0 = '#242933', -- darker background color → nordic.nvim gray0
    }),
    -- highlights = {
    --   ["comments"] = {fg = '$comment_gray', fmt = 'none'},
    --   ["@comment"] = {fg = '$comment_gray', fmt = 'none'},
    -- }
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
      keywords = 'bold',
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
