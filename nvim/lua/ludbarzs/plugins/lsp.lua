return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"saghen/blink.cmp",
		{ "j-hui/fidget.nvim", opts = {} }, -- Notifications
	},
	-- sudo pacman -Syu lua-language-server pyright typescript-language-server deno
	config = function()
		-- See all lsps in :h lspconfig-all
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("denols")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("html")
		vim.lsp.enable("cssls")

		require("lspconfig")["tinymist"].setup({
			settings = {
				formatterMode = "typstyle",
				exportPdf = "onType",
				semanticTokens = "disable",
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
		})

		local telescope = require("telescope.builtin")
		-- Rename the variable under your cursor.
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "[G]oto Code [A]ction" })
		vim.keymap.set("x", "gra", vim.lsp.buf.code_action, { desc = "[G]oto Code [A]ction" })
		-- Find references for the word under your cursor.
		vim.keymap.set("n", "grr", telescope.lsp_references, { desc = "[G]oto [R]eferences" })
		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		vim.keymap.set("n", "gri", telescope.lsp_implementations, { desc = "[G]oto [I]mplementation" })
		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		vim.keymap.set("n", "gd", telescope.lsp_definitions, { desc = "[G]oto [D]efinition" })
		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		vim.keymap.set("n", "gO", telescope.lsp_document_symbols, { desc = "Open Document Symbols" })
		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		vim.keymap.set("n", "gW", telescope.lsp_dynamic_workspace_symbols, { desc = "Open Workspace Symbols" })
		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		vim.keymap.set("n", "grt", telescope.lsp_type_definitions, { desc = "[G]oto [T]ype Definition" })
	end,
}
