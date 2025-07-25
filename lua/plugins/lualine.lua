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
		local file_path = vim.fn.expand("%:p:h")
		local git_dir = vim.fn.finddir(".git", file_path .. ";")
		return git_dir and #git_dir > 0 and #git_dir < #file_path
	end,
}

-- Config
local theme = "gruvbox"
local config = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = { normal = { c = theme }, inactive = { c = theme } },
		disabled_filetypes = { "startify" },
		globalstatus = true,
		icons_enabled = false,
	},
	-- Remove the defaults
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_v = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in winbar
local function ins_left_winbar(component)
	table.insert(config.winbar.lualine_c, component)
	table.insert(config.inactive_winbar.lualine_c, component)
end

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
	table.insert(config.inactive_sections.lualine_c, component)
end

-- Python environment with nvim mode colored background
ins_left({
	function()
		local venv = os.getenv("VIRTUAL_ENV_PROMPT")
		if venv then
			return venv:sub(2, -3) -- remove first and last characters '()'
		end

		venv = os.getenv("VIRTUAL_ENV")
		if venv then
			return "uv"
		end

		venv = os.getenv("CONDA_DEFAULT_ENV")
		if venv then
			return venv
		end
		return ""
	end,
	color = "@variable",
	padding = { left = 2, right = 0 },
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

ins_left({
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
				-- Give priority to other LSPs, not Harper grammar checker
				if client.name ~= "harper_ls" then
					return client.name
				else
					msg = client.name
				end
			end
		end
		return msg
	end,
	cond = conditions.width_above_80,
	color = "GruvboxBlueBold",
	padding = { left = 2, right = 1 },
})

local noice_statusline_mode = require("noice").api.statusline.mode
ins_left({
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

-- Winbar
ins_left_winbar({
	function()
		return vim.fn.fnamemodify(vim.fn.expand("%"), ":p:~:.")
	end,
	condition = conditions.buffer_not_empty,
	path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
	file_status = true,
	color = "WinBarFilename",
	padding = { left = 1, right = 1 },
})

ins_left_winbar({
	-- To enforce change of background color for the rest of the winbar
	function()
		return " "
	end,
	color = "GruvboxYellowBold",
	padding = { left = 0, right = 0 },
})

local navic = require("nvim-navic")
ins_left_winbar({
	function()
		return navic.get_location()
	end,
	condition = navic.is_available,
	path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
	file_status = true,
	color = { "GruvboxYellowBold" },
	padding = { left = 1, right = 0 },
})

-- Initialize lualine
require("lualine").setup(config)
