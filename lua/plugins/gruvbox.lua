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

	bright_aqua = "#8ec07c",
	bright_blue = "#83a598",
	bright_green = "#b8bb26",
	bright_orange = "#fe8019",
	bright_purple = "#d3869b",
	bright_red = "#fb4934",
	bright_yellow = "#fabd2f",

	neutral_aqua = "#689d6a",
	neutral_blue = "#458588",
	neutral_green = "#98971a",
	neutral_orange = "#d65d0e",
	neutral_purple = "#b16286",
	neutral_red = "#cc241d",
	neutral_yellow = "#d79921",

	faded_aqua = "#427b58",
	faded_blue = "#076678",
	faded_green = "#79740e",
	faded_orange = "#af3a03",
	faded_purple = "#8f3f71",
	faded_red = "#9d0006",
	faded_yellow = "#b57614",

	dark_aqua = "#49503b",
	dark_aqua_hard = "#3e4934",
	dark_aqua_soft = "#525742",
	dark_green = "#62693e",
	dark_green_hard = "#5a633a",
	dark_green_soft = "#686d43",
	dark_red = "#722529",
	dark_red_hard = "#792329",
	dark_red_soft = "#7b2c2f",

	light_aqua = "#e8e5b5",
	light_aqua_hard = "#e6e9c1",
	light_aqua_soft = "#e1dbac",
	light_green = "#d5d39b",
	light_green_hard = "#d3d6a5",
	light_green_soft = "#cecb94",
	light_red = "#fc9487",
	light_red_hard = "#fc9690",
	light_red_soft = "#f78b7f",

	gray = "#928374",
}

