return {
	"tpope/vim-fugitive",
	  keys = { -- load the plugin only when using it's keybinding:
	    { "<leader>gs", "<cmd>Git<cr>", desc = "[G]it [S]tatus" },
	    { "<leader>gc", "<cmd>Git commit<cr>", desc = "[G]it [C]ommit" },
	    { "<leader>gp", "<cmd>Git push<cr>", desc = "[G]it [P]ush" },
	  },

}
