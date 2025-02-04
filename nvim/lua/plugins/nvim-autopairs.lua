return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			disable_filetype = { "TelescopePrompt", "vim" },
			enable_check_bracket_line = false,
			ignored_next_char = "[%w%.]", -- Ignore alphanumeric and dot
			fast_wrap = {},
		})

		-- Remove pairing rules for " and '
		npairs.remove_rule('"')
		npairs.remove_rule("'")
	end,
}
