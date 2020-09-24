" Ncm2 configuration
autocmd BufEnter * call ncm2#enable_for_buffer()

" make it FAST
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'
