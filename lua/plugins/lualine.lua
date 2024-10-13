-- Lualine configuration

local colors = {
	-- bg = "#292929",
	-- fg = "#ddc7a1",
	-- yellow = "#d8a657",
	-- cyan = "#89b482",
	-- darkblue = "#7daea3",
	-- green = "#a9b665",
	-- orange = "#e78a4e",
	-- violet = "#d3869b",
	-- magenta = "#d3869b",
	-- blue = "#7daea3",
	-- red = "#ea6962",
	-- grey = "#363636",
	-- grey2 = "#777777",

	bg = _G.colors.bg,
	fg = _G.colors.fg,
	yellow = _G.colors.yellow,
	cyan = _G.colors.cyan,
	darkblue = _G.colors.darkblue,
	green = _G.colors.green,
	orange = _G.colors.orange,
	violet = _G.colors.violet,
	magenta = _G.colors.magenta,
	blue = "#7daea3",
	red = _G.colors.red,
	grey = _G.colors.grey,
	grey2 = _G.colors.comment,
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	width_above_80 = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		theme = { normal = { c = "gruvbox" }, inactive = { c = "gruvbox" } },
		disabled_filetypes = { "NvimTree", "startify" },
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
	color = "LualineMode",
	padding = { left = 1, right = 0 },
})

ins_left({
	"filename",
	condition = conditions.buffer_not_empty,
	path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
	file_status = true,
	color = { fg = colors.yellow, bg = colors.bg, gui = "bold" },
	padding = { left = 2 },
})

local navic = require("nvim-navic")
ins_left({
	function()
		return ":: " .. navic.get_location()
	end,
	condition = navic.is_available,
	color = { fg = colors.grey2 },
	padding = { left = 1 },
})

-- ins_left {
--   'diff',
--   symbols = {added = '+', modified = '~', removed = '-'},
--   color_added = colors.green,
--   color_modified = colors.orange,
--   color_removed = colors.red,
--   condition = conditions.hide_in_width,
--   padding = { left = 2, right = 0 }
-- }

-- ins_right({
-- 	"diagnostics",
-- 	sources = { "nvim_diagnostic" },
-- 	color_error = colors.red,
-- 	color_warn = colors.orange,
-- 	color_info = colors.blue,
-- 	color_hint = colors.cyan,
-- 	symbols = { error = "", warn = "", info = "", hint = "" },
-- })

ins_right({
	-- Display recording macro message
	function()
		local mode = require("noice").api.statusline.mode.get()
		if string.find(mode, "recording") then
			return mode
		end
		return ""
	end,
	condition = require("noice").api.statusline.mode.has,
	color = { fg = colors.orange },
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
	icon = "",
	condition = conditions.width_above_80,
	color = { fg = colors.blue, gui = "bold" },
})

ins_right({
	"branch",
	icon = "",
	condition = conditions.check_git_workspace, -- flickering when nvim-tree
	color = { fg = colors.cyan, gui = "bold" },
	padding = { left = 0, right = 1 },
})

ins_right({
	"progress",
	color = { fg = colors.yellow, gui = "bold" },
	padding = { left = 1, right = 2 },
})

ins_right({ "location", padding = { right = 1 } })

-- Initialize lualine
require("lualine").setup(config)
