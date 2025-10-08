if vim.g.vscode then
	return {}
end

return {
	"saghen/blink.cmp",
	event = { "BufReadPost", "BufNewFile" },
	version = "1.*",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		{ "xzbdmw/colorful-menu.nvim", opts = {} },
		{ "Kaiser-Yang/blink-cmp-avante" },
	},
	opts = {
		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				["<CR>"] = { "accept", "fallback" },
			},
			completion = {
				menu = { auto_show = true },
				ghost_text = { enabled = true },
			},
		},

		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-j>"] = { "select_next", "snippet_forward", "fallback" },
			["<C-k>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
		},

		completion = {
			accept = {
				auto_brackets = {
					enabled = false,
				},
			},
			list = {
				selection = {
					auto_insert = true,
				},
				cycle = {
					from_top = true,
					from_bottom = true,
				},
			},
			menu = {
				auto_show = true,
				border = "rounded",
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},
			-- ghost_text = { enabled = true },
			keyword = {
				range = "full",
			},
		},
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		sources = {
			default = { "avante", "lsp", "snippets", "buffer", "path" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
