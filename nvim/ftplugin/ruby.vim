echom "ftplugin ruby.vim"
match Keyword /assert_\w\+/
match ErrorMsg /binding\.pry\|pry\|byebug\|debugger/

" Custom abbreviation for certain filetypes
abbr fsl # frozen_string_literal: true
abbr logmethod puts(__method__.to_s.center(50, '-'))
iabbr <buffer> bdp binding.pry
iabbr <buffer> mlog puts __method__.to_s.center(40, '-')
iabbr <buffer> itdo it "" do
iabbr <buffer> descdo describe "" do