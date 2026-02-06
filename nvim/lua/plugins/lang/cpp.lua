
return {
	{
		"williamboman/mason.nvim",
		enabled = not vim.g.vscode,
		event = "VeryLazy",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"clangd",
				"clang-format",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		enabled = not vim.g.vscode,
		optional = true,
		opts = {
			formatters_by_ft = {
				cpp = { "clang-format" },
				c = { "clang-format" },
			},
		},
	},
}
