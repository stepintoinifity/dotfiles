if vim.g.vscode then
	return {}
end

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"bash-language-server",
				"shfmt",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				sh = { "shfmt" },
			},
		},
	},
}
