-- Startify configuration

local home_path = os.getenv("HOME")
if home_path == nil then
	home_path = ""
end

vim.g.startify_lists = {
	{ type = "files" },
	{ type = "dir", header = { "    CWD: " .. vim.fn.getcwd():gsub(home_path, "~") } },
	{ type = "bookmarks", header = { "    Bookmarks" } },
}

vim.g.startify_bookmarks = {
	{ c = "~/.config/kitty/kitty.conf" },
	{ d = "~/.config/harper-ls/dictionary.txt" },
	{ g = "~/.config/nvim/lua/plugins/gruvbox.lua" },
	{ i = "~/.config/nvim/init.vim" },
	{ K = "~/.config/nvim/lua/core/keymaps.lua" },
	{ l = "~/.config/nvim/lua/core/lazy.lua" },
	{ L = "~/.config/lazygit/config.yml" },
	{ o = "~/notes/todo.md" },
	{ r = "~/.config/ruff/pyproject.toml" },
	{ t = "~/.tmux.conf" },
	{ z = "~/.zshrc" },
}

-- Get rid of empty buffer and quit
vim.g.startify_enable_special = 0
vim.g.startify_change_to_dir = 0
vim.g.startify_change_to_vcs_root = 0
vim.g.startify_fortune_use_unicode = true
vim.g.startify_custom_header = "startify#pad(startify#fortune#cowsay())"
-- vim.g.startify_custom_header = "startify#pad(startify#fortune#boxed())"
