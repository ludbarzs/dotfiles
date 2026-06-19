-- Yank error with gly
vim.keymap.set("n", "gly", function()
	local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	local message = ""
	for _, value in pairs(diagnostics) do
		message = message .. value.message
	end
	vim.fn.setreg("+", message)
end, { desc = "Yank line diagnostics" })
