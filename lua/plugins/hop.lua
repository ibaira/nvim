-- Hop configuration

local hop = require("hop")
local direction = require("hop.hint").HintDirection

-- Search everywhere at once
vim.keymap.set("n", "s", ":HopWord<CR>", { remap = true })

-- Forward and backward
-- vim.keymap.set("n", "f", function()
-- 	hop.hint_char1({ current_line_only = true }) end, { remap = true })

-- With direction
vim.keymap.set("n", "F", function()
	hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("n", "t", function()
	hop.hint_char1({ direction = direction.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("n", "T", function()
	hop.hint_char1({ direction = direction.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })

hop.setup()
