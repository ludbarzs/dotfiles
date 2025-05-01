-- vim.cmd - Run vim script commands in lua

-- Sets :Ex manue to tree style layout
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 
opt.shiftwidth = 2 -- Controls how many spaces >> and << moves
opt.softtabstop = 2 -- Spaces inserted when pressing tab
opt.expandtab = true -- Tab is spaces not \t
opt.autoindent = true -- Next line will have same indentation

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore cases when searching
opt.smartcase = true -- if you include cases, assumes to search case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorshceme to work
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or start position

-- clipboard
opt.clipboard:append("unnamedplus") -- system clipboard as default register

--split windows
opt.splitright = true
opt.splitbelow = true
