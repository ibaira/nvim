-- Gruvbox configuration
local gruvbox_palette = {
	dark0_hard = "#1d2021",
	dark0 = "#282828",
	dark0_soft = "#32302f",
	dark1 = "#3c3836",
	dark2 = "#504945",
	dark3 = "#665c54",
	dark4 = "#7c6f64",

	light0_hard = "#f9f5d7",
	light0 = "#fbf1c7",
	light0_soft = "#f2e5bc",
	light1 = "#ebdbb2",
	light2 = "#d5c4a1",
	light3 = "#bdae93",
	light4 = "#a89984",

	bright_red = "#fb4934",
	bright_green = "#b8bb26",
	bright_yellow = "#fabd2f",
	bright_blue = "#83a598",
	bright_purple = "#d3869b",
	bright_aqua = "#8ec07c",
	bright_orange = "#fe8019",

	neutral_red = "#cc241d",
	neutral_green = "#98971a",
	neutral_yellow = "#d79921",
	neutral_blue = "#458588",
	neutral_purple = "#b16286",
	neutral_aqua = "#689d6a",
	neutral_orange = "#d65d0e",

	faded_red = "#9d0006",
	faded_green = "#79740e",
	faded_yellow = "#b57614",
	faded_blue = "#076678",
	faded_purple = "#8f3f71",
	faded_aqua = "#427b58",
	faded_orange = "#af3a03",

	dark_red_hard = "#792329",
	dark_red = "#722529",
	dark_red_soft = "#7b2c2f",
	light_red_hard = "#fc9690",
	light_red = "#fc9487",
	light_red_soft = "#f78b7f",
	dark_green_hard = "#5a633a",
	dark_green = "#62693e",
	dark_green_soft = "#686d43",
	light_green_hard = "#d3d6a5",
	light_green = "#d5d39b",
	light_green_soft = "#cecb94",
	dark_aqua_hard = "#3e4934",
	dark_aqua = "#49503b",
	dark_aqua_soft = "#525742",
	light_aqua_hard = "#e6e9c1",
	light_aqua = "#e8e5b5",
	light_aqua_soft = "#e1dbac",
	gray = "#928374",
}

local gruvbox_material_palette = { -- fg0 = "#d4be98", fg1 = "#ddc7a1",
	bright_red = "#ea6962",
	bright_orange = "#e78a4e",
	bright_yellow = "#d8a657",
	bright_green = "#a9b665",
	bright_aqua = "#89b482",
	bright_blue = "#7daea3",
	bright_purple = "#d3869b",
}

_G.colors = {
	bg = gruvbox_palette.dark0,
	bg1 = gruvbox_palette.dark1,
	fg = gruvbox_palette.light1,
	-- blue = gruvbox_palette.bright_blue,
	yellow = gruvbox_palette.bright_yellow,
	purple = gruvbox_palette.bright_purple,
	red = gruvbox_palette.bright_red,
	green = gruvbox_palette.bright_green,
	orange = gruvbox_palette.bright_orange,
	-- cyan = gruvbox_palette.bright_aqua,
	comment = gruvbox_palette.gray,
	neutral_blue = gruvbox_palette.neutral_blue,
	darkblue = gruvbox_palette.faded_blue,
	violet = gruvbox_palette.bright_purple,
	magenta = gruvbox_palette.bright_purple,
	grey = gruvbox_palette.dark1, -- grey = "#363636"
	grey2 = gruvbox_palette.dark3, -- grey2 = "#777777"

	-- bg = gruvbox_material_palette.dark0,
	-- bg1 = gruvbox_material_palette.dark1,
	-- fg = gruvbox_material_palette.light1,
	blue = gruvbox_material_palette.bright_blue,
	-- yellow = gruvbox_material_palette.bright_yellow,
	-- purple = gruvbox_material_palette.bright_purple,
	-- red = gruvbox_material_palette.bright_red,
	-- green = gruvbox_material_palette.bright_green,
	-- orange = gruvbox_material_palette.bright_orange,
	cyan = gruvbox_material_palette.bright_aqua,
	-- comment = gruvbox_material_palette.gray,
	-- neutral_blue = gruvbox_material_palette.neutral_blue,
	-- darkblue = gruvbox_material_palette.faded_blue,
	-- violet = gruvbox_material_palette.bright_purple,
	-- magenta = gruvbox_material_palette.bright_purple,
	-- grey = gruvbox_palette.dark1, -- grey = "#363636"
	-- grey2 = gruvbox_palette.dark3, -- grey2 = "#777777"
}

local function_color = _G.colors.cyan

