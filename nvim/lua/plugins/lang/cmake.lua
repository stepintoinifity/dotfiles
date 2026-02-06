return {
	{
		"williamboman/mason.nvim",
		enabled = not vim.g.vscode,
		event = "VeryLazy",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"cmakelang",
				"cmakelint",
				"neocmakelsp",
			})
		end,
	},
}
