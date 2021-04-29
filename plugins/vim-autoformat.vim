" Autoformat python with Autopep8
" let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
" let g:formatdef_black = "'black -l 79 --'"
" let g:formatters_python = ['black']  ", 'autopep8']
" let g:formatters_python = ['autopep8'] 

" Auformat upon writing file
" au BufWrite *.py  Autoformat
au BufWritePre *.py :CocCommand python.sortImports
" au BufWritePre *.py :Autoflake
