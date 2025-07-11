-- MAKE SURE sudo pacman -S luarocks
return {
	"nvim-neorg/neorg",
	-- If not work run the command: Neorg sync-parsers
	build = ":Neorg sync-parsers",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neorg/lua-utils.nvim",
		"pysan3/pathlib.nvim",
		"nvim-neotest/nvim-nio",
	},
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	opts = {
		load = {
			["core.defaults"] = {},
			["core.concealer"] = {},
			["core.summary"] = {},
			["core.journal"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/Documents/neorg",
					},
					default_workspace = "notes",
				},
			},
		},
	},
}
