" Vim-go configuration
" Automatic autocomplete suggestion
" function! OpenCompletion()
"     call feedkeys("\<C-x>\<C-o>", "n")
" endfunction
" au BufReadPost,BufNewFile *.go | autocmd InsertCharPre * call OpenCompletion()
" au BufReadPost,BufNewFile *.cs | autocmd InsertCharPre * call OpenCompletion()

au FileType go set completeopt-=preview
au FileType go inoremap <C-l> <C-x><C-o>
au FileType go inoremap <C-Space> <C-x><C-o>

" Override coc go to reference to show referrers
au FileType go nmap gr :GoReferrers<CR>
au FileType go nmap <leader>gi :GoImports<CR>
au FileType go nmap <leader>gt :GoTest<CR>
au FileType go nmap <leader>gr :GoRun<CR>
au FileType go nmap <leader>rn :GoRename<CR>

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_metalinter_autosave_enabled=['golint', 'govet']
" Disable vim-go mapping for go to definition
" let g:go_def_mapping_enabled=0
let g:go_def_reuse_buffer = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_decls_mode='fzf'
let g:go_imports_autosave = 1
let g:go_doc_keywordprg_enabled = 1
let g:go_doc_popup_window = 1
let g:go_metalinter_autosave = 1
let g:go_term_enabled = 1
let g:go_term_mode = "vsplit"
let g:go_term_close_on_exit = 0
let g:go_term_reuse = 1
let g:go_jump_to_error = 0
