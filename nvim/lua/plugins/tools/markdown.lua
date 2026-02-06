return {
	"MeanderingProgrammer/render-markdown.nvim",
	enabled = not vim.g.vscode,
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = {
			blink = { enabled = true },
		},
		sign = { enabled = false },
		blink = { enabled = true },
		heading = { position = "inline", icons = { "󰼏 ", "󰎨 " } },
	},
}
