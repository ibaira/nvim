" Lazygit configuration
nnoremap <silent><leader>lg :LazyGit<CR>
let g:lazygit_floating_window_scaling_factor = 1.0

" FZF
nnoremap <silent><leader>f :Files<CR>
nnoremap <silent><leader>gs :GFiles?<CR> 
nnoremap <silent><leader>l :BLines<CR>
nnoremap <silent><C-b> :Buffers<CR>
" Ripgrep search
nnoremap <C-f> :Rg! 
set rtp+=~/.fzf

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.95 } }
" We use BAT to colorize the preview when using FZF
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
