-- Bootstrap lazy.nvim
require("core.lazy")

-- Theme
require("plugins.gruvbox")

-- Custom configs
require("plugins.startify")
require("plugins.lualine")
require("plugins.noice")
require("plugins.treesitter")
require("plugins.lspconfig")
require("plugins.telescope")
require("plugins.nvim-tree")
require("plugins.nvim-cmp")
require("plugins.nvim-lint")
require("plugins.formatter")
require("plugins.hop")
require("plugins.autopairs")
require("plugins.dap")
-- require("plugins.neotest")
-- require("plugins.neogen")

require("core.settings")
require("core.filetypes")
require("core.keymaps")
