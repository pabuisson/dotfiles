" ====================
" === UI SETTINGS ====
" ====================

set termguicolors

" ----------------------------------------------------------------------------
" Below are the configuration function for each theme. I stick to one function
" per theme, and use a mode argument (either 'Dark' or 'Light', check
" `MacOsUIMode()` for more details) reflecting which mode is asked.
"
" These functions are then called from `SetLightTheme()` or `SetDarkTheme()`.
" ----------------------------------------------------------------------------

" """
" Everforest theme
" """
function! s:SetupEverforest(mode)
  let g:everforest_disable_italic_comment = 1
  let g:everforest_background = 'hard'

  if a:mode == 'Dark'
    let g:everforest_colors_override = {
    \ 'fg':  ['#d6d6c2', '223'],
    \ 'bg0': ['#1f2120', '235'],
    \}
  elseif a:mode == 'Light'
    let g:everforest_colors_override = {
    \ 'fg':  ['#40494f', '242'],
    \ 'bg0': ['#fffbf7', '230'],
    \ 'bg1': ['#faf7f0', '230'],
    \ 'bg2': ['#f5f0ee', '230'],
    \}
  else
    echom "Invalid mode: '" . a:mode . "'. Use 'Dark' or 'Light'."
    return
  endif

  color everforest
  return
endfunction

" """
" Github theme
" """
function s:SetupGithub(mode)
  if a:mode !=# 'Dark' && a:mode !=# 'Light'
    echom "Invalid mode: '" . a:mode . "'. Use 'Dark' or 'Light'."
    return
  endif

lua << EOF
  local mode = vim.api.nvim_eval('a:mode')
  local theme = mode == 'Dark' and 'github_dark_dimmed' or 'github_light_default'

  require('github-theme').setup({
    options = {
      styles = {                 -- Style to be applied to different syntax groups
        comments = 'NONE',       -- Value is any valid attr-list value `:help attr-list`
        functions = 'NONE',
        keywords = 'NONE',
        variables = 'NONE',
        conditionals = 'NONE',
        constants = 'NONE',
        numbers = 'NONE',
        operators = 'NONE',
        strings = 'NONE',
        types = 'NONE',
      },
      -- https://github.com/projekt0n/github-nvim-theme/blob/main/Usage.md#modules
      modules = {
        'diagnostic', 'native_lsp', 'treesitter',
        'blink', 'fzf', 'gitsigns', 'treesitter_context'
      }
    },
  })
  vim.cmd.colorscheme(theme)
EOF
  return
endfunction

" """
" Kanagawa theme
" """
function s:SetupKanagawa()
lua << EOF
  -- palette: https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/colors.lua
  require('kanagawa').setup({
    undercurl = true,
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    functionStyle = { bold = false },
    statementStyle = { bold = false },
    colors = {
      palette = {
        -- TODO: these should ideally only be customized for the wave theme, not for all themes
        --       but I only use the wave theme anyway so I guess it's good enough for now
        fujiWhite = "#dbd8c9",  -- whiter foreground color
        fujiGray = "#8c8993",   -- more blue/purple comment color
      },
      theme = {}
    },
    overrides = function()
      -- Solution provided here: https://github.com/rebelot/kanagawa.nvim/issues/216
      return {
        ["@variable.builtin"] = { italic = false },
      }
    end
  })
  vim.cmd.colorscheme('kanagawa-wave')
EOF
  return
endfunction

" """
" One Dark theme
" """
function s:SetupOneDark(mode)
  if a:mode != 'Dark' && a:mode != 'Light'
    echom 'Invalid mode: ' . a:mode . '. Must be either "Dark" or "Light".'
    return
  endif

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

  local mode = vim.api.nvim_eval('a:mode')

  -- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
  local palette = require("onedark.palette")
  local style = mode == 'Dark' and 'darker' or 'light'

  local custom_colors = {}
  local custom_highlights = {}

  if mode == 'Dark' then
    custom_colors = {
      fg = '#e1e5ed',           -- whiter foreground color → nordic.nvim white1
      lighter_gray = "#6c7689", -- new color used for comments
    }
    custom_highlights = {
      ["comments"] = {fg = '$lighter_gray', fmt = 'none'},
      ["@comment"] = {fg = '$lighter_gray', fmt = 'none'},
      ["@comment.documentation"] = {fg = '$lighter_gray', fmt = 'none'},
      ["Comment"] = {fg = '$lighter_gray', fmt = 'none'},
    }
    mini_tabline_colors = {
      ["MiniTablineCurrent"] = { bg = palette[style].blue, fg = palette[style].black },
      ["MiniTablineModifiedCurrent"] = { bg = palette[style].orange, fg = palette[style].black },
      ["MiniTablineVisible"] = { bg = palette[style].grey, fg = "#eceff4" }
    }
  else
    custom_colors = {
      green = '#1d936a',
      red = '#ce4646',
      blue = '#2d689b',
      yellow = '#c69d43'
    }
    mini_tabline_colors = {
      ["MiniTablineCurrent"] = { bg = palette[style].bg_blue, fg = palette[style].black },
      ["MiniTablineModifiedCurrent"] = { bg = palette[style].bg_yellow, fg = palette[style].black },
      ["MiniTablineVisible"] = { bg = palette[style].bg_d, fg = palette[style].black }
    }
  end

  require('onedark').setup({
    style = style,
    code_style = {
      comments = 'none',
      keywords = 'none',
      functions = 'none',
    },
    colors = merge(palette[style], custom_colors),
    highlights = custom_highlights,
  })
  require('onedark').load()

  -- `MiniTablineCurrent` - buffer is current (has cursor in it).
  -- `MiniTablineVisible` - buffer is visible (displayed in some window).
  -- `MiniTablineHidden` - buffer is hidden (not displayed).
  -- `MiniTablineModifiedCurrent` - buffer is modified and current.
  -- `MiniTablineModifiedVisible` - buffer is modified and visible.
  -- `MiniTablineModifiedHidden` - buffer is modified and hidden.
  for k, v in pairs(mini_tabline_colors) do
    vim.api.nvim_set_hl(0, k, v)
  end
EOF
  return
endfunction


" ----------------------------------------------------------------------------
" We reach the end of the theme configuration functions. Below is the logic to
" detect automatically the OS theme, and the 2 `SetLightTheme()` and
" `SetDarkTheme()` functions that setup the proper theme and some additionnal
" custom highlighting according to the desired theme.
" ----------------------------------------------------------------------------


function s:SetDarkTheme()
  set bg=dark

  "call s:SetupEverforest('Dark')
  "call s:SetupGithub('Dark')
  call s:SetupKanagawa()
  "call s:SetupOneDark('Dark')

  " -- mini.indent --
  hi IndentLine guifg=#444455
  hi IndentLineCurrent guifg=#777788
  " --- hop.nvim ---
  hi! HopNextKey guifg=#ff521b gui=bold
  hi! HopNextKey1 guifg=#fc9e4f gui=bold
  hi! HopNextKey2 guifg=#edd382 gui=bold

  return
endfunction

function s:SetLightTheme()
  set bg=light

  "call s:SetupEverforest('Light')
  call s:SetupGithub('Light')
  "call s:SetupOneDark('Light')

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

function s:LoadTheme()
  if s:MacOsUIMode() == 'Light'
    call s:SetLightTheme()
  else
    call s:SetDarkTheme()
  endif
endfunction

augroup lightdarkmode
  autocmd!
  autocmd WinEnter * call s:LoadTheme()
augroup END

call s:LoadTheme()
