" Keybindings

" mapping Esc
inoremap kj <Esc>
imap <F13> <Esc>
cnoremap <Esc> <C-c>
inoremap <c-c> <ESC>
nnoremap <C-z> <Esc>  " disable terminal ctrl-z

" map S to replace current word with pasteboard
nnoremap S diw"0P
nnoremap cc "_cc

" map paste, yank and delete to named register so the content
" will not be overwritten (I know I should just remember...)
nnoremap x "_x
vnoremap x "_x

" Keybinding to resize nerdtree window                                                                                                                 
" resize horzontal split window
nmap <C-S-Down> <C-W>-<C-W>-
nmap <C-S-Up> <C-W>+<C-W>+
" resize vertical split window
nmap <C-S-Right> <C-W>><C-W>>
nmap <C-S-Left> <C-W><<C-W><

" TODO: document
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

" Move across buffers
map <TAB> :bn<CR>
map <S-TAB> :bp<CR>
map gb :b 

" Search bindings
nmap <space> /
nmap <C-space> ?

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Smoother scrolling
nnoremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
nnoremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" Remove hightlight by pressing escape twice
nnoremap <silent><esc><esc> :noh<return>

" Move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"auto indent for brackets
" update not write
nnoremap <silent><leader>w :up!<cr>  
nnoremap <silent><leader>q :bd<cr>
nnoremap <silent><leader>h :nohlsearch<Bar>:echo<CR>

" FlyGrep settings
nnoremap <leader>s :FlyGrep<cr>

" Toggle CursorColumn
map <silent><leader>v :set cursorcolumn!<CR>

" Presentation utilities
nmap <leader>TT :.!toilet -w 200 -f standard<CR>
nmap <leader>FF :.!toilet -w 200 -f small<CR>
nmap <leader>FT :.!toilet -w 200 -f term -F border<CR>

