" ===============================
" === SHORTCUTS CONFIGURATION ===
" ===============================

iabbr bdp binding.pry
iabbr fst # frozen_string_literal: true

" <Leader> set to , instead of \
let mapleader = ","

" Plugin install/update/clean mappings
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

nnoremap <leader>vrc  :e $MYVIMRC<CR>

" File explorer
nnoremap <leader>e :Explore<CR>
nnoremap <leader>he :Sexplore<CR>

" Undo last search (to remove the highlighting)
nnoremap <esc> :nohlsearch<Bar>:echo<CR>

" Copy current file path to the clipboard: yank absolute path
nnoremap <leader>yap :let @+ = expand("%:p")<CR>
" Copy current file path + :line to the clipboard: yank absolute line
nnoremap <leader>yal :let @+ = expand("%:p").":".line(".")<CR>
" Copy the current filename from the git repo root : yank path
" TODO: what if the command returns nothing? handle this case
nnoremap <leader>yp :let @+ = systemlist("git ls-files ".expand("%:p"))[0]<CR>
" Copy the current filename + :line from the git repo root : yank line
" TODO: what if the command returns nothing? handle this case
nnoremap <leader>yl :let @+ = systemlist("git ls-files ".expand("%:p"))[0].":".line(".")<CR>
" Copy whole file: yank inner file
nnoremap <leader>yf ggVGy

nnoremap <leader>tt :let @+ = system("echo 'bonjour'")<CR>

" All buffers delete/wipe
nnoremap <leader>bda :%bd!<CR>
nnoremap <leader>bwa :%bw!<CR>
" Buffer delete to the right/left
nnoremap <leader>bdr :.,$bd!<CR>
nnoremap <leader>bdl :1,.-bd!<CR>
" TODO: buffer delete all but current one

" Vim specific buffer cycle behaviour
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>

" "Goes 1l down/up even with wrap enabled
nnoremap j gj
nnoremap k gk

" Move current line down/up
" <Alt-k>
vnoremap Ï :m '>+1<CR>gv=gv
nnoremap Ï :m .+1<CR>
" <Alt-j>
vnoremap È :m '<-2<CR>gv=gv
nnoremap È :m .-2<CR>

" Map arrow keys
" Tab and Ctrl-I are the same: overriding Tab behaviour prevent Ctrl-I to work
" as it should (and use it to move back and forth in the jump list)
" nnoremap <S-Tab> <<
" nnoremap <Tab> >>
vnoremap < <gv
vnoremap > >gv
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv
nnoremap <Up> <Nop>
vnoremap <Up> <Nop>
nnoremap <Down> <Nop>
vnoremap <Down> <Nop>
nnoremap <Left> <Nop>
vnoremap <Left> <Nop>
nnoremap <Right> <Nop>
vnoremap <Right> <Nop>

" Enable/disable relative numbering
" nnoremap <leader>n :set rnu<CR>
" nnoremap <leader>nn :set nornu<CR>

" ctags remapping
nnoremap <leader>jt <C-]>
nnoremap <leader>jb :pop<CR>
