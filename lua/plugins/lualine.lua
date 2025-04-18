-- Lualine configuration
local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	width_above_80 = function()
		return vim.fn.winwidth(0) > 80
	end,
	width_above_88 = function()
		return vim.fn.winwidth(0) > 88
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local theme = "gruvbox"
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = { normal = { c = theme }, inactive = { c = theme } },
		disabled_filetypes = { "startify" },
		globalstatus = true,
		icons_enabled = false,
	},
	sections = {
		-- Remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- Remove the defaults
		lualine_a = {},
		lualine_v = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	extensions = { "nvim-tree" },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
	table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
	table.insert(config.inactive_sections.lualine_x, component)
end

-- Python environment with nvim mode colored background
ins_left({
	function()
		local venv = os.getenv("VIRTUAL_ENV_PROMPT")
		if venv then
			return venv
		end
		local conda_env = os.getenv("CONDA_DEFAULT_ENV")
		if conda_env then
			return conda_env
		end
		return ""
	end,
	color = "@variable",
	padding = { left = 1, right = 0 },
})

ins_left({
	"filename",
	condition = conditions.buffer_not_empty,
	path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
	file_status = true,
	color = "GruvboxYellowBold",
	padding = { left = 2, right = 0 },
	-- fmt = function(str) return string.format("%-15s", str) end,
})

ins_left({ "progress", color = "String", padding = { left = 3 } })

ins_left({
	function()
		return "col: " .. string.format("%02d", vim.api.nvim_win_get_cursor(0)[2]) -- column value only
	end,
	padding = { left = 2 },
	color = "GruvboxFg0",
})

ins_left({
	"branch",
	icon = "",
	cond = conditions.check_git_workspace,
	color = "@function",
	padding = { left = 2 },
	fmt = function(str)
		return "(" .. str .. ")"
	end,
})

ins_left({ "fileformat", color = "Constant", padding = { left = 2 } })

local noice_statusline_mode = require("noice").api.statusline.mode
ins_right({
	-- Display recording macro message
	function()
		local mode = noice_statusline_mode.get()
		if string.find(mode, "recording") then
			return mode
		end
		return ""
	end,
	cond = noice_statusline_mode.has,
	color = "Operator",
	padding = { left = 2 },
})

ins_right({
	-- LSP server name
	function()
		local msg = ""
		local buf_ft = vim.api.nvim_get_option_value("filetype", {})
		local clients = vim.lsp.get_clients()
		if next(clients) == nil then
			return msg
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config["filetypes"]
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	cond = conditions.width_above_80,
	color = "GruvboxBlueBold",
	padding = { left = 2, right = 1 },
})

-- Initialize lualine
require("lualine").setup(config)
