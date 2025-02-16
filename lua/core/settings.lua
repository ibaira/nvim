---------------------------------
-- Settings
---------------------------------

vim.opt.fileformat = "unix"
vim.opt.shortmess:append("c")

vim.opt.number = true --  always show current line number

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.fillchars:append("vert: ") --  remove chars from seperators
vim.opt.softtabstop = 4

-- Default folding method:
-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldtext = "" -- The first line of the fold will be syntax highlighted
-- Use treesitter as source of truth for folding instead of LSP
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.fillchars:append("fold: ") --  remove chars from fold endings

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true -- save undos
vim.opt.undolevels = 10000 -- maximum number of changes that can be undone
vim.opt.undoreload = 100000 -- maximum number lines to save for undo on a buffer reload

vim.opt.splitright = true
vim.opt.splitbelow = true

-- Copy to/from Windows
vim.opt.clipboard:append("unnamedplus")

---------------------------------
-- Basic settings
---------------------------------

vim.g.mapleader = ","

-- Sets how many lines of history VIM has to remember
vim.opt.history = 500
vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true

---------------------------------
-- VIM user interface
---------------------------------

-- lines to the cursor - when moving vertically using j/k
vim.opt.scrolloff = 7

vim.opt.cursorline = true

-- Avoid garbled characters in Chinese language windows OS
vim.opt.langmenu = "en"

-- Turn on the Wild menu
vim.opt.wildmenu = true

-- Ignore compiled files
vim.opt.wildignore = { "*.o", "*~", "*.pyc" }

-- Always show current position
vim.opt.ruler = true

-- Height of the command bar
vim.opt.cmdheight = 1

-- A buffer becomes hidden when it is abandoned
vim.opt.hid = true

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Makes search act like search in modern browsers
vim.opt.incsearch = true

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = false -- problem with Noice

-- For regular expressions turn magic on
vim.opt.magic = true

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true

-- How many tenths of a second to blink when matching brackets
vim.opt.mat = 2

-- No annoying sound on errors
-- vim.o.noerrorbells=true
-- vim.o.novisualbell=true
-- vim.o.t_vb=
vim.opt.tm = 500

-- Automatic formatting of paragraphs
-- vim.opt.formatoptions:append("a")

---------------------------------
-- Colors and Fonts
---------------------------------

-- Set utf8 as standard encoding and en_US as the standard language
vim.opt.encoding = "utf8"

-- Use Unix as the standard file type
vim.opt.fileformats = { "unix", "dos", "mac" }

---------------------------------
-- Files, backups and undo
---------------------------------

-- Turn backup off, since most stuff is in SVN, git etc. anyway...
vim.opt.backup = false
vim.opt.swapfile = false

---------------------------------
-- Text, tab and indent related
---------------------------------

--  Use spaces instead of tabs
vim.opt.expandtab = true

--  Be smart when using tabs ;)
vim.opt.smarttab = true

--  1 tab == 4 spaces
vim.opt.shiftwidth = 4

--  Linebreak on 500 characters
vim.opt.linebreak = true
vim.opt.textwidth = 88
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

---------------------------------
-- Moving around, tabs, windows and buffers
---------------------------------

-- Return to last edit position when opening files (You want this!)
-- au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

-- Persistent Folds
local augroup = vim.api.nvim_create_augroup
local save_fold = augroup("Persistent Folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function()
		vim.cmd.mkview()
	end,
	group = save_fold,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function()
		vim.cmd.loadview({ mods = { emsg_silent = true } })
	end,
	group = save_fold,
})

-- Persistent Cursor
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Cursor Line on each window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	callback = function()
		local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
		if ok and cl then
			vim.wo.cursorline = true
			vim.api.nvim_win_del_var(0, "auto-cursorline")
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	callback = function()
		local cl = vim.wo.cursorline
		if cl then
			vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
			vim.wo.cursorline = false
		end
	end,
})

---------------------------------
-- Status line
---------------------------------

-- Global status line
vim.opt.laststatus = 3

---------------------------------
-- Folds
---------------------------------

function Custom_fold_text()
	local indentation_value = vim.fn.indent(vim.v.foldstart)
	local space_offset = string.rep(" ", indentation_value)
	local number_folded_lines = vim.v.foldend - vim.v.foldstart
	return space_offset .. "+--- " .. number_folded_lines .. " lines"
