call plug#begin()

Plug 'ap/vim-css-color'
Plug 'dylanaraps/wal.vim'

call plug#end()

set number

function! MakeList()
   s/,/\", \"/g
   s/^/\"/g
   s/$/\"/g
endfunction

" shift-L: make list
" a,b,c -> "a", "b", "c"
nnoremap <S-L> :.call MakeList()<CR>
