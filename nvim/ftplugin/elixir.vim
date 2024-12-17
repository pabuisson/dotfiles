iabbr <buffer> iop( IO.puts(
iabbr <buffer> ioins IO.inspect(
iabbr <buffer> iop-- IO.puts(String.duplicate("-", 50))<ESC>

" Fold All Tests
nnoremap <leader>fat :g/\<test\> ".*do/norm $zf%<CR>
