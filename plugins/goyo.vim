" Goyo configuration
" Presentation mode
noremap <silent><Left> :silent bp<CR>:redraw!<CR>
noremap <silent><Right> :silent bn<CR>:redraw!<CR>
nmap <silent><F7> :set noshowcmd noshowmode shortmess+=F<CR>:Goyo<CR>
