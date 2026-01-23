iabbr <buffer> iop IO.puts
iabbr <buffer> ioi IO.inspect
iabbr <buffer> iop-- IO.puts(String.duplicate("-", 50))<ESC>
iabbr <buffer> adg alias Digiforma.

" Fold All Tests
nnoremap <leader>fat :g/\<test\> ".*do/norm $zf%<CR>

" Projectionist
autocmd User ProjectionistDetect call projectionist#append(getcwd(),
      \ {
      \   "lib/*.ex": {
      \     "type":      "src",
      \     "alternate": "test/lib/{}_test.exs",
      \     "template": [
      \       "# lib/{}.ex",
      \       "defmodule XXX do",
      \       "end"
      \     ]
      \   },
      \   "test/*_test.exs": {
      \     "type":      "test",
      \     "alternate": "{}.ex",
      \     "template": [
      \       "# test/{}_test.exs",
      \       "defmodule XXX do",
      \       " ",
      \       "  use ExUnit.Case",
      \       " ",
      \       "  alias XXX",
      \       " ",
      \       "  describe \"#myfunc/1\" do",
      \       "    test \"description\" do",
      \       "      assert true",
      \       "    end",
      \       "  end",
      \       " ",
      \       "end"
      \     ]
      \   }
      \ })


" ===================================
" === Toggle @tag :focus in tests ===
" ===================================
function! ToggleTestFocus()
  " Save the current cursor position
  let l:save_cursor = getpos(".")

  " Search backward for the test line
  let l:test_line = search('^\s*test\s\+', 'bcnW')

  " If test line found
  if l:test_line > 0
    " Check if the previous line has @tag :focus
    let l:prev_line = l:test_line - 1
    let l:prev_line_content = getline(l:prev_line)

    if l:prev_line_content =~ '^\s*@tag\s\+:focus\s*$'
      " Remove the @tag :focus line
      execute l:prev_line . "delete"
    else
      " Add @tag :focus before the test line
      let l:indent = matchstr(getline(l:test_line), '^\s*')
      call append(l:test_line - 1, l:indent . "@tag :focus")
    endif
  endif

  " Restore cursor position
  call setpos('.', l:save_cursor)
endfunction

:command! ToggleTestFocus :call ToggleTestFocus()
nnoremap <leader>tt :call ToggleTestFocus()<CR>
