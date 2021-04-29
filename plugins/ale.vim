"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': [],
\   'go': ['go', 'golint', 'errcheck']
\}
" \   'python': ['pyright', 'pylint', 'flake8', 'pyflakes', 'pydocstyle'],

" let g:ale_fixers = { 'python': ['black', 'autoimport'] }

" nmap <silent><leader>a <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
" Disable linting for all minified JS files.
let g:ale_pattern_options = {'\.py$': {'ale_enabled': 0}}

" let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503 --max-line-length 89'
" let g:ale_python_pylint_options = '-j 0 --max-line-length=88'
" let g:ale_lint_on_filetype_changed = 0
" let g:ale_floating_preview = 1
" let g:ale_hover_to_floating_preview = 1
" let g:ale_hover_to_preview = 1
