-- Keybindings

-- Remap VIM 0 to first non-blank character
vim.keymap.set("", "0", "^", { silent = true }) -- map 0 ^

-- Snacks Picker
local snacks = require("snacks").picker

vim.keymap.set("n", "<leader>f", snacks.files, { silent = true })
vim.keymap.set("n", "<leader><leader>g", snacks.git_files, { silent = true })
vim.keymap.set("n", "<C-f>", snacks.grep, { silent = true })
vim.keymap.set("n", "<C-b>", snacks.buffers, { silent = true })
vim.keymap.set("n", "<F1>", snacks.highlights, { silent = true })
vim.keymap.set("n", "<F2>", snacks.keymaps, { silent = true })
vim.keymap.set("n", "<leader>n", function()
	return snacks.explorer({ diagnostics = false })
end, { silent = true })

vim.keymap.set("c", "<Esc>", "<C-c>")
vim.keymap.set("i", "<C-c>", "<Esc>")
-- vim.keymap.set("n", "<C-z>", "<Esc>") -- disable terminal ctrl-z

-- Map S to replace current word with pasteboard (do not save deleted word to register)
vim.keymap.set("n", "S", '"_diw"0P')
vim.keymap.set("n", "cc", '"_cc')

-- Map paste, yank and delete to named register so the content will not be overwritten
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("v", "x", '"_x')

-- Resize horzontal split window
vim.keymap.set("n", "<C-S-Down>", "<C-W>-<C-W>-")
vim.keymap.set("n", "<C-S-Up>", "<C-W>+<C-W>+")

-- Resize vertical split window
vim.keymap.set("n", "<C-Right>", "<C-W>><C-W>>")
vim.keymap.set("n", "<C-Left>", "<C-W><<C-W><")

-- Toggle relative line numbers
vim.keymap.set("n", "<leader>r", ":set relativenumber!<CR>", { silent = true })

-- Search bindings
vim.keymap.set("n", "<space>", "/")
vim.keymap.set("n", "<C-space>", "?")

-- Better indenting keeping highlighted block after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remove hightlight by pressing escape
vim.keymap.set("n", "<esc>", ":noh<CR>", { silent = true })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Update not write unless changed
vim.keymap.set("n", "<leader>w", ":up!<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", ":bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>h", ":nohlsearch<Bar>:echo<CR>", { silent = true })

-- Toggle CursorColumn
vim.keymap.set("n", "<leader>v", ":set cursorcolumn!<CR>", { silent = true })

-- Git blame enabling
vim.keymap.set("n", "<M-g>", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
vim.keymap.set("n", "<leader>hn", ":Gitsigns next_hunk<CR>", { silent = true })
vim.keymap.set("n", "<leader>hp", ":Gitsigns prev_hunk<CR>", { silent = true })

-- Keep the cursor centerd in place when moving across searches or joining lines
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "*", "*<C-o>")

-- Paste on highlighted without losing prev register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Avoid undo from removing too many things by breaking work in items
vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", "=", "=<C-g>u")
vim.keymap.set("i", ")", ")<C-g>u")
vim.keymap.set("i", "]", "]<C-g>u")
vim.keymap.set("i", "}", "}<C-g>u")
vim.keymap.set("i", "!", "!<C-g>u")
vim.keymap.set("i", "?", "?<C-g>u")

-- Comment
vim.keymap.set("", "<M-m>", "gccj", { remap = true })
vim.keymap.set("v", "<M-m>", "gcc<Esc>gv", { remap = true })

-- Renaming
vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", { silent = true })

-- Code action
vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<CR>", { silent = true })
vim.keymap.set("n", "<M-a>", ":lua vim.lsp.buf.code_action()<CR>", { silent = true })

-- Gitsigns
vim.keymap.set("n", "<leader>d", ":Gitsigns toggle_signs<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Gitsigns preview_hunk<CR>", { silent = true })

-- LazyGit
vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { silent = true })

-- Ignore lint diagnostic in-line
vim.keymap.set("n", "<M-i>", ":lua _G.IgnoreLintInLine()<CR>", {})

-- Hover
vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })

-- Go to definition
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>", { silent = true })
vim.keymap.set("n", "\\gd", ":vsp<CR>:lua vim.lsp.buf.definition()<CR>", { silent = true })

-- Go to references
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>", { silent = true })
vim.keymap.set("n", "\\gr", ":vsp<CR>:lua vim.lsp.buf.references()<CR>", { silent = true })

-- Avoid not being able to open fold when at end of line
vim.keymap.set("n", "zc", "zc0", { silent = true })

