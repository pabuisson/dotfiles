" ===============================
" === SHORTCUTS CONFIGURATION ===
" ===============================

" <Leader> set to , instead of \
let mapleader = ","

nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

nnoremap <leader>vrc  :e $MYVIMRC<CR>
" File explorer
nnoremap <leader>e :Explore<CR>
nnoremap <leader>he :Sexplore<CR>
" Undo last search (to remove the highlighting)
nnoremap <leader>vw :cd ~/MEGA/NOTES<CR>:e .<CR>
nnoremap <esc> :nohlsearch<Bar>:echo<CR>
" Copy current file name to the clipboard: yank path
nnoremap <leader>yap :let @+ = expand("%:p")<CR>
nnoremap <leader>yapl :let @+ = expand("%:p").":".line(".")<CR>
" Copy the current filename from the git repo root
nnoremap <leader>yp :let @+ = system("git ls-files ".expand("%:p"))<CR>
nnoremap <leader>ypl :let @+ = system("git ls-files ".expand("%:p")).":".line(".")<CR>
" Copy whole file: yank inner file
nnoremap <leader>yf ggVGy

" All buffers delete
nnoremap <leader>bda :%bd!<CR>
nnoremap <leader>bwa :%bw!<CR>
" Buffer delete to the right
nnoremap <leader>bdl :.+,$bd!<CR>
nnoremap <leader>bwl :.+,$bw!<CR>
" TODO: buffer delete all but current one
" TODO: buffer delete to the left

" Use :g to see the structure of ruby tests
" FIXME: doesn't work, maybe something with magical regexps and all?
" nnoremap <leader>ts :g/\(class\|describe\|it\) /<CR>

" Vim specific buffer cycle behaviour
nnoremap <C-l> :bn<CR>
" inoremap <C-l> <ESC>:bn<CR>
nnoremap <C-h> :bp<CR>
" inoremap <C-h> <ESC>:bp<CR>

" "Goes 1l down even with wrap enabled
nnoremap j gj
" "Goes 1l up even with wrap enabled
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
" nnoremap <leader>n :set rnu<CR>
" nnoremap <leader>nn :set nornu<CR>

" ctags remapping
nnoremap <leader>jt <C-]>
nnoremap <leader>jb :pop<CR>
