-- LSP signature
-- require("lsp_signature").setup({
-- 	debug = false, -- set to true to enable debug logging
-- 	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
-- 	-- default is  ~/.cache/nvim/lsp_signature.log
-- 	verbose = false, -- show debug line number
--
-- 	bind = true, -- This is mandatory, otherwise border config won't get registered.
-- 	-- If you want to hook lspsaga or other signature handler, pls set to false
-- 	doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
-- 	-- set to 0 if you DO NOT want any API comments be shown
-- 	-- This setting only take effect in insert mode, it does not affect signature help in normal
-- 	-- mode, 10 by default
--
-- 	max_height = 12, -- max height of signature floating_window
-- 	max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
-- 	-- the value need >= 40
-- 	wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
-- 	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
--
-- 	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
-- 	-- will set to true when fully tested, set to false will use whichever side has more space
-- 	-- this setting will be helpful if you do not want the PUM and floating win overlap
--
-- 	floating_window_off_x = 1, -- adjust float windows x position.
-- 	-- can be either a number or function
-- 	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
-- 	-- can be either number or function, see examples
--
-- 	close_timeout = 4000, -- close floating window after ms when laster parameter is entered
-- 	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
-- 	hint_enable = false, -- virtual hint enable
-- 	hint_prefix = " ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
-- 	-- or, provide a table with 3 icons
-- 	-- hint_prefix = {
-- 	--     above = "↙ ",  -- when the hint is on the line above the current line
-- 	--     current = "← ",  -- when the hint is on the same line
-- 	--     below = "↖ "  -- when the hint is on the line below the current line
-- 	-- }
-- 	hint_scheme = "String",
-- 	hint_inline = function()
-- 		return false
-- 	end, -- should the hint be inline(nvim 0.10 only)?  default false
-- 	-- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
-- 	-- return 'right_align' to display hint right aligned in the current line
-- 	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
-- 	handler_opts = {
-- 		border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
-- 	},
--
-- 	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
--
-- 	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
-- 	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
-- 	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
--
-- 	padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
--
-- 	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
-- 	shadow_blend = 36, -- if you using shadow as border use this set the opacity
-- 	shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
-- 	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
-- 	toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
-- 	toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
-- 	-- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
-- 	-- may not popup when typing depends on floating_window setting
--
-- 	select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
-- 	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating window
-- 	-- e.g. move_cursor_key = '<M-p>',
-- 	-- once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down
-- 	keymaps = {}, -- relate to move_cursor_key; the keymaps inside floating window
-- 	-- e.g. keymaps = { 'j', '<C-o>j' } this map j to <C-o>j in floating window
-- 	-- <M-d> and <M-u> are default keymaps to move cursor up and down
-- })

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"pyright",
	"ruff",
	-- "ruff_lsp",
	"dockerls",
	"ccls",
	"terraformls",
	"bashls",
	"rls",
}
for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({ flags = { debounce_text_changes = 150 } })
end

-- Golang language server
require("lspconfig").gopls.setup({})

-- YAML
require("lspconfig").yamlls.setup({
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yml", "yaml.docker-compose" },
	flags = { debounce_text_changes = 150 },
	settings = {
		yaml = {
			customTags = {
				-- Cloud formation tags
				"!And",
				"!And sequence",
				"!If",
				"!If sequence",
				"!Not",
				"!Not sequence",
				"!Equals",
				"!Equals sequence",
				"!Or",
				"!Or sequence",
				"!FindInMap",
				"!FindInMap sequence",
				"!Base64",
				"!Join",
				"!Join sequence",
				"!Cidr",
				"!Ref",
				"!Sub",
				"!Sub sequence",
				"!GetAtt",
				"!GetAZs",
				"!ImportValue",
				"!ImportValue sequence",
				"!Select",
				"!Select sequence",
				"!Split",
				"!Split sequence",
			},
			schemas = {
				kubernetes = "/*.yaml",
				["/home/baira/.config/nvim/.gitlab-ci.json"] = "/*gitlab-ci*",
			},
		},
	},
})

-- Lua
require("lspconfig").lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- Rust
require("lspconfig").rls.setup({
	settings = { rust = { unstable_features = true, build_on_save = false, all_features = true } },
})

-- Lsp saga formatting

-- Hover doc popup
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 80 })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
	border = "rounded",
	max_width = 80,
	close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
})

-- Remove virtual text in line for diagnostics
local active_diagnostics_config = {
	virtual_text = true,
	underline = true,
	sign = true,
	float = { source = true, border = "rounded" },
}
local inactive_diagnostics_config = { virtual_text = false, underline = false, sign = false, float = false }

vim.g.diagnostic_active = true
vim.diagnostic.config(active_diagnostics_config)

function _G.nolint()
	if vim.g.diagnostic_active then
		vim.diagnostic.config(inactive_diagnostics_config)
		vim.g.diagnostic_active = false
	else
		vim.diagnostic.config(active_diagnostics_config)
		vim.g.diagnostic_active = true
	end
end

-- Open diagnostic window when in diagnostic line without "Diagnostics:" header
vim.o.updatetime = 50

vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	command = "lua if vim.g.diagnostic_active then vim.diagnostic.open_float({header = '', focus=false}) end",
})
-- Not in CursorHoldI so that it doesn't hide the lsp signature help
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({header = "", focus=false})]])

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
	border = "rounded",
	max_width = 80,
	source = true,
})

-- Edit lsp diagnostic line icon
local signs = { Error = "", Warn = "", Hint = "", Info = "" } -- "● ", Info = " "
for type, icon in pairs(signs) do
	if vim.g.diagnostic_active then
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end
