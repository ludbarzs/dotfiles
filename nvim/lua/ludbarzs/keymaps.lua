vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>fa", "ggVG=", { desc = "Format file with treesitter" })

-- Diagnostics
vim.keymap.set("n", "gll", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Yank error with gly
vim.keymap.set("n", "gly", function()
	local diagnostics = vim.diagnostic.get(0)
	local message = ""
	for _, value in pairs(diagnostics) do
		message = message .. value.message
	end
	vim.fn.setreg("+", message)
end, { desc = "Yank line diagnostics" })
