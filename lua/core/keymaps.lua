-- Keybindings

-- Remap VIM 0 to first non-blank character
vim.keymap.set("", "0", "^", { silent = true }) -- map 0 ^

-- Telescope
vim.keymap.set("n", "<leader>f", _G.my_fd, { silent = true })
vim.keymap.set("n", "<C-f>", _G.my_rg, { silent = true })
vim.keymap.set("n", "<C-b>", require("telescope.builtin").buffers, { silent = true })
vim.keymap.set("n", "<F1>", require("telescope.builtin").highlights, { silent = true })
vim.keymap.set("n", "<F2>", require("telescope.builtin").keymaps, { silent = true })

-- NvimTree toggle
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", { silent = true })

vim.keymap.set("c", "<Esc>", "<C-c>")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-z>", "<Esc>") -- disable terminal ctrl-z

-- Map S to replace current word with pasteboard
vim.keymap.set("n", "S", 'diw"0P')
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

-- Remove hightlight by pressing escape twice
vim.keymap.set("n", "<esc><esc>", ":noh<CR>", { silent = true })

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

-- Keep the cursor centerd in place when moving across searches or joining lines
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

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
vim.keymap.set("n", "<leader>a", ":Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "<M-a>", ":Lspsaga code_action<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<CR>", { silent = true })

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
	"<leader>gb",
	':lua require("gitlinker").get_buf_range_url("n", {action_callback = require("gitlinker.actions").open_in_browser})<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"v",
	"<leader>gb",
	':lua require("gitlinker").get_buf_range_url("v", {action_callback = require("gitlinker.actions").open_in_browser})<CR>',
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>gB",
	':lua require("gitlinker").get_repo_url({action_callback = require("gitlinker.actions").open_in_browser})<CR>',
	{ silent = true }
)

-- Toggle lints
vim.keymap.set("n", "<leader><leader>l", ":lua _G.nolint()<CR>", { silent = true })

-- Toggle blocks of code
vim.keymap.set("n", "<leader>J", function()
	require("treesj").toggle({ split = { recursive = true } })
end)

-- Open mini.files
vim.keymap.set("n", "<leader>N", ":lua MiniFiles.open()<CR>", { silent = true })

-- Jump to next empty line
-- vim.keymap.set("n", "<C-j>", "}zz", { silent = true })
-- vim.keymap.set("n", "<C-k>", "{zz", { silent = true })

-- Move to prev/next method/class
vim.keymap.set("n", "<C-k>", "[m", { remap = true, silent = true })
vim.keymap.set("n", "<C-j>", "]m", { remap = true, silent = true })

-- Move to prev/next class/function
vim.keymap.set("n", "(", "?^\\S<CR>:noh<CR>", { silent = true })
vim.keymap.set("n", ")", "/^\\S<CR>:noh<CR>", { silent = true })

-- Toggle floating terminal
vim.keymap.set("n", "<M-r>", ":Lspsaga term_toggle<CR>", { silent = true })

-- inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

-- PyShell
-- nmap <leader>re :call StartPyShell()<CR>
-- nmap <leader>res :call StopPyShell()<CR>:call VimuxCloseRunner()<CR>
-- nmap <leader>s :call PyShellSendLine()<CR>j
-- vmap <leader>s :call PyShellSendMultiLine()<CR>j
-- let g:pysparkMode=1

-- " Vim-test keybindings
-- nmap <silent><leader>tt :TestNearest<CR>
-- nmap <silent><leader>tf :TestFile<CR>
-- nmap <silent><leader>ta :TestSuite<CR>
-- nmap <silent><leader>ts :TestSuite<CR>
-- nmap <silent><leader>tl :TestLast<CR>

-- " Doge auto-docstring
-- let g:doge_mapping='<leader><leader>d'
-- let g:doge_mapping_comment_jump_forward='<C-j>'
-- let g:doge_mapping_comment_jump_backward='<C-k>'

-- Git browse
-- nmap gb :GBrowse<CR>

-- Luasnips
-- imap <silent><expr><C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- inoremap <silent><C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>

-- snoremap <silent><C-j> <cmd>lua require('luasnip').jump(1)<Cr>
-- snoremap <silent><C-k> <cmd>lua require('luasnip').jump(-1)<Cr>

-- imap <silent><expr><C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- smap <silent><expr><C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

-- Switch CWD to the directory of the open buffer
-- map <leader>cd :cd %:p:h<cr>:pwd<cr>
