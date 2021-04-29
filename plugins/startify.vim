" Startify configuration
let g:startify_lists = [
    \ {'type': 'files',       'header': ['   Files']},
    \ {'type': 'dir',         'header': ['   In '. substitute(getcwd(), $HOME, '~', '')]},
    \ {'type': 'sessions',    'header': ['   Sessions']},
    \ {'type': 'bookmarks',   'header': ['   Bookmarks']}
    \ ]

let g:startify_bookmarks = [
    \ { 'a': '~/.config/nvim/plugins/airline.vim' },
    \ { 'c': '~/.config/kitty/kitty.conf' },
    \ { 'i': '~/.config/nvim/init.vim' },
    \ { 'p': '~/.config/nvim/vim-plug/plugins.vim' },
    \ { 't': '~/.tmux.conf' },
    \ { 'T': '~/.config/nvim/themes/theme-config.vim' },
    \ { 'z': '~/.zshrc' },
    \ ]

" Get rid of empty buffer and quit
let g:startify_enable_special = 0
let g:startify_custom_header = 'startify#pad(startify#fortune#boxed())'
" let g:startify_custom_header = 'startify#pad(startify#fortune#cowsay())'
