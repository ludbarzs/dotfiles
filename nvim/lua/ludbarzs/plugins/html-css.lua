return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true, -- Automatically loads when required by blink.cmp
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" }, -- Optional snippet support
		version = "*", -- Use a release tag to get pre-built binaries
		opts = {
			keymap = { preset = "default" },
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "html-css" },
				providers = {
					["html-css"] = {
						name = "html-css",
						module = "blink.compat.source",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
