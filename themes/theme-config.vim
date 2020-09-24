" Colorscheme options

" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

colorscheme onedark

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
set background=dark

" General view 
set termguicolors

" Overwrite colorscheme line highlight color
au Colorscheme * :hi CursorLine guibg=#212536 
au Colorscheme * :hi CursorColumn guibg=#212536 

set cursorline  " Current line highlighted

" Options are in .pylintrc!
highlight VertSplit ctermbg=253

" A bit lighter comments for increased readability
au Colorscheme * :hi Comment guifg=#777c85


