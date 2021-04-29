" Settings
syntax on
filetype indent on

set fileformat=unix
set shortmess+=c
au Colorscheme * :set cmdheight=1  " single line cmd line

set mouse=a  " change cursor per mode
set number  " always show current line number
set smartcase  " better case-sensitivity when searching
set wrapscan  " begin search from top of file when nothing is found anymore

set expandtab
set tabstop=4
set shiftwidth=4
set fillchars+=vert:\  " remove chars from seperators
set softtabstop=4

set history=1000  " remember more commands and search history

set nobackup  " no backup or swap file, live dangerously
set noswapfile  " swap files give annoying warning

set breakindent  " preserve horizontal whitespace when wrapping
set showbreak=..
set lbr  " wrap words
set nowrap  " i turn on wrap manually when needed

set scrolloff=7 " keep three lines between the cursor and the edge of the screen

set undodir=~/.vim/undodir
set undofile  " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000  " maximum number lines to save for undo on a buffer reload

set noshowmode  " keep command line clean
set noshowcmd

set laststatus=2  " always slow statusline

set splitright  " i prefer splitting right and below
set splitbelow

set hlsearch  " highlight search and search while typing
set incsearch
set cpoptions+=x  " stay at seach item when <esc>

set noerrorbells  " remove bells (i think this is default in neovim)
set visualbell
set t_vb=
" set relativenumber
set viminfo='20,<1000  " allow copying of more than 50 lines to other applications

" set clipboard=unnamedplus
set completeopt=menuone,noselect,noinsert,preview

au! BufWritePost $MYVIMRC source %  " auto source when writting to init.vim
" Toggle relative line numbers
nnoremap <leader>r :set relativenumber!<CR>

set pumheight=5

" Default folding method 
set foldcolumn=0
set foldmethod=syntax
setlocal foldlevelstart=99

" Indent character
let g:indentLine_char_list = ['·']  "['┊', '¦', '┆'] https://en.wikipedia.org/wiki/Interpunct

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction

" Remove all trailing whitespace by pressing C-S
nnoremap <C-S> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" move between defs python:
" NOTE: this break shortcuts with []
nnoremap [[ [m
nnoremap ]] ]m

nnoremap <silent><nowait> [ [[
nnoremap <silent><nowait> ] ]]

au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <C-a> <Esc>
nnoremap <C-x> <Esc>

" Enable Omni completion 
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Copy to Windows clipboard
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" Do not start automatically instant_markdown
let g:instant_markdown_autostart = 0

set clipboard+=unnamedplus

" Neoterm vertical split by default instead of openning in current buffer
" let g:neoterm_default_mod="vsplit"
" nmap <leader>w :TREPLSendLine<CR>
" vmap <leader>w :TREPLSendSelection<CR>

" Vimspector signs
sign define vimspectorBP         text=\ ● texthl=Orange
sign define vimspectorBPCond     text=\ ◆ texthl=WarningMsg
sign define vimspectorBPDisabled text=\ ● texthl=LineNr
sign define vimspectorPC         text=\ ▶ texthl=Green linehl=CursorLine
sign define vimspectorPCBP       text=●▶  texthl=Green linehl=CursorLine

" Hide . directory in netwr
let g:netrw_list_hide = '^\./$'
let g:netrw_hide = 1

" Explore directory with Netwr when running: 'vim .'
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * if argv(0) == "." | Explore! | endif
augroup END

set pumheight=20
set updatetime=10
