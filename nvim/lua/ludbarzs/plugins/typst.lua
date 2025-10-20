return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = 'typst'
	version = "1.*",
	opts = {
		-- open_cmd = "firefox -P default %s",
	},
	config = function()
		vim.keymap.set("n", "<leader>tp", ":TypstPreview<CR>", { desc = "Typist preview" })
	end,
}
