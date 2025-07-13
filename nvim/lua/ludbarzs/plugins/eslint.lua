return {
	{
		"esmuellert/nvim-eslint",
		config = function()
			require("nvim-eslint").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = true,
	},
}
