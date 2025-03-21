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
