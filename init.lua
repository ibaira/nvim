-- Bootstrap lazy.nvim
require("core.lazy")

-- Theme
vim.o.background = "dark"
require("plugins.gruvbox")

-- Custom configs
require("plugins.startify")
require("plugins.lualine")
require("plugins.noice")
require("plugins.lspconfig")
require("plugins.luasnip")
require("plugins.nvim-lint")
require("plugins.conform")
require("plugins.hop")
-- require("plugins.neotest") -- tests
-- require("plugins.neogen") -- auto-documentation

require("core.settings")
require("core.filetypes")
require("core.keymaps")
