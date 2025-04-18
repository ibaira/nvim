-- Nvim-tree configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.nvim_tree_disable_default_keybindings = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_show_icons = { git = 1, folders = 0, files = 0, folder_arrows = 0 }
vim.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" } -- empty by default, don't auto open tree on specific filetypes.
vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.

local function my_on_attach(bufnr)
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	local api = require("nvim-tree.api")

	-- Default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- Custom mappings
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Help"))
	vim.keymap.set("n", "s", api.node.open.horizontal, opts("Help"))
	-- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
end

require("nvim-tree").setup({
	on_attach = my_on_attach,
	hijack_cursor = false,
	auto_reload_on_write = true,
	disable_netrw = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	root_dirs = { ".git", ".gitlab-ci.json", ".gitignore" },
	prefer_startup_root = true,
	sync_root_with_cwd = true,
	reload_on_bufenter = true,
	respect_buf_cwd = false,
	select_prompts = false,
	sort = { sorter = "name", folders_first = true, files_first = false },
	view = {
		adaptive_size = true,
		centralize_selection = false,
		cursorline = true,
		debounce_delay = 15,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		width = 30,
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},
	renderer = {
		add_trailing = false,
		group_empty = false,
		full_name = false,
		root_folder_label = ":~:s?$?/",
		indent_width = 2,
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		hidden_display = "none",
		symlink_destination = true,
		highlight_git = "none",
		highlight_diagnostics = "none",
		highlight_opened_files = "all",
		highlight_modified = "none",
		highlight_hidden = "none",
		highlight_bookmarks = "none",
		highlight_clipboard = "name",
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = { corner = "└", edge = "│", item = "│", bottom = "─", none = " " },
		},
		icons = {
			web_devicons = { file = { enable = false, color = false }, folder = { enable = false, color = false } },
			git_placement = "after",
			modified_placement = "after",
			hidden_placement = "after",
			diagnostics_placement = "signcolumn",
			bookmarks_placement = "signcolumn",
			padding = " ",
			symlink_arrow = " -> ",
			show = {
				git = true,
				folder = false,
				folder_arrow = false,
				file = false,
				modified = false,
				hidden = false,
				diagnostics = false,
				bookmarks = false,
			},
			glyphs = {
				default = " ",
				symlink = "",
				bookmark = "",
				modified = "",
				hidden = "",
				git = {
					unstaged = "*",
					staged = "✓",
					unmerged = "U",
					renamed = "R",
					untracked = "?",
					deleted = "D",
					ignored = "◌",
				},
			},
		},
	},
	hijack_directories = { enable = false, auto_open = false },
	update_focused_file = { enable = true, update_root = { enable = false, ignore_list = {} }, exclude = false },
	system_open = { cmd = "", args = {} },
	git = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		disable_for_dirs = {},
		timeout = 400,
		cygwin_support = false,
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	modified = { enable = false, show_on_dirs = true, show_on_open_dirs = true },
	filters = {
		enable = true,
		git_ignored = true,
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		no_bookmark = false,
		custom = {},
		exclude = {},
	},
	live_filter = { prefix = "[FILTER]: ", always_show_folders = true },
	filesystem_watchers = { enable = true, debounce_delay = 50, ignore_dirs = {} },
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		expand_all = {
			max_folder_discovery = 300,
			exclude = {},
		},
		file_popup = {
			open_win_config = {
				col = 1,
				row = 1,
				relative = "cursor",
				border = "shadow",
				style = "minimal",
			},
		},
		open_file = {
			quit_on_open = false,
			eject = true,
			resize_window = true,
			window_picker = {
				enable = true,
				picker = "default",
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
		remove_file = {
			close_window = true,
		},
	},
	trash = { cmd = "gio trash" },
	tab = {
		sync = {
			open = false,
			close = false,
			ignore = {},
		},
	},
	notify = { threshold = vim.log.levels.INFO, absolute_path = true },
	help = { sort_by = "key" },
	ui = { confirm = { remove = true, trash = true, default_yes = false } },
	experimental = { actions = { open_file = { relative_path = false } } },
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			dev = false,
			diagnostics = false,
			git = false,
			profile = false,
			watcher = false,
		},
	},
})
