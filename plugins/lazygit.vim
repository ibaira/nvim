" Lazygit configuration
nnoremap <silent><leader><leader>g :LazyGit<CR>
let g:lazygit_floating_window_scaling_factor = 1.0

" FZF
nnoremap <silent><leader>f :Files<CR>
nnoremap <silent><leader>gs :GFiles?<CR> 
nnoremap <silent><leader>l :BLines<CR>
nnoremap <silent><C-b> :Buffers<CR>
" Ripgrep search
nnoremap <C-f> :Rg!<CR>
set rtp+=~/.fzf

let g:fzf_layout = { 'window': { 'width': 1.00, 'height': 1.00 } }

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:70%', 'ctrl-/']

" We use BAT to colorize the preview when using FZF
" let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:70%' --layout reverse --margin=1,2 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
let $FZF_DEFAULT_OPTS="--layout=reverse --preview 'COLORTERM=truecolor ~/.vim/plugged/fzf.vim/bin/preview.sh {}' --preview-window 'right:70%' --preview-window noborder"
" let $FZF_DEFAULT_OPTS="--layout=reverse --preview 'COLORTERM=truecolor bat' --preview-window 'right:70%' --preview-window noborder"
"--info=inline --ansi --preview-window 'right:70%' --layout reverse --margin=1,2 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
