" Airline general configuration
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
let g:airline#extensions#tabline#left_sep = ""
let g:airline#extensions#tabline#right_sep = ""
let g:airline_left_sep = "" " ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ""

" let g:airline#extensions#tabline#left_sep = "\uE0B0"
" let g:airline#extensions#tabline#right_sep = "\uE0B6"
" let g:airline_left_sep = "\uE0B4" " ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = "\uE0B6"
let g:airline_right_alt_sep = ''
let g:airline_section_x = ''
let g:airline_section_y = '%#__accent_bold#%0p%%'  " %{&fileformat}
" let g:airline_section_z = "%#__accent_bold#%0l/%L \uE0B7\uE0B7 %0v%#__restore__#"
let g:airline_section_z = "%#__accent_bold#%0l/%L : %0v%#__restore__#"

" Bold accents on specific areas
" 'none' brings it back to normal accent
call airline#parts#define_accent('mode', 'bold')
call airline#parts#define_accent('branch', 'bold')  " creates a weird letter when no info
call airline#parts#define_accent('file', 'bold')
call airline#parts#define_accent('hunks', 'white')

" Tabline style
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#buffers_label = "%{substitute(getcwd(),$HOME,'~','')}"

" Symbols
let g:airline_symbols.dirty="🔥"
let g:airline_symbols.branch = " " "  \uE0B5"
" 🔥📌🔴🔺🚧🚦🚥 ❌❗✳️ *️'

" Use single letter for Vim mode
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }

" remove separators for empty sections
let g:airline_skip_empty_sections = 1
" skip file format
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" let g:airline_statusline_ontop=1
set noruler
" set laststatus=0
" set noshowmode
" set noshowcmd
