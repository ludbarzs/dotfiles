-- Soft wrap
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
-- vim.opt.textwidth = 0
-- vim.opt.wrapmargin = 0
-- vim.opt.colorcolumn = "100"

-- Move by screen lines instead of file lines
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
