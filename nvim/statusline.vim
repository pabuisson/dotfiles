" === STATUS LINE ===
set laststatus=2
set noshowmode

set statusline=%#Pmenu#
set statusline+=%{(mode()=='n')?'\ \ N':''}
set statusline+=%#DiffAdded#%{(mode()=='i')?'\ \ I':''}
set statusline+=%#DiffText#%{(mode()=='r')?'\ \ R':''}
set statusline+=%#Cursor#%{IsVisual()?'\ \ V':''}
" Reset color
set statusline+=%#Pmenu#
set statusline+=\ ⋮%{Nbsp()}
" TODO: what's a cleaner way to apply conditional color?
set statusline+=%#Error#%{LspActiveClients()==0?LspActiveClientsIndicator():''}
set statusline+=%#Pmenu#%{LspActiveClients()>0?LspActiveClientsIndicator():''}
set statusline+=%{Nbsp()}
set statusline+=⋮\ %#Error#%{HasLinterErrors()==1?LinterStatusText():''}
set statusline+=\%#Error#%{HasNoLinterErrorButHasWarnings()==1?LinterStatusText():''}
set statusline+=\%#Pmenu#%{HasNoErrorAndNoWarnings()==1?LinterStatusText():''}
" Reset color
set statusline+=%#Pmenu#
set statusline+=\ ⋮\ %.90f%{&modified?'\ [+]':''}
set statusline+=\ ⋮\ %.60{GitInfo()}
" switch to the right side
set statusline+=%=
set statusline+=\ %l/%L
set statusline+=\ ⋮\ %2p%%
set statusline+=%{Nbsp()}

function! Nbsp()
  return ' '
endfunction

function! IsVisual()
  return mode() == 'v' || mode() == ''
endfunction

function! GitInfo()
  if !exists("*FugitiveHead")
    return ''
  endif

  let l:git = FugitiveHead()
  if git != ''
    return 'g:'.FugitiveHead()
  else
    return ''
  endif
endfunction


function! LspActiveClients() abort
  return luaeval('#vim.lsp.get_active_clients({bufnr=0})')
endfunction

" TODO: I think this is not updated when the status changes? how can we do it?
function! LspActiveClientsIndicator() abort
  let l:active_indicator = LspActiveClients() == 0 ? '—' : '✓'
  return printf('LSP %s', active_indicator)
endfunction


function! LinterStatusText() abort
  let l:errors = luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })')
  let l:warnings = luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })')
  return l:errors.'e '.l:warnings.'w'
endfunction

function! HasLinterErrors() abort
  let l:errors = luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })')
  if l:errors == 0
    return 0
  else
    return 1
  end
endfunction

function! HasNoLinterErrorButHasWarnings() abort
  let l:warnings = luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })')
  if HasLinterErrors() == 1
    return 0
  else
    if l:warnings == 0
      return 0
    else
      return 1
    endif
  endif
endfunction

function! HasNoErrorAndNoWarnings() abort
  return HasLinterErrors() == 0 && HasNoLinterErrorButHasWarnings() == 0
endfunction
