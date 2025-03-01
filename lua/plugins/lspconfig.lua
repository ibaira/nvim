-- LSP config
local lspconfig = require("lspconfig")

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"pyright",
	"bashls",
	"clangd",
	"dockerls",
	"ruff",
	"rust_analyzer",
	"terraformls",
	"gopls",
	"mojo",
	"lemminx",
	"cmake",
	"marksman",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({ flags = { debounce_text_changes = 150 } })
end

-- YAML
lspconfig.yamlls.setup({
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
				-- kubernetes = "/*.yaml",
				[os.getenv("HOME") .. "/.config/nvim/.gitlab-ci.json"] = "/*gitlab-ci*",
			},
		},
	},
})

-- Lua
lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- Lsp saga formatting

-- Hover doc popup
local border = "rounded"
local max_width = 80

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border,
	max_width = max_width,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border,
	max_width = max_width,
	close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
})

-- Remove virtual text in line for diagnostics
local active_diagnostics_config = {
	virtual_text = true,
	underline = false,
	signs = true,
	float = { source = true, border = border },
	severity_sort = true,
}
local inactive_diagnostics_config = {
	virtual_text = false,
	underline = false,
	signs = false,
	float = false,
}

vim.g.diagnostic_active = true
vim.diagnostic.config(active_diagnostics_config)

function _G.nolint()
	if vim.g.diagnostic_active then
		vim.diagnostic.config(inactive_diagnostics_config)
		vim.g.diagnostic_active = false

		-- Why isn't this working? Need to change buffer for it to take effect for some
		-- reason
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false, -- for LSP diagnostics only
			signs = false,
			update_in_insert = false,
			underline = false,
			border = border,
			max_width = max_width,
			source = true,
		})
	else
		vim.diagnostic.config(active_diagnostics_config)
		vim.g.diagnostic_active = true

		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = true, -- for LSP diagnostics only
			signs = false,
			update_in_insert = false,
			underline = false,
			border = border,
			max_width = max_width,
			source = true,
		})
	end
end

-- This is the configuration for the LSPs like Pyright
if vim.g.diagnostic_active then
	-- TODO: why does the LSP stil show sign highlights after deactivation?
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true, -- for LSP diagnostics only
		signs = true,
		update_in_insert = false,
		underline = false,
		border = border,
		max_width = max_width,
		source = true,
	})

	-- Edit lsp diagnostic line icon and highlight the corresponding line number
	local signs = { Error = "", Warn = "", Hint = "", Info = "" } -- "● ", Info = " "
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, numhl = hl })
	end
end

-- Open diagnostic window when in diagnostic line without "Diagnostics:" header
vim.opt.updatetime = 50
vim.api.nvim_create_autocmd({ "CursorHold" }, { -- Not when CursorHoldI so it doesn't hide the lsp signature help
	pattern = "*",
	callback = function()
		if vim.g.diagnostic_active then
			vim.diagnostic.open_float({ header = "", focus = false })
		end
	end,
})
