" === STATUS LINE ===
set laststatus=2
set noshowmode
set statusline=%#Pmenu#
set statusline+=%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffAdded#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffText#%{(mode()=='r')?'\ \ REPLACE\ ':''}
set statusline+=%#Cursor#%{IsVisual()?'\ \ VISUAL\ ':''}
" Reset color
set statusline+=%#Pmenu#
set statusline+=⋮
set statusline+=%#ErrorMsg#%{LinterErrors()>0?\ LinterStatusText():''}
set statusline+=%#WarningMsg#%{LinterErrors()==0&&LinterWarnings()>0?\ LinterStatusText():''}
set statusline+=%#Pmenu#%{LinterErrors()==0&&LinterWarnings()==0?LinterStatusText():''}
" Reset color
set statusline+=%#Pmenu#
set statusline+=\ ⋮\ %.20f%{&modified?'\ [+]':''}
set statusline+=\ ⋮\ %.20{GitInfo()}
" switch to the right side
set statusline+=%=
" statusline(prefix, suffix, text_to_print)
set statusline+=%{gutentags#statusline('','','⚡️\ ┊')}
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
  let git = FugitiveHead()
  if git != ''
    return 'g:'.FugitiveHead()
  else
    return ''
  endif
endfunction

function! LinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  return l:all_errors
endfunction

function! LinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors
endfunction

function! LinterStatusText() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? ' OK' : printf(
        \   ' %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
