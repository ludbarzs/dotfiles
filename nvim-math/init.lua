require("plugins")

-- General settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true

-- Markdown-specific tweaks
vim.g.markdown_fenced_languages = { "html", "python", "bash=sh", "lua" }

-- Enable markdown preview
vim.g.mkdp_auto_start = 0 -- Set to 1 if you want preview to auto-open
vim.g.mkdp_browser = "" -- Let it use default browser

-- Keymap for toggling markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true })

-- Leader key
vim.g.mapleader = " "

-- Snippet-friendly completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
