" Colorscheme options

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
set background=dark

" General view 
set termguicolors
set cursorline  " Current line highlighted

" Easy Motion target colors
au Colorscheme * highlight EasyMotionTarget guifg=orange guibg=NONE
au Colorscheme * highlight EasyMotionTarget2First guifg=orange guibg=NONE
au Colorscheme * highlight EasyMotionTarget2Second guifg=orange guibg=NONE
au Colorscheme * highlight Cursor cterm=reverse gui=reverse ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor
"     \,sm:block-blinkwait175-blinkoff150-blinkon175

colorscheme gruvbox-material