local overrides = {
	-- `TODO` comments
	["@comment.todo.comment"] = { fg = _G.colors.green, bold = true },
	["@comment.error.comment"] = { fg = _G.colors.red, bold = true },
	["@comment.note.comment"] = { fg = _G.colors.purple, bold = true },
	["@comment.warning.comment"] = { fg = _G.colors.orange, bold = true },
	["@punctuation.delimiter.comment"] = { fg = _G.colors.comment },

	-- Languages
	["@constant.builtin"] = { fg = _G.colors.purple },
	["@constructor"] = { fg = _G.colors.purple },

	["@function"] = { fg = function_color },
	["@function.builtin"] = { fg = function_color },
	["@function.call"] = { fg = function_color },
	["@function.method"] = { fg = function_color },

	["@keyword.import"] = { fg = _G.colors.red },
	["@lsp.type.method"] = { fg = function_color },
	["@variable.builtin"] = { fg = _G.colors.purple },

	-- Markdown
	["@markup.heading.1.markdown"] = { fg = _G.colors.red },
	["@markup.heading.2.markdown"] = { fg = _G.colors.red },
	["@markup.heading.3.markdown"] = { fg = _G.colors.red },
	["@markup.heading.4.markdown"] = { fg = _G.colors.red },
	["@markup.list.markdown"] = { fg = _G.colors.purple },

	-- Folds
	Folded = { fg = _G.colors.comment, bg = _G.colors.bg, italic = true },

	-- Floating window
	FloatBorder = { fg = gruvbox_palette.light3 },
	NormalFloat = { bg = _G.colors.bg },

	-- Noice's command line window icon and border
	NoiceCmdlinePopupTitleInput = { fg = _G.colors.blue, bg = _G.colors.bg },
	NoiceCmdlinePopupBorder = { fg = _G.colors.blue, bg = _G.colors.bg },
	NoiceCmdlinePopupBorderCmdline = { fg = _G.colors.blue, bg = _G.colors.bg },

	NoiceCmdlineIcon = { fg = _G.colors.blue, bg = _G.colors.bg },
	NoiceCmdlineIconSearch = { fg = _G.colors.yellow, bg = _G.colors.bg },
	NoiceCmdlineIconLua = { fg = _G.colors.red, bg = _G.colors.bg },
	NoiceCmdlineIconHelp = { fg = _G.colors.blue, bg = _G.colors.bg },
	NoiceCmdlineIconFilter = { fg = _G.colors.purple, bg = _G.colors.bg },

	NoiceCmdlinePopupBorderSearch = { fg = _G.colors.yellow, bg = _G.colors.bg },
	NoiceCmdlinePopupBorderLua = { fg = _G.colors.red, bg = _G.colors.bg },
	NoiceCmdlinePopupBorderHelp = { fg = _G.colors.blue, bg = _G.colors.bg },
	NoiceCmdlinePopupBorderFilter = { fg = _G.colors.purple, bg = _G.colors.bg },

	-- Hop
	HopNextKey = { fg = _G.colors.red, bg = _G.colors.bg },
	HopNextKey1 = { fg = _G.colors.red, bg = _G.colors.bg },
	HopNextKey2 = { fg = _G.colors.red, bg = _G.colors.bg },

	-- Nvim-tree
	NvimTreeFolderArrowOpen = { fg = _G.colors.blue },
	NvimTreeFolderName = { fg = _G.colors.blue },
	NvimTreeGitDirty = { fg = _G.colors.red },
	NvimTreeGitNewIcon = { fg = _G.colors.orange },
	NvimTreeIndentMarker = { fg = _G.colors.neutral_blue },
	NvimTreeOpenedFile = { fg = _G.colors.purple },
	NvimTreeOpenedFolderName = { fg = _G.colors.blue },
	NvimTreeOpenedHL = { fg = _G.colors.purple },
	NvimTreeRootFolder = { fg = _G.colors.purple },
	NvimTreeSpecialFile = { fg = _G.colors.yellow },
	NvimTreeStatusLine = { fg = _G.colors.bg }, -- Fix annoying offset

	-- Gitsigns
	GitSignsAdd = { fg = _G.colors.green, bg = _G.colors.bg1 },
	GitSignsDelete = { fg = _G.colors.red, bg = _G.colors.bg1 },
	GitSignsChange = { fg = _G.colors.purple, bg = _G.colors.bg1 },
	GitSignsAddPreview = { fg = _G.colors.green, bg = _G.colors.bg },
	GitSignsDeletePreview = { fg = _G.colors.red, bg = _G.colors.bg },

	-- Incline
	InclineNormal = { fg = _G.colors.yellow, bg = _G.colors.bg1 },
	InclineNormalNC = { fg = _G.colors.yellow, bg = _G.colors.bg1 },

	-- Fix annotying space with wrong bg color
	StatusLine = { fg = _G.colors.bg, bg = _G.colors.bg },
	StatusLineNC = { fg = _G.colors.bg, bg = _G.colors.bg },

	-- Diagnostic messages
	DiagnosticSignError = { fg = _G.colors.red, bg = _G.colors.bg },
	DiagnosticSignHint = { fg = _G.colors.cyan, bg = _G.colors.bg },
	DiagnosticSignInfo = { fg = _G.colors.blue, bg = _G.colors.bg },
	DiagnosticSignWarn = { fg = _G.colors.orange, bg = _G.colors.bg },
	DiagnosticWarn = { link = "GruvboxOrange" },
	DiagnosticVirtualTextWarn = { link = "GruvboxOrange" },
}

require("gruvbox").setup({
	terminal_colors = true, -- add neovim terminal colors
	undercurl = true,
	underline = true,
	bold = true,
	italic = { strings = false, emphasis = false, comments = false, operators = false, folds = true },
	strikethrough = false,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	overrides = overrides,
	dim_inactive = false,
	transparent_mode = false,
	palette_overrides = {
		bright_blue = gruvbox_material_palette.bright_blue,
		-- bright_red = gruvbox_material_palette.bright_red,
		-- bright_yellow = gruvbox_material_palette.bright_yellow,
		-- bright_purple = gruvbox_material_palette.bright_purple,
		-- bright_aqua = gruvbox_material_palette.bright_aqua,
		-- bright_orange = gruvbox_material_palette.bright_orange,
		-- bright_green = gruvbox_material_palette.bright_green,
	},
})

vim.cmd.colorscheme("gruvbox")
