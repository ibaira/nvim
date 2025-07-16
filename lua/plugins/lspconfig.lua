-- LSP config

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
vim.lsp.enable(servers)

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
vim.lsp.enable("yamlls")

-- Lua
vim.lsp.config("lua_ls", {
	on_init = function(client)
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = { version = "LuaJIT" },
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					"${3rd}/luv/library",
					os.getenv("HOME") .. "/.local/share/nvim/lazy",
				},
			},
		})
	end,
	settings = { Lua = { diagnostics = { globals = { "vim" } } } },
	telemetry = { enable = false },
})
vim.lsp.enable("lua_ls")

-- Remove virtual text in line for diagnostics
local function diagnostic_format(diagnostic)
	return string.format("%s (%s): %s", diagnostic.source, diagnostic.code, diagnostic.message)
end

local active_diagnostics_config = {
	virtual_text = false,
	virtual_lines = { current_line = true, format = diagnostic_format },
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
	severity_sort = true,
}
local inactive_diagnostics_config = {
	virtual_text = false,
	virtual_lines = false,
	underline = false,
	signs = false,
	float = false,
}

vim.diagnostic.config(active_diagnostics_config)
vim.g.diagnostic_active = true

function _G.toggle_lint()
	if vim.g.diagnostic_active then
		vim.diagnostic.config(inactive_diagnostics_config)
	else
		vim.diagnostic.config(active_diagnostics_config)
	end
	vim.g.diagnostic_active = not vim.g.diagnostic_active
end

vim.opt.updatetime = 50
