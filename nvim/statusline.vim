" === STATUS LINE ===
set laststatus=2
set noshowmode

set statusline=%#Pmenu#
set statusline+=%{(mode()=='n')?'\ \ N\ ':''}
set statusline+=%#DiffAdded#%{(mode()=='i')?'\ \ I\ ':''}
set statusline+=%#DiffText#%{(mode()=='r')?'\ \ R\ ':''}
set statusline+=%#Cursor#%{IsVisual()?'\ \ V\ ':''}
" Reset color
set statusline+=%#Pmenu#
set statusline+=\ ⋮%{UnbreakableSpace()}
" TODO: what's a cleaner way to apply conditional color?
set statusline+=%#Error#%{LspActiveClients()==0?LspActiveClientsIndicator():''}
set statusline+=%#Pmenu#%{LspActiveClients()>0?LspActiveClientsIndicator():''}
set statusline+=%{UnbreakableSpace()}
set statusline+=⋮\ %#Pmenu#%{LinterStatusText()}
" Reset color
set statusline+=%#Pmenu#
set statusline+=\ ⋮\ %.80f%{&modified?'\ [+]':''}
set statusline+=\ ⋮\ %.20{GitInfo()}
" switch to the right side
set statusline+=%=
set statusline+=\ %l/%L
set statusline+=\ ⋮\ %2p%%
set statusline+=%{UnbreakableSpace()}

function! UnbreakableSpace()
  return ' '
endfunction

function! IsVisual()
  return mode() == 'v' || mode() == ''
endfunction

function! GitInfo()
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
  return printf('LSP: %s', active_indicator)
endfunction

" TODO: use native lsp instead of ALE (don't use ALE anymore)
function! LinterStatusText() abort
  " let l:counts = ale#statusline#Count(bufnr(''))
  " let l:all_errors = l:counts.error + l:counts.style_error
  " let l:all_non_errors = l:counts.total - l:all_errors

  " return l:counts.total == 0 ? ' OK' : printf(
  "       \   ' %dW %dE',
  "       \   all_non_errors,
  "       \   all_errors
  "       \)
  return 'E: -  W: - '
endfunction
