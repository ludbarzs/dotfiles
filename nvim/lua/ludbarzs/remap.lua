vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>t", ":split | terminal<CR>", { desc = "Open terminal in horizontal split" })
