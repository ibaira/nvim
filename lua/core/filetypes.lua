---------------------------------
-- For all filetypes
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.foldmethod = "indent"
	end,
})

---------------------------------
-- Python section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt.textwidth = 88
	end,
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
-- Markdown section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt.textwidth = 80
		vim.opt.wrap = true
	end,
})

---------------------------------
-- Golang section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt.foldmethod = "syntax"
	end,
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
