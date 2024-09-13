---------------------------------
-- For all filetypes
---------------------------------

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*",
	command = "lua vim.opt.foldmethod='indent'",
})

---------------------------------
-- Python section
---------------------------------

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*.py",
	command = "lua vim.opt.textwidth=88",
})

-- " Highlight for self
-- au FileType python match Boolean /self/

-- au FileType python syn keyword pythonDecorator True None False self
-- au FileType python inoremap <buffer> $r return
-- au FileType python inoremap <buffer> $i import
-- au FileType python inoremap <buffer> $p print
-- au FileType python inoremap <buffer> $f # --- <esc>a

-- " highlight python and self function
-- autocmd BufEnter *.py syntax match Type /\v\.[a-zA-Z0-9_]+\ze(\[|\s|$|,|\]|\)|\.|:)/hs=s+1
-- autocmd BufEnter *.py syntax match pythonFunction /\v[[:alnum:]_]+\ze(\s?\()/
-- " autocmd BufEnter *.py syn match Self "\(\W\|^\)\@<=self\(\.\)\@="
-- " highlight self ctermfg=239
-- autocmd BufEnter *.py syn keyword Purple self
-- autocmd BufEnter *.py syn keyword Purple cls
-- " highlight! link pythonBuiltin Aqua

---------------------------------
-- Golang section
---------------------------------

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "*.go",
	command = "lua vim.opt.foldmethod='syntax'",
})

---------------------------------
-- Shell section
---------------------------------
-- if exists('$TMUX')
--     if has('nvim')
--         set termguicolors
--     else
--         set term=screen-256color
--     endif
-- endif
