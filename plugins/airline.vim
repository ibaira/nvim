" Airline configuration
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Airline settings
" do not show error/warning section
let g:airline_section_error = ""
let g:airline_section_warning = ""
let g:airline#extensions#coc#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#left_sep = '◣'
let g:airline_left_sep = '◣'
let g:airline_left_alt_sep = '╲'
let g:airline_right_sep = '◢'
let g:airline_right_alt_sep = ''
let g:airline_section_x = ''
let g:airline_section_y = '%{&fileformat}'
let g:airline_section_z = '%3p%% %3l/%L:%2v'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#buffers_label = ' '
" let g:airline#extensions#tabline#buffers_label = '%{strftime("%H:%M")}'
