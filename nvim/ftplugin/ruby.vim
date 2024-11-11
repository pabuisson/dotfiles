match Keyword /assert_\w\+/
match ErrorMsg /binding\.pry\|pry\|byebug\|debugger/

" Custom abbreviation for certain filetypes
abbr <buffer> fsl # frozen_string_literal: true
abbr <buffer> logmethod puts(__method__.to_s.center(50, '-'))

iabbr <buffer> bdp binding.pry
iabbr <buffer> mlog puts __method__.to_s.center(40, '-')
iabbr <buffer> itdo it "" doend<esc>k0f"a
iabbr <buffer> descdo describe "" doend<esc>k0f"a
