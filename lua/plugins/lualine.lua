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
	hide_in_width = function()
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
local pyenv = os.getenv("CONDA_DEFAULT_ENV")

ins_left({
	-- Change color according to Neovim's mode
	function()
		local mode_color = {
			n = colors.grey2,
			i = colors.green,
			v = colors.red,
			[""] = colors.red,
			V = colors.red,
			c = colors.blue,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}

		vim.api.nvim_command(
			"hi! LualineMode guibg=" .. mode_color[vim.fn.mode()] .. " guifg=" .. colors.bg .. " gui=bold"
		)
		vim.api.nvim_command("hi! LualineModeReverse guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)

		return pyenv .. " " -- return vim.fn.mode():upper() .. " "
	end,
	color = "LualineMode",
	padding = { left = 1, right = 0 },
})

-- ins_left({
-- 	function()
-- 		-- auto change color according to neovims mode
-- 		local mode_color = {
-- 			n = colors.grey2, i = colors.green, v = colors.red,
-- 			[""] = colors.red,
-- 			V = colors.red, c = colors.blue, no = colors.red,
-- 			s = colors.orange, S = colors.orange,
-- 			[""] = colors.orange,
-- 			ic = colors.yellow, R = colors.violet, Rv = colors.violet, cv = colors.red,
-- 			ce = colors.red, r = colors.cyan, rm = colors.cyan, ["r?"] = colors.cyan,
-- 			["!"] = colors.red, t = colors.red,
-- 		}
-- 		vim.api.nvim_command("hi! LualineModeReverse guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
-- 		-- return ''
-- 		return "▉"
-- 	end,
-- 	color = "LualineModeReverse", padding = { left = -1 }, })

local function getLastEntry(table)
	local count = (table and #table or false)
	if count then
		return table[count]
	end
	return false
end

function Split(s, delimiter)
	if s == nil or s == "" then
		return ""
	end
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return getLastEntry(result)
end

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
	condition = function()
		return navic.is_available()
	end,
	color = { fg = colors.grey2 },
	padding = { left = 1 },
})

-- ins_left {
--   function()
--     return ''
--   end,
--   color = {fg = colors.grey, bg = colors.bg},
--   padding = { left = -1, right = 0 }
-- }

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
	-- Lsp server name
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
	color = { fg = colors.blue, gui = "bold" },
})

ins_right({
	"branch",
	icon = "",
	-- condition = conditions.check_git_workspace, -- flickering when nvim-tree
	color = { fg = colors.cyan, bg = colors.bg, gui = "bold" },
	padding = { left = 0, right = 1 },
})

ins_right({
	"progress",
	color = { fg = colors.cyan, bg = colors.bg, gui = "bold" },
	padding = { left = 1, right = 2 },
})

ins_right({ "location", color = { bg = colors.bg }, padding = { right = 1 } })

-- Initialize lualine
require("lualine").setup(config)
