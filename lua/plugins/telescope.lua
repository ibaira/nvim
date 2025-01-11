-- Telescope configuration
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		prompt_prefix = "$ ",
		selection_caret = "❯ ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "flex",
		layout_config = {
			prompt_position = "top",
			horizontal = { mirror = false, height = 0.99, width = 0.99, preview_width = 0.65 },
			vertical = { mirror = false, height = 0.99, width = 0.99, preview_height = 0.7 },
			preview_cutoff = 60,
		},
		mappings = { i = { ["<esc>"] = actions.close } },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden", -- Allow to search on .hidden files
		},
	},
})

-- To get extensions loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function
require("telescope").load_extension("fzf")

--------------------------------------------------------
-- Helper function
--------------------------------------------------------

function string.starts_with(str, start)
	return str:sub(1, #start) == start
end

function string.ends_with(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

---Get Git root folder
---@return string|nil root_folder The root folder, or nil if CWD is not in a Git repo
function Get_git_top_level()
	local root_folder = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if root_folder:starts_with("fatal") then
		return nil
	end
	return root_folder
end

---Choose files form repository instead of just the subfolder when file was opened with
---Telescope/nvim-tree/startify
_G.my_fd = function(opts)
	opts = opts or {}
	local root_folder = Get_git_top_level()
	if root_folder ~= nil then
		opts.cwd = root_folder
	end
	require("telescope.builtin").find_files(opts)
end

_G.my_rg = function(opts)
	opts = opts or {}
	local root_folder = Get_git_top_level()
	if root_folder ~= nil then
		opts.cwd = root_folder
	end
	require("telescope.builtin").live_grep(opts)
end
