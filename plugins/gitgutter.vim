" Git Gutter configuration
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

" GitGutter not by default
let g:gitgutter_enabled = 1

" Toogle GitGutter
nnoremap <silent><leader>d :GitGutterToggle<cr>
nmap <silent>,g :GitGutterPreviewHunk<CR>
nmap <silent>gn :GitGutterNextHunk<CR>
nmap <silent>gp :GitGutterPrevHunk<CR>
