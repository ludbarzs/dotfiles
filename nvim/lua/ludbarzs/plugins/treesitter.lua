return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
	config = function()
		local ensure_installed = {
			"svelte",
			"typescript",
			"javascript",
			"html",
			"css",
			"lua",
			"vim",
			"vimdoc",
			"rust",
		}

		require("nvim-treesitter").install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = ensure_installed,
			callback = function()
				-- pcall so a missing/not-yet-installed parser doesn't throw an error dialog
				pcall(vim.treesitter.start)
				pcall(function()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end)
			end,
		})
	end,
}
