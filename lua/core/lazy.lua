-- Lazy configuration

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then ---@diagnostic disable-line: undefined-field
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
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "miikanissi/modus-themes.nvim", priority = 1000 },
	-- {
	-- 	"f-person/auto-dark-mode.nvim",
	-- 	opts = {
	-- 		update_interval = 1000,
	-- 		set_dark_mode = function()
	-- 			vim.o.background = "dark"
	-- 			require("plugins.gruvbox")
	-- 			vim.cmd("colorscheme gruvbox")
	-- 		end,
	-- 		set_light_mode = function()
	-- 			vim.o.background = "light"
	-- 			require("plugins.gruvbox")
	-- 			vim.cmd("colorscheme gruvbox")
	-- 		end,
	-- 	},
	-- },
	{ "mhinz/vim-startify" }, -- Single Vimscript plugin
	{ "nvim-lualine/lualine.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
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
	{ "neovim/nvim-lspconfig" },
	{ "mfussenegger/nvim-lint", event = "VeryLazy" },
	{ "hadronized/hop.nvim", branch = "v2", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "mfussenegger/nvim-dap-python", event = "VeryLazy" },
	{ "kdheepak/lazygit.nvim", dependencies = { "nvim-lua/plenary.nvim" }, event = "VeryLazy" },
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
	{ "folke/noice.nvim", event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim" } }, -- not lazy or lag
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
					pattern = [=[[%'%"%>%]%)%}%,]]=],
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
				render = "background",

				---Set virtual symbol (requires render to be set to 'virtual')
				virtual_symbol = "■",

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
					go_in_plus = "L",
					go_out = "h",
					go_out_plus = "H",
					mark_goto = "'",
					mark_set = "m",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
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
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason").setup() -- Important to chain this before
			require("mason-lspconfig").setup({
				ensure_installed = {
					"clangd",
					"lua_ls",
					"pyright",
					"ruff",
					"rust_analyzer",
					"sqlls",
					"taplo",
				},
			})
		end,
	},
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
		config = function()
			require("treesj").setup()
		end,
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
			indent = {
				indent = { only_scope = true, only_current = true },
			},
			words = {},
		},
	},

	-- Themes
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

require("lazy").setup(plugins, {})
