" ======================================
" ===   Delete trailing whitespace   ===
" === and weird mac alt+space spaces ===
" ======================================

function! StripTrailingWhitespaces()
  "1. Save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  "2. Do the business:
  %s/\s\+$//e
  "3. Clean up: restore search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! ReplaceNonUnicodeWhitespaces()
  " On Mac OS, typing alt+space insert a non-regular space character that's not visible but
  " can generate random errors. Let's replace them with regular spaces on save
  "1. Save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  "2. Do the business:
  %s/\%o240/ /e
  "3. Clean up: restore search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

augroup customfunctions
  au!
  au BufWrite * :call StripTrailingWhitespaces()
  au BufWrite * :call ReplaceNonUnicodeWhitespaces()
augroup END


" ===============================================
" === Open URIs with default Mac OS behaviour ===
" ===============================================
" FIXME: Doesn't work for md links because of parentheses
"        -> Should be fixed

function! HandleURI()
  let s:uri = matchstr( getline("."), "[a-z]*:\/\/[^ >,;:'\)]*" )
  echo s:uri
  if s:uri != ""
    exec "!open \"" . s:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction

nnoremap <Leader>w :call HandleURI()<CR>


" ==============================================
" === Count occurrences of word under cursor ===
" ==============================================

function! CountOccurrences()
  " 1. Retrieve cursor position
  let l = line('.')
  let c = col('.')
  " 2. count occurrences
  let word = expand('<cword>')
  execute '%s/'.word.'//gn'
  " 3. Restore cursor position
  call cursor(l, c)
endfunction

nnoremap <Leader>co :call CountOccurrences()<CR>


" ===================
" === Format JSON ===
" ===================

" TODO: replace "nil" with "null" and "=>" with ":"
com! FormatJSON %!python -m json.tool

