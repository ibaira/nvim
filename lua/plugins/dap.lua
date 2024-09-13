-- DAP configuration

-- Python adapter definition
local pyenv = os.getenv("CONDA_DEFAULT_ENV")
local conda_python = "/home/baira/miniconda3/envs/" .. pyenv .. "/bin/python"

require("dap-python").setup(conda_python)

-- Python configuration
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

			if pyenv then
				return conda_python
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

-- UI -> Use DAP events to open and close the windows automatically
require("dapui").setup()
local dapui = require("dapui")
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

-- Keymaps
vim.keymap.set("n", "<F5>", ":DapContinue<CR>", { silent = true })
vim.keymap.set("n", "<F6>", ":DapToggleBreakpoint<CR>", { silent = true })
vim.keymap.set("n", "<F12>", ":DapTerminate<CR>", { silent = true })
vim.keymap.set("n", "<M-t>", ":lua require('dapui').toggle()<CR>", { silent = true })
