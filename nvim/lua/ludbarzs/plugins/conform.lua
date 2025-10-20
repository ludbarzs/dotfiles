return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "ruff_format" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" }, -- for .tsx
				javascript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				php = { "pint" }, --    composer require --dev laravel/pint
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
