-- Bootstrap lazy.nvim
require("core.lazy")

-- Theme
vim.opt.background = "dark"
-- require("plugins.gruvbox")

-- Custom configs
require("plugins.lualine")
require("plugins.lspconfig")
-- require("plugins.neotest") -- tests
-- require("plugins.neogen") -- auto-documentation

require("core.settings")
require("core.filetypes")
require("core.keymaps")

vim.cmd("colorscheme catppuccin-mocha")
