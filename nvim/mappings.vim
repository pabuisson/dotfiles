" ===============================
" === SHORTCUTS CONFIGURATION ===
" ===============================

" Personal <Leader> mappings
nnoremap <leader>vrc  :e $MYVIMRC<CR>
" File explorer
nnoremap <leader>e :Explore<CR>
" Undo last search (to remove the highlighting)
nnoremap <leader>su :nohlsearch<Bar>:echo<CR>
nnoremap <esc> :nohlsearch<Bar>:echo<CR>
" Copy current file name to the clipboard
nnoremap <leader>yf :let @+ = expand("%:p")<CR>
"
" All buffers delete
nnoremap <leader>bda :%bd!<CR>
nnoremap <leader>bwa :%bw!<CR>
" Buffer delete to the right
nnoremap <leader>bdl :.+,$bd!<CR>
nnoremap <leader>bwl :.+,$bw!<CR>
" TODO: buffer delete all but current one
" TODO: buffer delete to the left

" Copy whole file
nnoremap <leader>ya ggVGy

" Firefox-like buffer cycle behaviour
nnoremap <C-S-tab> :bp<cr>
inoremap <C-S-tab> <ESC>:bp<cr>i
nnoremap <C-tab> :bn<cr>
inoremap <C-tab> <ESC>:bn<cr>i
" Vim specific buffer cycle behaviour
nnoremap <C-l> :bn<CR>
inoremap <C-l> <ESC>:bn<CR>
nnoremap <C-h> :bp<CR>
inoremap <C-h> <ESC>:bp<CR>

"Goes 1l down even with wrap enabled
nnoremap j gj
"Goes 1l up even with wrap enabled
nnoremap k gk

" Move current line down/up
" <Alt-k>
vnoremap Ï :m '>+1<CR>gv=gv
nnoremap Ï :m .+1<CR>
" <Alt-j>
vnoremap È :m '<-2<CR>gv=gv
nnoremap È :m .-2<CR>

" Map arrow keys
nnoremap <S-Tab> <<
nnoremap <Tab> >>
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
nnoremap <leader>n :set rnu<CR>
nnoremap <leader>nn :set nornu<CR>
