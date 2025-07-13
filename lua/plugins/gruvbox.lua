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

local gruvbox_material_palette = {
	bright_red = "#ea6962",
	bright_orange = "#e78a4e",
	bright_yellow = "#d8a657",
	-- bright_green = "#a9b665",
	-- bright_aqua = "#89b482",
	bright_blue = "#7daea3",
}

-- This is the single entrypoint to modify the default color palette
local colors = {}
if vim.o.background == "dark" then
	colors.bg0 = gruvbox_palette.dark0_hard
	colors.bg = gruvbox_palette.dark0
	colors.bg1 = gruvbox_palette.dark1
	colors.fg = gruvbox_palette.light1

	colors.blue = gruvbox_material_palette.bright_blue
	colors.cyan = gruvbox_palette.bright_aqua
	colors.darkblue = gruvbox_palette.faded_blue
	colors.green = gruvbox_palette.bright_green
	colors.grey = gruvbox_palette.dark1
	colors.grey2 = gruvbox_palette.dark3
	colors.neutral_blue = gruvbox_palette.neutral_blue
	colors.orange = gruvbox_material_palette.bright_orange
	colors.purple = gruvbox_palette.bright_purple
	colors.red = gruvbox_material_palette.bright_red
	colors.yellow = gruvbox_material_palette.bright_yellow

	colors.comment = gruvbox_palette.gray
else
	colors.bg0 = gruvbox_palette.light0_hard
	colors.bg = gruvbox_palette.light0
	colors.bg1 = gruvbox_palette.light1
	colors.fg = gruvbox_palette.dark1

	colors.blue = gruvbox_palette.faded_blue
	colors.cyan = gruvbox_palette.faded_aqua
	colors.darkblue = gruvbox_palette.faded_blue
	colors.green = gruvbox_palette.dark_green
	colors.grey = gruvbox_palette.dark1
	colors.grey2 = gruvbox_palette.dark3
	colors.neutral_blue = gruvbox_palette.faded_blue
	colors.orange = gruvbox_palette.faded_orange
	colors.purple = gruvbox_palette.faded_purple
	colors.red = gruvbox_palette.faded_red
	colors.yellow = gruvbox_palette.faded_yellow

	colors.comment = gruvbox_palette.gray
end

local function_color = colors.cyan

