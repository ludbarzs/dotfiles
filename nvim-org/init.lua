-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2 -- Indent size

-- Synch clipboards
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
-- Save undo history
vim.opt.undofile = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Custom keymaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Open :Ex
vim.keymap.set("n", "<leader>s", ":norm i#+BEGIN_SRC<CR><CR>#+END_SRC<ESC>ki", { desc = "Insert SRC block" })
-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"nvim-orgmode/orgmode",
			dependencies = {
				"akinsho/org-bullets.nvim",
				"chipsenkbeil/org-roam.nvim",
			},
			config = function()
				-- Setup orgmode
				require("orgmode").setup({
					org_agenda_files = "~/Documents/org/*",
					org_default_notes_file = "~/Documents/org/refile.org",
				})

				-- Setup org-bullets
				require("org-bullets").setup({
					show_current_line = true, -- Highlight current line
					symbols = {
						headlines = { "◉", "○", "✸", "✿" }, -- Custom bullet symbols
						checkboxes = {
							cancelled = { "", "OrgCancelled" },
							done = { "✓", "OrgDone" },
							todo = { "˟", "OrgTODO" },
						},
					},
				})

				require("org-roam").setup({
					directory = "~/org_roam_files",
					-- optional
					-- org_files = {},
				})
			end,
		},

		-- Telescope for orgmode
		{
			"nvim-orgmode/telescope-orgmode.nvim",
			event = "VeryLazy",
			dependencies = {
				"nvim-orgmode/orgmode",
				"nvim-telescope/telescope.nvim",
			},
			config = function()
				require("telescope").load_extension("orgmode")

				vim.keymap.set("n", "<leader>r", require("telescope").extensions.orgmode.refile_heading)
				vim.keymap.set("n", "<leader>pf", require("telescope").extensions.orgmode.search_headings)
				vim.keymap.set("n", "<leader>li", require("telescope").extensions.orgmode.insert_link)
			end,
		},
		{
			"shaunsingh/nord.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("nord")
			end,
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			-- Optional dependency
			dependencies = { "hrsh7th/nvim-cmp" },
			config = function()
				require("nvim-autopairs").setup({})
				-- If you want to automatically add `(` after selecting a function or method
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				local cmp = require("cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end,
		},
		{
			"saghen/blink.cmp",
			dependencies = {
				"rafamadriz/friendly-snippets",
				"L3MON4D3/LuaSnip", -- Required for snippet expansion
			},
			config = function()
				-- Configure blink.cmp first
				require("blink.cmp").setup({
					-- Your existing opts here
					keymap = { preset = "default" },
					appearance = {
						nerd_font_variant = "mono",
					},
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					-- ... rest of your blink.cmp opts ...
				})

				-- THEN add your custom snippets
				local ls = require("luasnip")
				local s = ls.snippet
				local t = ls.text_node

				ls.add_snippets("org", {
					s("src", {
						t("#+BEGIN_SRC "),
						t({ "", "" }),
						t("#+END_SRC"),
						t({ "", "" }),
					}),
					-- You can add more org-mode snippets here
				})
			end,
			build = function()
				local ok, _ = pcall(require, "cargo")
				if not ok then
					vim.notify("Installing Rust components for blink.cmp...", vim.log.levels.INFO)
					os.execute("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y")
					os.execute("source $HOME/.cargo/env && cargo build --release")
				end
			end,
			opts = {
				keymap = { preset = "default" },
				appearance = {
					nerd_font_variant = "mono",
				},
				snippet = {
					expand = function(args)
						-- Load LuaSnip for snippet expansion
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = { documentation = { auto_show = false } },
				sources = {
					name = "luasnip",
					per_filetype = {
						org = { "orgmode" },
					},
					providers = {
						orgmode = {
							name = "Orgmode",
							module = "orgmode.org.autocompletion.blink",
							fallbacks = { "buffer" },
						},
					},
				},
				-- ... your existing opts ...
				fuzzy = {
					implementation = "rust",
					prebuilt_binaries = {
						force_version = "0.7.1",
						fallback_to_lua = true,
					},
				},
			},
		},
	},
	-- mappings = {},
	checker = { enabled = true },
})
