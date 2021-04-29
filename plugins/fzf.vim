" Remove preview window when it's not necessary
command! -bar -bang Maps call fzf#vim#maps("n", {'options': ['--layout=reverse', '--preview-window=hidden']}, <bang>0)
command! -bang -nargs=* Lines call fzf#vim#lines(<q-args>, {'options': ['--layout=reverse', '--preview-window=hidden']}, <bang>0)
command! -bang -nargs=* BLines call fzf#vim#buffer_lines(<q-args>, {'options': ['--layout=reverse', '--preview-window=hidden']}, <bang>0)
command! -bar -bang Helptags call fzf#vim#helptags({'options': ['--layout=reverse', '--preview-window=hidden']}, <bang>0)

