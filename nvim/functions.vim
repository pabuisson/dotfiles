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


" ========================================
" === Show current path in a YAML file ===
" ========================================
" https://vi.stackexchange.com/a/13519/7021

function! YAMLTree()
    let l:list = []
    let l:cur = getcurpos()[1]
    " Retrieve the current line indentation
    let l:indent = indent(l:cur) + 1
    " Loop from the cursor position to the top of the file
    for l:n in reverse(range(1, l:cur))
        let l:i = indent(l:n)
        let l:line = getline(l:n)
        let l:key = substitute(l:line, '^\s*\(\<\w\+\>\):.*', "\\1", '')
        " If the indentation decreased and the pattern matched
        if (l:i < l:indent && l:key !=# l:line)
            let l:list = add(l:list, l:key)
            let l:indent = l:i
        endif
    endfor
    let l:list = reverse(l:list)
    echo join(l:list, '.')
endfunction

nnoremap <leader>yml :call YAMLTree()<CR>
