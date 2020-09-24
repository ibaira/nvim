" Quickscope configuration
au Colorscheme * :hi QuickScopePrimary guifg='#e5c07b' gui=underline ctermfg=155 cterm=underline
au Colorscheme * :hi QuickScopeSecondary guifg='#e06c75' gui=underline ctermfg=155 cterm=underline
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
