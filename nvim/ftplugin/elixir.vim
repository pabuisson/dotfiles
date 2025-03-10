iabbr <buffer> iop IO.puts
iabbr <buffer> ioi IO.inspect
iabbr <buffer> iop-- IO.puts(String.duplicate("-", 50))<ESC>
iabbr <buffer> adg alias Digiforma.

" Fold All Tests
nnoremap <leader>fat :g/\<test\> ".*do/norm $zf%<CR>
