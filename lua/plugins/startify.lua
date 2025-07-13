-- Startify configuration

vim.g.startify_lists = {
	{ type = "files" },
	{ type = "bookmarks", header = { "    Bookmarks" } },
}

vim.g.startify_bookmarks = {
	{ c = "~/.config/kitty/kitty.conf" },
	{ d = "~/.config/harper-ls/dictionary.txt" },
	{ g = "~/.config/nvim/lua/plugins/gruvbox.lua" },
	{ G = "~/.config/ghostty/config" },
	{ i = "~/.config/nvim/init.lua" },
	{ K = "~/.config/nvim/lua/core/keymaps.lua" },
	{ l = "~/.config/nvim/lua/core/lazy.lua" },
	{ L = "~/.config/lazygit/config.yml" },
	{ r = "~/.config/ruff/pyproject.toml" },
	{ t = "~/.tmux.conf" },
	{ T = "~/notes/todo.md" },
	{ z = "~/.zshrc" },
}

-- Get rid of empty buffer and quit
vim.g.startify_enable_special = 0
vim.g.startify_change_to_dir = 0
vim.g.startify_change_to_vcs_root = 0
vim.g.startify_fortune_use_unicode = true
vim.g.startify_custom_header = "startify#pad(startify#fortune#cowsay())"