require("gruvbox").setup({
	terminal_colors = false, -- wrong colors for LazyGit
	undercurl = true,
	underline = true,
	bold = true,
	italic = { strings = false, emphasis = true, comments = false, operators = false, folds = true },
	strikethrough = false,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "hard", -- can be "hard", "soft" or empty string
	dim_inactive = false,
	transparent_mode = false,
	palette_overrides = {
		bright_aqua = colors.cyan,
		bright_blue = colors.blue,
		bright_orange = colors.orange,
		bright_purple = colors.purple,
		bright_red = colors.red,
		bright_yellow = colors.yellow,
		bright_green = colors.green,

		faded_aqua = colors.cyan,
		faded_blue = colors.blue,
		faded_orange = colors.orange,
		faded_purple = colors.purple,
		faded_red = colors.red,
		faded_yellow = colors.yellow,
		faded_green = colors.green,

		neutral_aqua = colors.cyan,
		neutral_blue = colors.blue,
		neutral_orange = colors.orange,
		neutral_purple = colors.purple,
		neutral_red = colors.red,
		neutral_yellow = colors.yellow,
		neutral_green = colors.green,
	},
	overrides = {
		-- TODOs
		["@comment.todo.comment"] = { fg = colors.green, bold = true },
		["@comment.error.comment"] = { fg = colors.red, bold = true },
		["@comment.note.comment"] = { fg = colors.purple, bold = true },
		["@comment.warning.comment"] = { fg = colors.orange, bold = true },
		["@punctuation.delimiter.comment"] = { fg = colors.comment },

		-- Languages
		["@constant.builtin"] = { fg = colors.purple },
		["@constructor"] = { fg = colors.cyan },

		["@function"] = { fg = function_color, bold = true },
		["@function.builtin"] = { fg = function_color, bold = true },
		["@function.call"] = { fg = function_color, bold = true },
		["@function.method"] = { fg = function_color, bold = true },

		["@keyword.import"] = { fg = colors.red },
		["@lsp.type.method"] = { fg = function_color },
		["@variable.builtin"] = { fg = colors.purple },

		-- Markdown
		["@markup.heading.1.markdown"] = { fg = colors.red, bold = true },
		["@markup.heading.2.markdown"] = { fg = colors.red, bold = true },
		["@markup.heading.3.markdown"] = { fg = colors.cyan, bold = true },
		["@markup.heading.4.markdown"] = { fg = colors.blue, bold = true },
		["@markup.heading.5.markdown"] = { fg = colors.purple, bold = true },
		["@markup.link.label.markdown_inline"] = { fg = colors.cyan, bold = true },
		["@markup.link.markdown_inline"] = { fg = colors.purple },
		["@markup.link.url.markdown_inline"] = { fg = colors.blue },
		["@markup.list.markdown"] = { fg = colors.orange },
		["@markup.strong.markdown_inline"] = { fg = colors.cyan, bold = true },
		["@markup.italic.markdown_inline"] = { fg = colors.yellow, italic = true },

		-- .gitignore
		["@string.special.path.gitignore"] = { fg = colors.blue },

		-- Folds
		Folded = { fg = colors.comment, bg = "none", italic = true },

		-- Floating window
		FloatBorder = { fg = colors.comment },
		NormalFloat = { bg = colors.bg0 },

		-- Noice's command line window icon and border
		NoiceCmdlinePopupTitleInput = { fg = colors.blue, bg = colors.bg0 },
		NoiceCmdlinePopupBorder = { fg = colors.blue, bg = colors.bg0 },
		NoiceCmdlinePopupBorderCmdline = { fg = colors.blue, bg = colors.bg0 },

		NoiceCmdlineIcon = { fg = colors.blue, bg = colors.bg0 },
		NoiceCmdlineIconSearch = { fg = colors.yellow, bg = colors.bg0 },
		NoiceCmdlineIconLua = { fg = colors.red, bg = colors.bg0 },
		NoiceCmdlineIconHelp = { fg = colors.blue, bg = colors.bg0 },
		NoiceCmdlineIconFilter = { fg = colors.purple, bg = colors.bg0 },

		NoiceCmdlinePopupBorderSearch = { fg = colors.yellow, bg = colors.bg0 },
		NoiceCmdlinePopupBorderLua = { fg = colors.red, bg = colors.bg0 },
		NoiceCmdlinePopupBorderHelp = { fg = colors.blue, bg = colors.bg0 },
		NoiceCmdlinePopupBorderFilter = { fg = colors.purple, bg = colors.bg0 },

		-- Hop
		HopNextKey = { fg = colors.green, bg = colors.bg },
		HopNextKey1 = { fg = colors.green, bg = colors.bg },
		HopNextKey2 = { fg = colors.green, bg = colors.bg },

		-- Nvim-tree
		NvimTreeFolderArrowOpen = { fg = colors.blue },
		NvimTreeFolderName = { fg = colors.blue, bold = true },
		NvimTreeGitDirty = { fg = colors.red },
		NvimTreeGitNewIcon = { fg = colors.orange },
		NvimTreeIndentMarker = { fg = colors.blue },
		NvimTreeOpenedFile = { fg = colors.purple },
		NvimTreeOpenedFolderName = { fg = colors.blue, bold = true },
		NvimTreeOpenedHL = { fg = colors.purple },
		NvimTreeRootFolder = { fg = colors.purple },
		NvimTreeSpecialFile = { fg = colors.green, bold = false, underline = false },
		NvimTreeStatusLine = { fg = colors.bg }, -- Fix annoying offset

		-- Startify
		StartifyBracket = { fg = colors.bg0 },
		StartifyHeader = { fg = colors.orange },
		StartifyNumber = { fg = colors.yellow },
		StartifyPath = { fg = colors.blue },
		StartifySection = { fg = colors.red },
		StartifySelect = { fg = colors.yellow },
		StartifySlash = { fg = colors.blue },

		-- Gitsigns
		GitSignsAdd = { fg = colors.green, bg = colors.bg1 },
		GitSignsDelete = { fg = colors.red, bg = colors.bg1 },
		GitSignsChange = { fg = colors.purple, bg = colors.bg1 },
		GitSignsAddPreview = { fg = colors.green, bg = colors.bg },
		GitSignsDeletePreview = { fg = colors.red, bg = colors.bg },
		GitSignsCurrentLineBlame = { fg = colors.comment, bg = "none" },

		-- Fix annoying space with wrong bg color
		StatusLine = { fg = colors.bg, bg = colors.bg },
		StatusLineNC = { fg = colors.bg, bg = colors.bg },

		-- Diagnostic messages
		DiagnosticSignError = { fg = colors.red, bg = "none" },
		DiagnosticSignWarn = { fg = colors.orange, bg = "none" },
		DiagnosticSignHint = { link = "LineNr" },
		DiagnosticSignInfo = { link = "LineNr" },
		DiagnosticWarn = { fg = colors.orange, bg = "none" },

		DiagnosticVirtualTextError = { fg = colors.red, bg = colors.bg1 },
		DiagnosticVirtualTextWarn = { fg = colors.orange, bg = colors.bg1 },
		DiagnosticVirtualTextInfo = { fg = colors.blue, bg = colors.bg1 },
		DiagnosticVirtualTextHint = { fg = colors.cyan, bg = colors.bg1 },

		-- Rainbow delimiters
		["@punctuation.bracket.python"] = { fg = colors.red },
		RainbowDelimiterBlue = { fg = colors.blue },
		RainbowDelimiterCyan = { fg = colors.cyan },
		RainbowDelimiterGreen = { fg = colors.green },
		RainbowDelimiterOrange = { fg = colors.orange },
		RainbowDelimiterRed = { fg = colors.red },
		RainbowDelimiterYellow = { fg = colors.yellow },

		-- Consistent line number even when diagnostic signs are active
		CursorLineNr = { fg = colors.fg, bg = "none", bold = true },

		-- Navic
		NavicText = { fg = colors.fg, bg = "none" },
		NavicSeparator = { fg = colors.comment, bg = "none", bold = true },
		NavicIconsMethod = { fg = colors.cyan, bg = "none" },
		NavicIconsFunction = { fg = colors.cyan, bg = "none" },

		-- Nvim-cmp autocompletion menu
		CmpPmenu = { fg = "none", bg = colors.bg0 },
		CmpPmenuSel = { fg = "none", bg = colors.bg1, bold = true },

		-- Saga
		SagaFinderFname = { fg = colors.blue, bold = true },
		SagaInCurrent = { fg = colors.green },
		SagaTitle = { fg = colors.red, bold = true },
		SagaSelect = { fg = colors.green, bold = true },
		SagaToggle = { fg = colors.blue },

		-- Winbar
		WinBar = { fg = colors.yellow, bg = colors.bg0, bold = true },
		WinBarNC = { fg = colors.cyan, bg = colors.bg0, bold = true },
		WinBarFilename = { fg = colors.yellow, bg = colors.bg1, bold = true },

		-- Mason
		MasonNormal = { bg = colors.bg },

		-- Snacks
		Directory = { fg = colors.blue },
		SnacksGitDiagnosticsModified = { fg = colors.red },
		SnacksIndentScope = { fg = colors.comment },
		SnacksPickerBorder = { fg = colors.comment },
		SnacksPickerDir = { fg = colors.blue },
		SnacksPickerDirectory = { fg = colors.blue, bold = true },
		SnacksPickerGitStatus = { fg = colors.red },
		SnacksPickerGitStatusIgnored = { fg = colors.comment },
		SnacksPickerGitStatusModified = { fg = colors.purple },
		SnacksPickerGitStatusUntracked = { fg = colors.comment },
		SnacksPickerKeymapRhs = { fg = colors.fg },
		SnacksPickerPathHidden = { fg = colors.comment },
		SnacksPickerTitle = { fg = colors.green, bold = true },
		LspReferenceRead = { fg = "none", bg = colors.bg1, bold = true },
		LspReferenceText = { fg = "none", bg = colors.bg1, bold = true },
		LspReferenceWrite = { fg = colors.orange, bg = colors.bg1, bold = true },
	},
})

vim.cmd("colorscheme gruvbox")
