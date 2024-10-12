-- LSP config

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"pyright",
	"bashls",
	"ccls",
	"dockerls",
	"rls",
	"ruff",
	"terraformls",
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
	underline = false,
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
vim.opt.updatetime = 50

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
	underline = false,
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
