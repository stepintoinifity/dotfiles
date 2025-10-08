if vim.g.vscode then
	return {}
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = true,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function()
					return {
						RainbowRed = { fg = "#E06C75" },
						RainbowYellow = { fg = "#E5C07B" },
						RainbowBlue = { fg = "#61AFEF" },
						RainbowOrange = { fg = "#D19A66" },
						RainbowGreen = { fg = "#98C379" },
						RainbowViolet = { fg = "#C678DD" },
						RainbowCyan = { fg = "#56B6C2" },
					}
				end,
				flavour = "mocha",
				-- flavour = "frappe",
				-- flavour = "macchiato",
				-- background = {
				-- 	light = "latte",
				-- 	-- dark = "mocha",
				-- },
				transparent_background = true,
				-- show_end_of_buffer = true,
				integrations = {
					telescope = {
						enabled = true,
					},
					flash = true,
					noice = true,
					notify = true,
					which_key = true,
					gitsigns = true,
					mason = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		-- lazy = true,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			-- vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_cursor = "yellow"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = true,
		config = function()
			-- require("tokyonight").setup({
			-- 	transparent = true,
			-- 	styles = {
			-- 		slidebars = "transparent",
			-- 		floats = "transparent",
			-- 	},
			-- })
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