end

function Custom_fold_text_with_line()
	local custom_fold_text = Custom_fold_text()
	local line_num = vim.v.foldstart
	local current_line_content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
	current_line_content = current_line_content:gsub("^%s+", "")
	return custom_fold_text .. " - " .. current_line_content .. " "
end

vim.opt.foldtext = "v:lua.Custom_fold_text_with_line()"

---------------------------------
-- LazyGit
---------------------------------

-- Full size
vim.g.lazygit_floating_window_scaling_factor = 1.0

---------------------------------
-- Breadcrumbs
---------------------------------

vim.o.winbar =
	"%{%v:lua.vim.fn.fnamemodify(v:lua.vim.fn.expand('%'), ':p:~:.')%}  %{%v:lua.require'nvim-navic'.get_location()%}"

---------------------------------
-- Editing mappings
---------------------------------

-- Move a line of text using ALT+[jk] or Command+[jk] on mac
-- nmap <M-j> mz:m+<cr>`z
-- nmap <M-k> mz:m-2<cr>`z
-- vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
-- vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

-- if has("mac") || has("macunix")
--   nmap <D-j> <M-j>
--   nmap <D-k> <M-k>
--   vmap <D-j> <M-j>
--   vmap <D-k> <M-k>
-- endif

---------------------------------
-- Misc
---------------------------------

-- Remove the Windows ^M - when the encodings gets messed up
-- noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

-- :W sudo saves the file
-- (useful for handling the permission-denied error)
-- command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

-- au Colorscheme * :set cmdheight=1  " single line cmd line
-- set mouse=a  -- change cursor per mode
-- set smartcase  " better case-sensitivity when searching
-- set wrapscan  " begin search from top of file when nothing is found anymore
-- vim.opt.noautochdir=true
-- set nobackup  " no backup or swap file, live dangerously
-- set noswapfile  " swap files give annoying warning
--
-- set breakindent  " preserve horizontal whitespace when wrapping
-- set showbreak=..
-- set lbr  " wrap words
-- set nowrap  " i turn on wrap manually when needed
-- set noshowmode  " keep command line clean
-- set noshowcmd

-- set hlsearch  " highlight search and search while typing
-- set incsearch
-- set cpoptions+=x  " stay at seach item when <esc>
--
-- set noerrorbells  " remove bells (i think this is default in neovim)
-- set visualbell
-- set t_vb=
-- set viminfo='20,<1000  " allow copying of more than 50 lines to other applications
--
-- " set clipboard=unnamedplus
-- " set completeopt=menu,noselect,noinsert,preview
-- set completeopt=menu,menuone,preview
--
-- au! BufWritePost $MYVIMRC source %  " auto source when writting to init.vim

-- set pumheight=5

-- " mapping to make movements operate on 1 screen line in wrap mode
-- function! ScreenMovement(movement)
--    if &wrap
--       return "g" . a:movement
--    else
--       return a:movement
--    endif
-- endfunction

-- nnoremap <silent><nowait> [ [[
-- nnoremap <silent><nowait> ] ]]
--
-- au BufEnter * if &buftype == 'terminal' | :startinsert | endif
--
--#region
-- Copy to Windows clipboard
-- vim.opt.s:clip = '/mnt/c/Windows/System32/clip.exe'
-- if executable(vim.opt.s:clip) then
--   vim.api.nvim_create_autocmd({ "TextYankPost" }, {
--   	pattern = "*",
--   	command = "",
--   })
-- end
-- if executable(s:clip)
--     augroup WSLYank
--         autocmd!
--         autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
--     augroup END
-- endif

-- " Do not start automatically instant_markdown
-- let g:instant_markdown_autostart = 0

-- Hide . directory in netwr
-- let g:netrw_list_hide = '^\./$'
-- let g:netrw_hide = 1

-- Explore directory with Netwr when running: 'vim .'
-- augroup ProjectDrawer
--     autocmd!
--     autocmd VimEnter * if argv(0) == "." | Explore! | endif
-- augroup END

-- set pumheight=20
-- set updatetime=10
