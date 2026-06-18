return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"svelte",
				"typescript",
				"javascript",
				"html",
				"css",
				"lua",
				"vim",
				"vimdoc",
			},
			sync_install = false,
			highlight = {
				enable = true, -- This turns on the advanced syntax highlighting
			},
			indent = {
				enable = true,
			},
		})
	end,
}