local gruvbox_material_palette = {
	bright_blue = "#7daea3",
	bright_orange = "#e78a4e",
	bright_red = "#ea6962",
	bright_yellow = "#d8a657", -- bright_green = "#a9b665", bright_aqua = "#89b482",
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

local database = {
	-- aliceblue = "rgb(240, 248, 255)",
	-- antiquewhite = "rgb(250, 235, 215)",
	-- aqua = "rgb(0, 255, 255)",
	-- azure = "rgb(240, 255, 255)",
	-- beige = "rgb(245, 245, 220)",
	-- bisque = "rgb(255, 228, 196)",
	-- black = "rgb(0, 0, 0)",
	-- blanchedalmond = "rgb(255, 235, 205)",
	-- blue = "rgb(0, 0, 255)",
	-- blueviolet = "rgb(138, 43, 226)",
	-- brown = "rgb(165, 42, 42)",
	-- crimson = "rgb(220, 20, 60)",
	-- cyan = "rgb(0, 255, 255)",
	-- darkblue = "rgb(0, 0, 139)",
	-- darkcyan = "rgb(0, 139, 139)",
	-- darkgray = "rgb(169, 169, 169)",
	-- darkgreen = "rgb(0, 100, 0)",
	-- darkgrey = "rgb(169, 169, 169)",
	-- darkmagenta = "rgb(139, 0, 139)",
	-- darkolivegreen = "rgb(85, 107, 47)",
	-- darkorchid = "rgb(153, 50, 204)",
	-- darkred = "rgb(139, 0, 0)",
	-- darkslateblue = "rgb(72, 61, 139)",
	-- darkslategray = "rgb(47, 79, 79)",
	-- darkslategrey = "rgb(47, 79, 79)",
	-- darkviolet = "rgb(148, 0, 211)",
	-- deeppink = "rgb(255, 20, 147)",
	-- dimgray = "rgb(105, 105, 105)",
	-- dimgrey = "rgb(105, 105, 105)",
	-- dodgerblue = "rgb(30, 144, 255)",
	-- firebrick = "rgb(178, 34, 34)",
	-- floralwhite = "rgb(255, 250, 240)",
	-- forestgreen = "rgb(34, 139, 34)",
	-- gainsboro = "rgb(220, 220, 220)",
	-- ghostwhite = "rgb(248, 248, 255)",
	-- gray = "rgb(128, 128, 128)",
	-- green = "rgb(0, 128, 0)",
	-- grey = "rgb(128, 128, 128)",
	-- honeydew = "rgb(240, 255, 240)",
	-- indigo = "rgb(75, 0, 130)",
	-- ivory = "rgb(255, 255, 240)",
	-- lavender = "rgb(230, 230, 250)",
	-- lavenderblush = "rgb(255, 240, 245)",
	-- lawngreen = "rgb(124, 252, 0)",
	-- lemonchiffon = "rgb(255, 250, 205)",
	-- lightcyan = "rgb(224, 255, 255)",
	-- lightgoldenrodyellow = "rgb(250, 250, 210)",
	-- lightgray = "rgb(211, 211, 211)",
	-- lightgrey = "rgb(211, 211, 211)",
	-- lightseagreen = "rgb(32, 178, 170)",
	-- lightslategray = "rgb(119, 136, 153)",
	-- lightslategrey = "rgb(119, 136, 153)",
	-- lightyellow = "rgb(255, 255, 224)",
	-- lime = "rgb(0, 255, 0)",
	-- limegreen = "rgb(50, 205, 50)",
	-- linen = "rgb(250, 240, 230)",
	-- magenta = "rgb(255, 0, 255)",
	-- maroon = "rgb(128, 0, 0)",
	-- mediumblue = "rgb(0, 0, 205)",
	-- mediumorchid = "rgb(186, 85, 211)",
	-- mediumpurple = "rgb(147, 112, 219)",
	-- mediumseagreen = "rgb(60, 179, 113)",
	-- mediumslateblue = "rgb(123, 104, 238)",
	-- midnightblue = "rgb(25, 25, 112)",
	-- mintcream = "rgb(245, 255, 250)",
	-- mistyrose = "rgb(255, 228, 225)",
	-- moccasin = "rgb(255, 228, 181)",
	-- navy = "rgb(0, 0, 128)",
	-- oldlace = "rgb(253, 245, 230)",
	-- olive = "rgb(128, 128, 0)",
	-- olivedrab = "rgb(107, 142, 35)",
	-- papayawhip = "rgb(255, 239, 213)",
	-- peru = "rgb(205, 133, 63)",
	-- purple = "rgb(128, 0, 128)",
	-- rebeccapurple = "rgb(102, 51, 153)",
	-- red = "rgb(255, 0, 0)",
	-- royalblue = "rgb(65, 105, 225)",
	-- saddlebrown = "rgb(139, 69, 19)",
	-- seagreen = "rgb(46, 139, 87)",
	-- seashell = "rgb(255, 245, 238)",
	-- sienna = "rgb(160, 82, 45)",
	-- silver = "rgb(192, 192, 192)",
	-- slateblue = "rgb(106, 90, 205)",
	-- slategrey = "rgb(112, 128, 144)",
	-- snow = "rgb(255, 250, 250)",
	-- springgreen = "rgb(0, 255, 127)",
	-- steelblue = "rgb(70, 130, 180)",
	-- teal = "rgb(0, 128, 128)",
	-- wheat = "rgb(245, 222, 179)",
	-- white = "rgb(255, 255, 255)",
	-- whitesmoke = "rgb(245, 245, 245)",
	-- yellow = "rgb(255, 255, 0)",
	aquamarine = "rgb(127, 255, 212)",
	burlywood = "rgb(222, 184, 135)",
	cadetblue = "rgb(95, 158, 160)",
	chartreuse = "rgb(127, 255, 0)",
	chocolate = "rgb(210, 105, 30)",
	coral = "rgb(255, 127, 80)",
	cornflowerblue = "rgb(100, 149, 237)",
	cornsilk = "rgb(255, 248, 220)",
	darkgoldenrod = "rgb(184, 134, 11)",
	darkkhaki = "rgb(189, 183, 107)",
	darkorange = "rgb(255, 140, 0)",
	darksalmon = "rgb(233, 150, 122)",
	darkseagreen = "rgb(143, 188, 143)",
	darkturquoise = "rgb(0, 206, 209)",
	deepskyblue = "rgb(0, 191, 255)",
	fuchsia = "rgb(255, 0, 255)",
	gold = "rgb(255, 215, 0)",
	goldenrod = "rgb(218, 165, 32)",
	greenyellow = "rgb(173, 255, 47)",
	hotpink = "rgb(255, 105, 180)",
	indianred = "rgb(205, 92, 92)",
	khaki = "rgb(240, 230, 140)",
	lightblue = "rgb(173, 216, 230)",
	lightcoral = "rgb(240, 128, 128)",
	lightgreen = "rgb(144, 238, 144)",
	lightpink = "rgb(255, 182, 193)",
	lightsalmon = "rgb(255, 160, 122)",
	lightskyblue = "rgb(135, 206, 250)",
	lightsteelblue = "rgb(176, 196, 222)",
	mediumaquamarine = "rgb(102, 205, 170)",
	mediumspringgreen = "rgb(0, 250, 154)",
	mediumturquoise = "rgb(72, 209, 204)",
	mediumvioletred = "rgb(199, 21, 133)",
	navajowhite = "rgb(255, 222, 173)",
	orange = "rgb(255, 165, 0)",
	orangered = "rgb(255, 69, 0)",
	orchid = "rgb(218, 112, 214)",
	palegoldenrod = "rgb(238, 232, 170)",
	palegreen = "rgb(152, 251, 152)",
	paleturquoise = "rgb(175, 238, 238)",
	palevioletred = "rgb(219, 112, 147)",
	peachpuff = "rgb(255, 218, 185)",
	pink = "rgb(255, 192, 203)",
	plum = "rgb(221, 160, 221)",
	powderblue = "rgb(176, 224, 230)",
	rosybrown = "rgb(188, 143, 143)",
	salmon = "rgb(250, 128, 114)",
	sandybrown = "rgb(244, 164, 96)",
	skyblue = "rgb(135, 206, 235)",
	slategray = "rgb(112, 128, 144)",
	tan = "rgb(210, 180, 140)",
	thistle = "rgb(216, 191, 216)",
	tomato = "rgb(255, 99, 71)",
	turquoise = "rgb(64, 224, 208)",
	violet = "rgb(238, 130, 238)",
	yellowgreen = "rgb(154, 205, 50)",
}

-- -- Custom
-- colors.green = "lightsalmon"
-- colors.cyan = "skyblue"
-- colors.blue = "darkseagreen"
-- -- colors.darkblue = "powderblue"
-- -- colors.neutral_blue = "powderblue"
-- colors.purple = "orange"
-- colors.orange = "yellowgreen"
-- colors.red = "gold"
-- colors.yellow = "pink"
-- -- colors.grey = "slategray"
-- -- colors.grey2 = "slategray"
-- -- colors.comment = "lightgrey"

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
		bright_green = colors.green,
		bright_orange = colors.orange,
		bright_purple = colors.purple,
		bright_red = colors.red,
		bright_yellow = colors.yellow,

		faded_aqua = colors.cyan,
		faded_blue = colors.blue,
		faded_green = colors.green,
		faded_orange = colors.orange,
		faded_purple = colors.purple,
		faded_red = colors.red,
		faded_yellow = colors.yellow,

		neutral_aqua = colors.cyan,
		neutral_blue = colors.blue,
		neutral_green = colors.green,
		neutral_orange = colors.orange,
		neutral_purple = colors.purple,
		neutral_red = colors.red,
		neutral_yellow = colors.yellow,
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

		DiagnosticVirtualLinesError = { fg = colors.red, bg = colors.bg1 },
		DiagnosticVirtualLinesWarn = { fg = colors.orange, bg = colors.bg1 },
		DiagnosticVirtualLinesInfo = { fg = colors.blue, bg = colors.bg1 },
		DiagnosticVirtualLinesHint = { fg = colors.cyan, bg = colors.bg1 },

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

		-- Tmux
		tmuxOptions = { fg = colors.yellow, bold = true },

		-- Lazy
		LazyNormal = { bg = colors.bg },
	},
})

vim.cmd("colorscheme gruvbox")
