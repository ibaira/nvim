-- Tree sitter configuration

require("nvim-treesitter.configs").setup({
	ensure_installed = { "python", "lua", "rust", "vim", "c", "go" }, -- "all", "maintained" (parsers with maintainers), or list of languages
	ignore_install = {}, -- List of parsers to ignore installing
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true }, -- fix issue with Python indent in new lines
})
