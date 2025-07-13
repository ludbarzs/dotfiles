-- If there are issues with the autopair: https://github.com/windwp/nvim-autopairs/issues/477
return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	opts = {
		-- :h ins-completion for default bindings
		--
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)

		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono", -- Nerd font
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = {
				auto_show = false,
			},
			-- IDK autopairs, if issues check here
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				jsx = { "eslint_d" },
				js = { "eslint_d" },
				ts = { "eslint_d" },
			},
		},

		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
