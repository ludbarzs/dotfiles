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
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Custom keymaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Open :Ex

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
	},
	-- mappings = {},
	checker = { enabled = true },
})
