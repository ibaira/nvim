-- Lazy configuration

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = false },
	{
		"mhinz/vim-startify", -- Single Vimscript plugin
		config = function()
			vim.g.startify_lists = {
				{ type = "files" },
				{ type = "bookmarks", header = { "    Bookmarks" } },
			}
			vim.g.startify_bookmarks = {
				{ c = "~/.config/kitty/kitty.conf" },
				{ d = "~/.config/harper-ls/dictionary.txt" },
				{ g = "~/.config/nvim/lua/plugins/gruvbox.lua" },
				{ G = "~/.config/ghostty/config" },
				{ i = "~/.config/nvim/init.lua" },
				{ K = "~/.config/nvim/lua/core/keymaps.lua" },
				{ l = "~/.config/nvim/lua/core/lazy.lua" },
				{ L = "~/.config/lazygit/config.yml" },
				{ p = "~/.config/presenterm/config.yaml" },
				{ r = "~/.config/ruff/pyproject.toml" },
				{ t = "~/.tmux.conf" },
				{ T = "~/notes/todo.md" },
				{ z = "~/.zshrc" },
			}
			-- Get rid of empty buffer and quit
			vim.g.startify_enable_special = 0
			vim.g.startify_change_to_dir = 0
			vim.g.startify_change_to_vcs_root = 0
			vim.g.startify_fortune_use_unicode = true
			vim.g.startify_custom_header = "startify#pad(startify#fortune#cowsay())"
		end,
	},
	{ "nvim-lualine/lualine.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({ ---@diagnostic disable-line: missing-fields
				ensure_installed = { "python", "lua", "rust", "vim", "comment", "c", "go", "sql" }, -- "all", "maintained"
				ignore_install = {}, -- List of parsers to ignore installing
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true, -- false will disable the whole extension
					disable = { "tmux" }, -- list of language that will be disabled
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true }, -- fix issue with Python indent in new lines
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			---------------------------------------------------------------------
			-- Custom linter configurations
			---------------------------------------------------------------------

			lint = require("lint")
			parser = require("lint.parser")

			-- Luacheck
			local pattern = "[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)"
			local groups = { "lnum", "col", "end_col", "severity", "code", "message" }
			local severities = { W = vim.diagnostic.severity.WARN, E = vim.diagnostic.severity.ERROR }

			lint.linters.luacheck = { ---@diagnostic disable-line: missing-fields
				cmd = "luacheck",
				stdin = true,
				args = { "--formatter", "plain", "--codes", "--ranges", "-", "--global", "vim" }, -- With "vim" as global variable
				ignore_exitcode = true,
				parser = parser.from_pattern(
					pattern,
					groups,
					severities,
					{ ["source"] = "luacheck" },
					{ end_col_offset = 0 }
				),
			}

			-- Tflint
			local pattern_tf = "([^%c]-):(%d+),(%d+).-:(.+)"
			local groups_tf = { "file", "lnum", "col", "message" }

			lint.linters.tflint = { ---@diagnostic disable-line: missing-fields
				cmd = "tflint",
				stdin = false,
				args = { "--format", "compact", "--no-color", "--force", "variables.tf" }, -- could it accept stdin instead?
				parser = parser.from_pattern(pattern_tf, groups_tf, nil, {
					["source"] = "tflint",
					["severity"] = vim.lsp.protocol.DiagnosticSeverity.Error, --luacheck:ignore 113
				}),
			}

			-- Set linters for each language
			require("lint").linters_by_ft = {
				terraform = { "tflint" },
				markdown = { "markdownlint" },
				dockerfile = { "hadolint" },
			}

			---------------------------------------------------------------------
			--- Auto-commands and functions for keybindings
			---------------------------------------------------------------------

			vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "TextChanged", "BufWritePost" }, {
				pattern = "*",
				command = ":lua require('lint').try_lint()",
			})

			-- Ignore lint inline
			_G.isTableEmpty = function(table)
				local next = next -- to speed up searching next definition
				if next(table) == nil then
					return true
				end
				return false
			end

			_G.IgnoreLintInLine = function()
				local current_cursor_line, _ = unpack(vim.api.nvim_win_get_cursor(0))
				local current_buffer_diag_table = vim.diagnostic.get(0, { lnum = current_cursor_line - 1 })

				if _G.isTableEmpty(current_buffer_diag_table) then
					return
				end

				-- Ignore line diagnostics by filetype
				local buffer_filetype = vim.api.nvim_get_option_value("filetype", {})

				if buffer_filetype == "python" then
					local is_pyright_ignore = false
					local ignored_codes = {}
					local has_noqa = string.find(vim.api.nvim_get_current_line(), "# noqa:")

					for _, diagnostic in pairs(current_buffer_diag_table) do
						local source = diagnostic.source

						if source == "Pyright" and not is_pyright_ignore then
							vim.cmd("normal A  # type: ignore")
							is_pyright_ignore = true
						elseif source ~= nil and source:lower() == "ruff" and not ignored_codes[diagnostic.code] then
							if not has_noqa and _G.isTableEmpty(ignored_codes) then
								vim.cmd("normal A  # noqa: " .. diagnostic.code)
							else
								vim.cmd("normal A," .. diagnostic.code)
							end
							ignored_codes[diagnostic.code] = true
						end
					end
				elseif buffer_filetype == "lua" then
					local diagnostic = current_buffer_diag_table[1]
					vim.cmd("normal A ---@diagnostic disable-line: " .. diagnostic.code)
					return
				elseif buffer_filetype == "yaml" then
					local diagnostic = current_buffer_diag_table[1]
					vim.cmd("normal A  # yamllint disable-line rule:" .. diagnostic.code)
					return
				end
			end
		end,
	},
	{
		"hadronized/hop.nvim",
		branch = "v2",
		event = "VeryLazy",
		config = function()
			local hop = require("hop")
			local direction = require("hop.hint").HintDirection

			vim.keymap.set("n", "s", ":HopWord<CR>", { remap = true })

			vim.keymap.set("n", "f", function()
				hop.hint_char1({ current_line_only = true })
			end, { remap = true })

			vim.keymap.set("n", "F", function()
				hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })

			vim.keymap.set("n", "t", function()
				hop.hint_char1({ direction = direction.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })

			vim.keymap.set("n", "T", function()
				hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end, { remap = true })

			hop.setup()
		end,
	},
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", event = "VeryLazy" },
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap-python" },
		config = function()
			-- 1. DAP configuration

			-- 1.1. DAP-Python adapter definition
			local env = os.getenv("CONDA_DEFAULT_ENV")
			local env_python = ""

			if not env or env == "base" then
				local env_path = os.getenv("VIRTUAL_ENV")
				if env_path then
					env_python = env_path .. "/bin/python"
				end
			else
				env_python = os.getenv("HOME") .. "/miniconda3/envs/" .. env .. "/bin/python"
			end

			if env_python then
				require("dap-python").setup(env_python)
			end

			-- 1.2. DAP-Python configuration
			local dap = require("dap")
			dap.configurations.python = {
				{
					-- The first three options are required by nvim-dap
					type = "python", -- establishes the link to the adapter definition: `dap.adapters.python`
					request = "launch",
					name = "Launch file",
					-- Debugpy options: https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
					program = "${file}",
					pythonPath = function()
						local cwd = vim.fn.getcwd()

						if env then
							return env_python
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end,
					justMyCode = false,
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
				},
				{
					type = "python",
					request = "launch",
					name = "Launch file with arguments",
					program = "${file}",
					pythonPath = function()
						local cwd = vim.fn.getcwd()

						if env then
							return env_python
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end,
					justMyCode = false,
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " +")
					end,
				},
			}

			-- 2. DAP-UI -> Use DAP events to open and close the windows automatically
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = true, -- enables the Noice cmdline UI
					view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
					opts = {}, -- global options for the cmdline. See section on views
					format = {
						-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
						-- view: (default is cmdline view)
						-- opts: any options passed to the view
						-- icon_hl_group: optional hl_group for the icon
						-- title: set to anything or empty string to hide
						cmdline = { pattern = "^:", icon = "", lang = "vim" },
						search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
						search_up = { kind = "search", pattern = "^%?", icon = "", lang = "regex" },
						filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
						lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
						help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
						input = { view = "cmdline_input", icon = "" }, -- Used by input()
					},
				},
				messages = {
					-- NOTE: If you enable messages, then the cmdline is enabled automatically.
					-- This is a current Neovim limitation.
					enabled = true, -- enables the Noice messages UI
					view = "notify", -- default view for messages
					view_error = "notify", -- view for errors
					view_warn = "notify", -- view for warnings
					view_history = "messages", -- view for :messages
					view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
				},
				popupmenu = {
					enabled = true, -- enables the Noice popupmenu UI
					backend = "nui", -- nui or cmp | backend to use to show regular cmdline completions
					-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
					kind_icons = {}, -- set to `false` to disable icons
				},
				-- default options for require('noice').redirect
				-- see the section on Command Redirection
				---@type NoiceRouteConfig
				redirect = { view = "popup", filter = { event = "msg_show" } },
				-- You can add any custom commands below that will be available with `:Noice command`
				---@type table<string, NoiceCommand>
				commands = {
					history = {
						-- options for the message history that you get with `:Noice`
						view = "split",
						opts = { enter = true, format = "details" },
						filter = {
							any = {
								{ event = "notify" },
								{ error = true },
								{ warning = true },
								{ event = "msg_show", kind = { "" } },
								{ event = "lsp", kind = "message" },
							},
						},
					},
					-- :Noice last
					last = {
						view = "popup",
						opts = { enter = true, format = "details" },
						filter = {
							any = {
								{ event = "notify" },
								{ error = true },
								{ warning = true },
								{ event = "msg_show", kind = { "" } },
								{ event = "lsp", kind = "message" },
							},
						},
						filter_opts = { count = 1 },
					},
					-- :Noice errors
					errors = {
						-- options for the message history that you get with `:Noice`
						view = "popup",
						opts = { enter = true, format = "details" },
						filter = { error = true },
						filter_opts = { reverse = true },
					},
					all = {
						-- options for the message history that you get with `:Noice`
						view = "split",
						opts = { enter = true, format = "details" },
						filter = {},
					},
				},
				notify = {
					-- Noice can be used as `vim.notify` so you can route any notification like other messages
					-- Notification messages have their level and other properties set.
					-- event is always "notify" and kind can be any log level as a string
					-- The default routes will forward notifications to nvim-notify
					-- Benefit of using Noice for this is the routing and consistent history view
					enabled = false,
					view = "notify",
				},
				lsp = {
					progress = {
						enabled = true,
						-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
						-- See the section on formatting for more details on how to customize.
						format = "lsp_progress",
						format_done = "lsp_progress_done",
						throttle = 1000 / 30, -- frequency to update lsp progress message
						view = "mini",
					},
					override = {
						-- override the default lsp markdown formatter with Noice
						["vim.lsp.util.convert_input_to_markdown_lines"] = false,
						-- override the lsp markdown formatter with Noice
						["vim.lsp.util.stylize_markdown"] = false,
						["textDocument/hover"] = false,
					},
					hover = {
						enabled = false,
						silent = false, -- set to true to not show a message if hover is not available
						view = nil, -- when nil, use defaults from documentation
						opts = { border = "none", scrollbar = false }, -- merged with defaults from documentation
					},
					signature = {
						enabled = false,
						auto_open = {
							enabled = true,
							trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
							luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
							throttle = 50, -- Debounce lsp signature help request by 50ms
						},
						view = nil, -- when nil, use defaults from documentation
						opts = {}, -- merged with defaults from documentation
					},
					message = {
						-- Messages shown by lsp servers
						enabled = true,
						view = "mini",
						opts = {},
					},
					-- defaults for hover and signature help
					documentation = {
						view = "hover",
						opts = {
							lang = "markdown",
							replace = true,
							render = "plain",
							format = { "{message}" },
							win_options = { concealcursor = "n", conceallevel = 3 },
						},
					},
				},
				markdown = {
					hover = {
						["|(%S-)|"] = vim.cmd.help, -- vim help links
						["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
					},
					highlights = {
						["|%S-|"] = "@text.reference",
						["@%S+"] = "@parameter",
						["^%s*(Parameters:)"] = "@text.title",
						["^%s*(Return:)"] = "@text.title",
						["^%s*(See also:)"] = "@text.title",
						["{%S-}"] = "@parameter",
					},
				},
				health = { checker = true }, -- Disable if you don't want health checks to run
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				routes = {
					{
						-- Skip message from LSP saying no info available even if hover shows up
						filter = { event = "msg_show", find = "No information available" },
						opts = { skip = true },
					},
					{
						view = "split",
						filter = { event = "msg_show", min_height = 5 },
					},
					{
						view = "popup",
						filter = { event = "msg_show", min_width = 120 },
					},
					{
						view = "mini",
						filter = { event = "msg_show", min_height = 1 },
					},
				},
				views = {
					popup = { scrollbar = false },
					split = { scrollbar = false, enter = true },
					mini = { scrollbar = false },
				},
			})
		end,
	}, -- not lazy or lag
	{
		"ruifm/gitlinker.nvim",
		event = "VeryLazy",
		config = function()
			require("gitlinker").setup({
				-- callbacks = { ["gitlab.<custom-domain>.com"] = require("gitlinker.hosts").get_gitlab_type_url }
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				fast_wrap = {
					map = "<M-f>",
					chars = { "{", "[", "(", '"', "'", "`" },
					pattern = [=[[%`%'%"%>%]%)%}%,%:%;]]=],
					end_key = "$",
					before_key = "h",
					after_key = "l",
					cursor_pos_before = true,
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					manual_position = false,
					highlight = "Search",
					highlight_grey = "Comment",
				},
				disable_filetype = { "spectre_panel" },
				disable_in_macro = true, -- disable when recording or executing a macro
				disable_in_visualblock = false, -- disable when insert after visual block mode
				disable_in_replace_mode = true,
				ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
				enable_moveright = true,
				enable_afterquote = true, -- add bracket pairs after quote
				enable_check_bracket_line = true, --- check bracket in same line
				enable_bracket_in_quote = true, --
				enable_abbr = false, -- trigger abbreviation
				break_undo = true, -- switch for basic rule break undo sequence
				check_ts = false,
				map_cr = true,
				map_bs = true, -- map the <BS> key
				map_c_h = false, -- Map the <C-h> key to delete a pair
				map_c_w = false, -- map <c-w> to delete a pair if possible
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		config = function()
			require("nvim-highlight-colors").setup({
				---Render style
				---@usage 'background'|'foreground'|'virtual'
				render = "virtual",

				---Set virtual symbol (requires render to be set to 'virtual')
				virtual_symbol = "██",

				---Set virtual symbol suffix (defaults to '')
				virtual_symbol_prefix = "",

				---Set virtual symbol suffix (defaults to ' ')
				virtual_symbol_suffix = " ",

				---Set virtual symbol position()
				---@usage 'inline'|'eol'|'eow'
				---inline mimics VS Code style
				---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
				---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
				virtual_symbol_position = "inline",

				---Highlight hex colors, e.g. '#FFFFFF'
				enable_hex = true,

				---Highlight short hex colors e.g. '#fff'
				enable_short_hex = true,

				---Highlight rgb colors, e.g. 'rgb(0 0 0)'
				enable_rgb = true,

				---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
				enable_hsl = true,

				---Highlight CSS variables, e.g. 'var(--testing-color)'
				enable_var_usage = true,

				---Highlight named colors, e.g. 'green'
				enable_named_colors = true,

				---Highlight tailwind colors, e.g. 'bg-blue-500'
				enable_tailwind = false,

				---Set custom colors
				---Label must be properly escaped with '%' to adhere to `string.gmatch`
				--- :help string.gmatch
				custom_colors = {
					{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
					{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
				},

				-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
				exclude_filetypes = {},
				exclude_buftypes = {},
			})
		end,
	},
	{
		"SmiteshP/nvim-navic",
		event = "VeryLazy",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("nvim-navic").setup({
				icons = {
					Text = "󰉿 ",
					Method = "󰆧 ",
					Function = "󰊕 ",
					Constructor = " ",
					Field = "󰜢 ",
					Variable = "󰀫 ",
					Class = "󰠱 ",
					Interface = " ",
					Module = " ",
					Property = "󰜢 ",
					Unit = "󰑭 ",
					Value = "󰎠 ",
					Enum = " ",
					Keyword = "󰌋 ",
					Snippet = " ",
					Color = "󰏘 ",
					File = "󰈙 ",
					Reference = "󰈇 ",
					Folder = "󰉋 ",
					EnumMember = " ",
					Constant = "󰏿 ",
					Struct = "󰙅 ",
					Event = " ",
					Operator = "󰆕 ",
					TypeParameter = "",
				},
				lsp = { auto_attach = true, preference = nil },
				highlight = true,
				separator = "   ",
				depth_limit = 3,
				depth_limit_indicator = "..",
				safe_output = true,
				lazy_update_context = true,
				click = true,
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				signs = {
					changedelete = { text = "|" }, -- untracked = { text = "┆" },
				},
				signs_staged = {
					changedelete = { text = "|" }, -- untracked = { text = "┆" },
				},
				signs_staged_enable = true,
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = { follow_files = true },
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'overlay' | 'right_align'
					delay = 100,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "❯ <author> (<author_time:%R>): <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = { -- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		build = "make install_jsregexp", -- install jsregexp (optional!).
		config = function()
			-- Luasnips
			local luasnip = require("luasnip")

			local snippet = luasnip.snippet
			local text_node = luasnip.text_node
			local insert_node = luasnip.insert_node
			local function_node = luasnip.function_node
			local types = require("luasnip.util.types")

			-- Every unspecified option will be set to the default.
			luasnip.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				ext_opts = {
					[types.choiceNode] = {
						active = { virt_text = { { "choiceNode", "Comment" } } },
					},
				},
				-- treesitter-hl has 100, use something higher (default is 200).
				ext_base_prio = 300,
				ext_prio_increase = 1, -- minimal increase in priority.
				enable_autosnippets = true,
			})

			-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
			-- placeholder 2,...
			local function copy(args)
				return args[1]
			end

			luasnip.add_snippets("python", {
				-- Main block
				snippet("main", {
					text_node({ 'if __name__ == "__main__":', "    " }),
				}),
				-- Function with return type
				snippet("def", {
					text_node({ "def " }),
					insert_node(1, "function_name"),
					text_node("("),
					insert_node(2, "arg1"),
					text_node({ ") -> " }),
					insert_node(3),
					text_node({ ":", "    " }),
					insert_node(4),
				}),
				-- Add constructor
				snippet("defi", {
					text_node({ "def __init__(self" }),
					insert_node(1),
					text_node({ ") -> None:", "" }),
					text_node({ '\t"""Initialize class instance."""', "" }),
					text_node({ "\t" }),
					insert_node(2),
					text_node({ "", "" }),
				}),
				-- Dataclass
				snippet("dcl", {
					text_node({ "@dataclass", "" }),
					text_node({ "class " }),
					insert_node(1, "ClassName"),
					text_node({ ":", "    " }),
					text_node({ '"""' }),
					insert_node(2, "Description"),
					text_node({ '."""', "" }),
					text_node({ "", "    " }),
					insert_node(3),
					text_node({ "", "" }),
				}),
				-- Class without inheritance and constructor
				snippet("cl", {
					text_node({ "class " }),
					insert_node(1, "ClassName"),
					text_node({ ":", "    " }),
					text_node({ '"""' }),
					insert_node(2, "Description"),
					text_node({ '."""', "" }),
					text_node({ "", "" }),
					text_node({ "    def __init__(self) -> None:", "        " }),
					text_node({ '"""Initialize class instance."""', "" }),
					text_node({ "\t\tsuper().__init__()", "" }),
					text_node({ "\t\t", "" }),
					insert_node(3),
					text_node({ "", "" }),
				}),
				-- Class with inheritance and constructor
				snippet("cli", {
					text_node({ "class " }),
					insert_node(1, "ClassName"),
					text_node("("),
					insert_node(2, "arg1"),
					text_node({ "):" }),
					text_node({ "", "" }),
					text_node({ '\t"""' }),
					insert_node(3),
					text_node({ '."""', "" }),
					text_node({ "", "" }),
					text_node({ "\tdef __init__(self) -> None:", "" }),
					text_node({ '\t\t"""Initialize class instance."""', "" }),
					text_node({ "\t\tsuper().__init__()", "" }),
					text_node({ "\t\t" }),
					insert_node(4),
					text_node({ "\t\t", "" }),
				}),
				-- Fast imports of common libraries
				snippet("num", {
					text_node({ "import numpy as np", "" }),
				}),
				snippet("pan", {
					text_node({ "import pandas as pd", "" }),
				}),
				-- Path utility
				snippet("osp", {
					text_node({ "os.path.join(" }),
					insert_node(1, "base_path"),
					text_node({ ", " }),
					insert_node(2, "sub_path"),
					text_node({ ")", "" }),
				}),
				-- Disabling Pylint
				snippet("pylint", {
					text_node({ " # pylint: disable=" }),
					insert_node(1, "error_code"),
				}),
				-- Disabling Coverage
				snippet("pylint", {
					text_node({ " # pragma: no cover" }),
				}),
				-- Disabling Bandit
				snippet("pylint", {
					text_node({ " # nosec" }),
				}),
				-- Disabling Flake8
				snippet("pylint", {
					text_node({ " # noqa:" }),
					insert_node(1, "error_code"),
				}),
				-- Get logger
				snippet("getl", {
					text_node({ "import logging", "" }),
					text_node({ "LOG = logging.getLogger(" }),
					insert_node(1, "__name__"),
					text_node({ ")", "" }),
				}),
				-- Log error
				snippet("le", {
					text_node({ "LOG.error(" }),
					insert_node(1, "e"),
					text_node({ ")", "" }),
				}),
				-- Log info
				snippet("li", {
					text_node({ "LOG.info(" }),
					insert_node(1, "msg"),
					text_node({ ")", "" }),
				}),
				-- Log warning
				snippet("lw", {
					text_node({ "LOG.warning(" }),
					insert_node(1, "msg"),
					text_node({ ")", "" }),
				}),
				-- Log debug
				snippet("ld", {
					text_node({ "LOG.debug(" }),
					insert_node(1, "msg"),
					text_node({ ")", "" }),
				}),
				-- Log critical
				snippet("ld", {
					text_node({ "LOG.critical(" }),
					insert_node(1, "msg"),
					text_node({ ")", "" }),
				}),
				-- Enumerate
				snippet("en", {
					text_node({ "for i, " }),
					insert_node(1, "val"),
					text_node({ " in enumerate(" }),
					insert_node(2, "items"),
					text_node({ "):", "" }),
					text_node({ "\t" }),
				}),
				-- List comprehension
				snippet("lcp", {
					text_node({ "[" }),
					insert_node(1, "elem"),
					text_node({ " for " }),
					insert_node(2, "val"),
					text_node({ " in " }),
					insert_node(3, "items"),
					text_node({ "]", "" }),
				}),
				-- Set comprehension
				snippet("scp", {
					text_node({ "{" }),
					insert_node(1, "elem"),
					text_node({ " for " }),
					insert_node(2, "val"),
					text_node({ " in " }),
					insert_node(3, "items"),
					text_node({ "}", "" }),
				}),
				-- Generator
				snippet("scp", {
					text_node({ "(" }),
					insert_node(1, "elem"),
					text_node({ " for " }),
					insert_node(2, "val"),
					text_node({ " in " }),
					insert_node(3, "items"),
					text_node({ ")", "" }),
				}),
				-- Dict comprehension
				snippet("dcp", {
					text_node({ "{" }),
					insert_node(1, "key"),
					text_node({ ": " }),
					insert_node(2, "value"),
					text_node({ " for " }),
					insert_node(3, "val"),
					text_node({ " in " }),
					insert_node(4, "items"),
					text_node({ "}", "" }),
				}),
				-- Lambda
				snippet("lam", {
					insert_node(1),
					text_node({ " = lambda " }),
					insert_node(2, "vars"),
					text_node({ ": " }),
					insert_node(3, "action"),
				}),
				-- Parser
				snippet("par", {
					text_node({ "parser = argparse.ArgumentParser()", "" }),
					text_node({ 'parser.add_argument("-' }),
					insert_node(1, "p"),
					text_node({ '", "--' }),
					insert_node(2, "param"),
					text_node({ '", default=' }),
					insert_node(3, "None"),
					text_node({ ', help="' }),
					insert_node(4, "Help text"),
					text_node({ '.")', "" }),
					insert_node(5),
					text_node({ "return parser", "" }),
				}),
				-- Add argument to the parser
				snippet("arg", {
					text_node({ 'parser.add_argument("-' }),
					insert_node(1, "p"),
					text_node({ '", "--' }),
					insert_node(2, "param"),
					text_node({ '", default=' }),
					insert_node(3, "None"),
					text_node({ ', help="' }),
					insert_node(4, "Help text"),
					text_node({ '.")', "" }),
				}),
				-- With statement using a context manager
				snippet("with", {
					text_node({ "with " }),
					insert_node(1, "ctx_manager"),
					text_node({ " as " }),
					insert_node(2, "alias"),
					text_node({ ":", "" }),
					text_node({ "\t" }),
					insert_node(3),
					text_node({ "", "" }),
				}),
				-- Mock function
				snippet("mock", {
					text_node({ "with mock.patch(", "" }),
					text_node({ "\t" }),
					insert_node(1, "module.function"),
					text_node({ ",", "" }),
					text_node({ "\treturn_value=" }),
					insert_node(2, "mocked_result"),
					text_node({ ",", "" }),
					text_node({ "):", "" }),
					text_node({ "\t" }),
					insert_node(3),
					text_node({ "", "" }),
				}),
				-- Mock dictionary
				snippet("mockd", {
					text_node({ "@mock.path.dict(", "" }),
					text_node({ "\t" }),
					insert_node(1, "os.environ"),
					text_node({ ",", "" }),
					text_node({ "\t{", "" }),
					text_node({ '\t\t"' }),
					insert_node(2, "key"),
					text_node({ '": ' }),
					insert_node(3, "val"),
					text_node({ "", "" }),
					text_node({ "\t}", "" }),
					text_node({ ")", "" }),
					insert_node(4),
				}),
				-- Parametric Pytest
				snippet("ptest", {
					text_node({ "@pytest.mark.parametrize(", "" }),
					text_node({ '\t"' }),
					insert_node(1, "input_args"),
					text_node({ ',expected",', "" }),
					text_node({ "\t[", "" }),
					text_node({ "\t\t(" }),
					insert_node(2, "case"),
					text_node({ ", " }),
					insert_node(3, "expected_result"),
					text_node({ "),", "" }),
					text_node({ "\t\tpytest.param(" }),
					function_node(copy, 2),
					text_node({ ", " }),
					function_node(copy, 3),
					text_node({ ", marks=pytest.mark.xfail()),", "" }),
					text_node({ "\t]", "" }),
					text_node({ ")", "" }),
					text_node({ "def test_" }),
					insert_node(4, "name"),
					text_node({ "(" }),
					function_node(copy, 1),
					text_node({ ", expected):", "" }),
					text_node({ '\t"""' }),
					insert_node(5, "Description"),
					text_node({ '."""', "" }),
					text_node({ "\t" }),
					insert_node(6),
					text_node({ "", "" }),
					text_node({ "\tassert(" }),
					function_node(copy, 1),
					text_node({ " == expected", "" }),
				}),
			})
			luasnip.add_snippets("yaml", {
				-- Avoid detached pipeline when in a MR
				snippet("nodet", {
					text_node({ ".avoid-detached-mr-pipeline: &no-detached-pipeline", "" }),
					text_node({ '  if: $CI_PIPELINE_SOURCE == "merge_request_event"', "" }),
					text_node({ "  when: never", "" }),
				}),
				-- Create a .gitlab-ci anchor
				snippet("anchor", {
					text_node({ "." }),
					insert_node(1, "name"),
					text_node({ ": &" }),
					insert_node(2, "alias"),
					text_node({ "", "" }),
					text_node({ "\t" }),
					insert_node(3),
					text_node({ "", "" }),
				}),
			})

			-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
			luasnip.autosnippets = { all = { snippet("autotrigger", { text_node("autosnippet") }) } }

			-- in a lua file: search lua-, then c-, then all-snippets.
			luasnip.filetype_extend("lua", { "c" })
			-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
			luasnip.filetype_set("cpp", { "c" })

			-- You can also use lazy loading so you only get in memory snippets of languages you use
			require("luasnip/loaders/from_vscode").lazy_load()
		end,
	},
	{
		"echasnovski/mini.ai", -- "a", "i" text objects
		event = "VeryLazy",
		version = "*",
		config = function()
			require("mini.ai").setup({
				custom_textobjects = nil,
				mappings = {
					-- Main textobject prefixes
					around = "a",
					inside = "i",
					-- Next/last variants
					around_next = "an",
					inside_next = "in",
					around_last = "al",
					inside_last = "il",
					-- Move cursor to corresponding edge of `a` textobject
					goto_left = "g[",
					goto_right = "g]",
				},
				-- Number of lines within which textobject is searched
				n_lines = 50,
				-- How to search for object (first inside current line, then inside
				-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
				-- 'cover_or_nearest', 'next', 'previous', 'nearest'.
				search_method = "cover_or_next",
				silent = false,
			})
		end,
	},
	{
		"echasnovski/mini.files",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("mini.files").setup({
				mappings = { -- Module mappings created only inside explorer
					close = "<Esc>",
					go_in = "l",
					go_in_plus = "<CR>",
					go_out = "h",
					go_out_plus = "H",
					mark_goto = "'",
					mark_set = "m",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "?",
					synchronize = "=",
					trim_left = "<",
					trim_right = ">",
				},
				options = {
					permanent_delete = false, -- Whether to delete permanently or move into module-specific trash
					use_as_default_explorer = true, -- Whether to use for editing directories
				},
				windows = { preview = true, width_preview = 80 },
			})
		end,
	},
	{ "mason-org/mason.nvim", opts = {} },
	{ "neovim/nvim-lspconfig" },
	{
		"alexghergh/nvim-tmux-navigation",
		event = "VeryLazy",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true,
				keybindings = { left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>", last_active = "<M-\\>" },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			require("conform").setup({ ---@diagnostic disable-line: different-requires
				formatters_by_ft = {
					c = { "clang-format" },
					cpp = { "clang-format" },
					cs = { "clang-format" },
					json = { "fixjson" },
					lua = { "stylua" },
					markdown = { "prettierd" },
					python = { "isort", "ruff_fix", "ruff_format" }, -- multiple formatters sequentially
					mojo = { "mojo_format" },
					sh = { "shfmt" },
					zsh = { "beautysh" },
					terraform = { "terraformfmt" },
					toml = { "taplo" },
					yaml = { "prettierd" },
					rust = { "rustfmt", lsp_format = "fallback" },
					go = { "goimports", "gofmt" },
					-- Conform will run the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					["_"] = { "trim_whitespace" },
				},
			})
		end,
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {}, -- remove default <space>-keybindings
	},
	{ "github/copilot.vim", event = "VeryLazy" },
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("refactoring").setup()
		end,
	},
	{ "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
	{
		"saghen/blink.cmp",
		version = "1.*", -- use a release tag to download pre-built binaries
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "none", -- set to 'none' to disable the 'default' preset
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				-- disable a keymap from the preset
				["<C-e>"] = {},
			},
			cmdline = {
				completion = {
					ghost_text = { enabled = true },
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype()
						end,
					},
					list = {
						selection = {
							-- When `true`, will automatically select the first item in
							-- the completion list
							preselect = false,
							-- When `true`, inserts the completion item automatically
							-- when selecting it
							auto_insert = true,
						},
					},
				},
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = { border = "rounded" },
				},
				menu = {
					auto_show = true,
					-- nvim-cmp style menu
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
					},
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },

			snippets = { preset = "luasnip" },

			signature = {
				enabled = true,
				window = { border = "rounded", show_documentation = true },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				win = {
					input = {
						keys = {
							["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
							["<Tab>"] = { "list_down", mode = { "i", "n" } },
						},
					},
				},
			},
			words = {},
			image = {
				doc = {
					enabled = true,
					inline = true,
					float = true,
					max_width = 80,
					max_height = 60,
				},
			},
			lazygit = {},
		},
	},
	{
		"echasnovski/mini.indentscope",
		opts = {
			mappings = {
				object_scope = "ii",
				object_scope_with_border = "ai",
				goto_top = "[i",
				goto_bottom = "]i",
			},
			symbol = "",
		},
	},

	-- Themes
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

require("lazy").setup(plugins, {})
