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

" resize horzontal split window
nmap <C-S-Down> <C-W>-<C-W>-
nmap <C-S-Up> <C-W>+<C-W>+
" resize vertical split window
nmap <C-Right> <C-W>><C-W>>
nmap <C-Left> <C-W><<C-W><
  
" TODO: document
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"
 
" Move across buffers
map <silent><TAB> :bn<CR>
map <silent><S-TAB> :bp<CR>
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

" Easy-motion always bi-directional
nmap <silent><leader><leader>f <Plug>(easymotion-s)
map <silent>s <Plug>(easymotion-s2)

" Git blame enabling
nmap <silent><M-g> :EnableBlameLine<CR>
nmap <silent><M-g><M-g> :DisableBlameLine<CR>

" Tmux compatible pane switching configuration
let g:tmux_navigator_no_mappings = 1
nmap <silent><M-h> :TmuxNavigateLeft<cr>
nmap <silent><M-j> :TmuxNavigateDown<cr>
nmap <silent><M-k> :TmuxNavigateUp<cr>
nmap <silent><M-l> :TmuxNavigateRight<cr>
nmap <silent><M-\> :TmuxNavigatePrevious<cr>

" FZF for help tags
nmap <F1> :Helptags<CR>

" Instant Markdown preview
nmap <leader>ma :InstantMarkdownPreview<CR>

" PyShell
nmap <leader>re :call StartPyShell()<CR>
nmap <leader>res :call StopPyShell()<CR>:call VimuxCloseRunner()<CR>
nmap <leader>s :call PyShellSendLine()<CR>j
vmap <leader>s :call PyShellSendMultiLine()<CR>j
let g:pysparkMode=1

" Comfortable motion
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
" let g:comfortable_motion_impulse_multiplier = 0.2
" nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
" nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>

" Vim-test keybindings
nmap <silent><leader>tt :TestNearest<CR>
nmap <silent><leader>tf :TestFile<CR>
nmap <silent><leader>ta :TestSuite<CR>
nmap <silent><leader>ts :TestSuite<CR>
nmap <silent><leader>tl :TestLast<CR>

" Python Autoimport - For some reason is not sorting after adding the import
nmap <silent><M-CR> :ImportSymbol<CR>:CocCommand python.sortImports<CR>
imap <silent><M-CR> <Esc>:ImportSymbol<CR>:CocCommand python.sortImports<CR>a
" command! -buffer ImportOrganize :CocCommand python.sortImports

" Doge auto-docstring
let g:doge_mapping='<leader><leader>d'
