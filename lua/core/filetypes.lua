---------------------------------
-- For all filetypes
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.foldmethod = "indent"
		vim.opt.shiftwidth = 4
		vim.opt.tabstop = 4
	end,
})

---------------------------------
-- Python section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt.textwidth = 88
		vim.opt.wrap = false
	end,
})

---------------------------------
-- Markdown section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt.textwidth = 80
		vim.opt.wrap = true
		-- To fix folds with indent size = 2
		vim.opt.shiftwidth = 2
		vim.opt.tabstop = 2
	end,
})

---------------------------------
-- Toml section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "toml",
	callback = function()
		-- To fix folds with indent size = 2
		vim.opt.shiftwidth = 2
		vim.opt.tabstop = 2
	end,
})

---------------------------------
-- YAML section
---------------------------------

vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt.shiftwidth = 2
		vim.opt.tabstop = 2
		vim.opt.wrap = true
	end,
})
