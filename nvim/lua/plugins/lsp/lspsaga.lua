return {
	"nvimdev/lspsaga.nvim",
	enabled = not vim.g.vscode,
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
	opts = {
		code_action = { show_preview = true },
	},
	keys = {
		{
			"<F7>",
			mode = { "n", "t" },
			"<cmd>Lspsaga term_toggle<CR>",
			desc = "Float term",
		},
		{
			"<leader>lo",
			"<cmd>Lspsaga outline<CR>",
			desc = "Outline",
		},
	},
}
