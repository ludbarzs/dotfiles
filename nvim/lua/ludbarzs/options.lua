-- Kickstart configs
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true    -- Which line cursor on

vim.opt.mouse = "a"          -- Resizing splits with mouse?
vim.opt.showmode = true      -- Shows mode (Insert/Visual...)
vim.opt.breakindent = true   -- Enable break indent
vim.opt.undofile = true      -- Save undo history
vim.opt.tabstop = 2          -- Tabstop of 2
vim.opt.signcolumn = "yes"   -- Keep signcolumn on by default
vim.opt.updatetime = 250     -- Decrease update time
vim.opt.timeoutlen = 300     -- Decrease mapped sequence wait time
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sync clipboard between OS and NeoVim
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 3