-- Move back and forth between buffers
vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":bnext<CR>", { silent = true })

-- Show signature help
vim.keymap.set("i", "<C-k>", function()
	vim.lsp.buf.signature_help()
end, { buffer = true })

-- Go to repo website on current line or home page
vim.api.nvim_set_keymap(
	"n",
	"gb",
	':lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").open_in_browser})<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"v",
	"gb",
	':lua require("gitlinker").get_buf_range_url("v", {action_callback = require("gitlinker.actions").open_in_browser})<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"gB",
	':lua require("gitlinker").get_repo_url({action_callback = require("gitlinker.actions").open_in_browser})<CR>',
	{ silent = true }
)

-- Toggle lints
vim.keymap.set("n", "<leader><leader>l", ":lua _G.toggle_lint()<CR>", { silent = true })

-- Toggle blocks of code
vim.keymap.set("n", "<leader>J", function()
	require("treesj").toggle({ split = { recursive = true } })
end)

-- Open mini.files
vim.keymap.set("n", "<leader>N", ":lua MiniFiles.open()<CR>", { silent = true })

-- Move to prev/next method/class
-- vim.keymap.set("n", "<C-k>", "[m", { remap = true, silent = true })
-- vim.keymap.set("n", "<C-j>", "]m", { remap = true, silent = true })
vim.keymap.set("n", "<C-k>", "{zz", { remap = true, silent = true })
vim.keymap.set("n", "<C-j>", "}zz", { remap = true, silent = true })

-- Move to prev/next class/function (line starting with a non-whitespace character)
vim.keymap.set("n", "(", "?^\\S<CR>:noh<CR>zz", { silent = true })
vim.keymap.set("n", ")", "/^\\S<CR>:noh<CR>zz", { silent = true })

-- DAP
vim.keymap.set("n", "<F5>", ":DapContinue<CR>", { silent = true })
vim.keymap.set("n", "<F6>", ":DapToggleBreakpoint<CR>", { silent = true })
vim.keymap.set("n", "<F12>", ":DapTerminate<CR>", { silent = true })
vim.keymap.set("n", "<M-t>", ":lua require('dapui').toggle()<CR>", { silent = true })

vim.keymap.set("n", "<M-q>", ":split<CR>:term python %<CR>", { silent = true })

-- Copilot
vim.keymap.set("i", "<M-a>", 'copilot#Accept("<CR><CR>")', { expr = true, silent = true, replace_keycodes = false })

-- Quick search in browser of the current Word under cursor
local function search_in_browser()
	local word = vim.fn.expand("<cWORD>")
	if word ~= "" then
		word = word:gsub("<{[()]}>`'\"*,;", "") -- remove brackets, quotes, *
		local url = "https://www.google.com/search?q=" .. vim.fn.escape(word, " ")
		vim.ui.open(url)
	else
		print("No word under cursor to search.")
	end
end
vim.keymap.set("n", "gX", search_in_browser, { silent = true })

-- Surround
vim.keymap.set("n", "<leader>s", ":norm ysiw", { silent = false })
vim.keymap.set("n", "<leader>c", ":norm cs", { silent = false })

-- Select the whole buffer
vim.keymap.set("n", "<leader>G", "ggVG")

-- Navigate to Quickfix location automatically when moving across its lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "j", "<Down><CR>zz<C-w>p", { buffer = true, remap = false })
		vim.keymap.set("n", "k", "<Up><CR>zz<C-w>p", { buffer = true, remap = false })
	end,
})

-- Insert date
vim.keymap.set("n", "<M-d>", ":put=strftime('%b %d, %Y')<CR>kJ", { silent = true })
vim.keymap.set("i", "<M-d>", ":put=strftime('%b %d, %Y')<CR>kJ", { silent = true })

-- inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

-- " Vim-test keybindings
-- nmap <silent><leader>tt :TestNearest<CR>
-- nmap <silent><leader>tf :TestFile<CR>
-- nmap <silent><leader>ta :TestSuite<CR>
-- nmap <silent><leader>ts :TestSuite<CR>
-- nmap <silent><leader>tl :TestLast<CR>

-- Luasnips
-- imap <silent><expr><C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- inoremap <silent><C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>

-- snoremap <silent><C-j> <cmd>lua require('luasnip').jump(1)<Cr>
-- snoremap <silent><C-k> <cmd>lua require('luasnip').jump(-1)<Cr>

-- imap <silent><expr><C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- smap <silent><expr><C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

-- Switch CWD to the directory of the open buffer
-- map <leader>cd :cd %:p:h<cr>:pwd<cr>
