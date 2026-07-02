-- If there are issues with the autopair: https://github.com/windwp/nvim-autopairs/issues/477
return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- REMOVED the duplicate lazydev block from here entirely
	},
	version = "1.*",
	opts = {
		-- :h ins-completion for default bindings
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono", -- Nerd font
		},
		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = {
				auto_show = true,
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
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			per_filetype = {
				jsx = { "prettier" },
				js = { "prettier" },
				ts = { "ts_ls" },
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
