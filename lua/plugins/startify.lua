-- Startify configuration

local home_path = os.getenv("HOME")
if home_path == nil then
	home_path = ""
end

vim.g.startify_lists = {
	{ type = "files", header = { "   Files" } },
	{ type = "dir", header = { "   In " .. vim.fn.getcwd():gsub(home_path, "~") } },
	{ type = "sessions", header = { "   Sessions" } },
	{ type = "bookmarks", header = { "   Bookmarks" } },
}

vim.g.startify_bookmarks = {
	{ c = "~/.config/kitty/kitty.conf" },
	{ i = "~/.config/nvim/init.vim" },
	{ K = "~/.config/nvim/lua/core/keymaps.lua" },
	{ p = "~/.config/nvim/lua/core/lazy.lua" },
	{ o = "~/notes/todo.md" },
	{ t = "~/.tmux.conf" },
	{ T = "~/.config/nvim/lua/plugins/gruvbox.lua" },
	{ z = "~/.zshrc" },
}

-- Get rid of empty buffer and quit
vim.g.startify_enable_special = 0
vim.g.startify_custom_header = "startify#pad(startify#fortune#cowsay())"
