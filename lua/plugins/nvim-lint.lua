---------------------------------------------------------------------
-- Custom linter configurations
---------------------------------------------------------------------

lint = require("lint")
parser = require("lint.parser")

-- Luacheck
local pattern = "[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)"
local groups = { "lnum", "col", "end_col", "severity", "code", "message" }
local severities = { W = vim.diagnostic.severity.WARN, E = vim.diagnostic.severity.ERROR }

lint.linters.luacheck = {
	cmd = "luacheck",
	stdin = true,
	args = { "--formatter", "plain", "--codes", "--ranges", "-", "--global", "vim" }, -- With "vim" as global variable
	ignore_exitcode = true,
	parser = parser.from_pattern(pattern, groups, severities, { ["source"] = "luacheck" }, { end_col_offset = 0 }),
}

-- Tflint
local pattern_tf = "([^%c]-):(%d+),(%d+).-:(.+)"
local groups_tf = { "file", "lnum", "col", "message" }
lint.linters.tflint = {
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
