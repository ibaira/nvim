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
	vim.lsp.config(lsp, { flags = { debounce_text_changes = 150 } })
end

-- YAML
vim.lsp.config("yamlls", {
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
vim.lsp.config("lua_ls", {
	on_init = function(client)
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = { version = "LuaJIT" },
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
			},
		})
	end,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
	telemetry = { enable = false },
})

-- Remove virtual text in line for diagnostics
local active_diagnostics_config = {
	virtual_text = true,
	underline = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
		},
	},
	float = { source = true, border = "rounded" },
	severity_sort = true,
}
local inactive_diagnostics_config = {
	virtual_text = false,
	underline = false,
	signs = false,
	float = false,
}

vim.diagnostic.config(active_diagnostics_config)
vim.g.diagnostic_active = true
vim.g.float_diagnostic_active = true

function _G.toggle_lint()
	if vim.g.diagnostic_active then
		vim.diagnostic.config(inactive_diagnostics_config)
	else
		vim.diagnostic.config(active_diagnostics_config)
	end
	vim.g.diagnostic_active = not vim.g.diagnostic_active
end

function _G.toggle_float_lint()
	vim.g.float_diagnostic_active = not vim.g.float_diagnostic_active
end

-- Open diagnostic window when in diagnostic line without "Diagnostics:" header
vim.opt.updatetime = 50
vim.api.nvim_create_autocmd({ "CursorHold" }, { -- Not when CursorHoldI so it doesn't hide the lsp signature help
	pattern = "*",
	callback = function()
		if vim.g.diagnostic_active and vim.g.float_diagnostic_active then
			vim.diagnostic.open_float({ header = "", focus = false })
		end
	end,
})
