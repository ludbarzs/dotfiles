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
				scss = { "prettier" },
				php = { "pint" }, --    composer require --dev laravel/pint
				svelte = { "prettier" }, --    composer require --dev laravel/pint
				-- Run in project root:
				-- npm i --save-dev prettier-plugin-svelte
				-- Createa .prettierrc in project root, add:
				-- {"plugins": ["prettier-plugin-svelte"]}
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
