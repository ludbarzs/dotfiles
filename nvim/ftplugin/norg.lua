-- Binding list: https://github.com/nvim-neorg/neorg/wiki/Default-Keybinds
-- vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })

vim.keymap.set(
  "n",
  "<localleader>cs",
  "<Plug>(neorg.qol.todo-items.todo.task-cycle)",
  { desc = "Seitch the task under the cursor between states", buffer = true }
)
vim.keymap.set("n", "<Tab>", "za", { desc = "Seitch the task under the cursor between states", buffer = true })

vim.keymap.set("n", "<leader>li", "I- <Esc>", { desc = "Convert line to list item" })

vim.opt_local.conceallevel = 2

-- Auto save for nerog files
vim.o.autowrite = true
vim.o.autowriteall = true
