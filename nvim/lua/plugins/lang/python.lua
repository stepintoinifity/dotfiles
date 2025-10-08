if vim.g.vscode then
	return {}
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		ft = "py",
		opts = {
			servers = {
				pyright = {
					filetypes = { "python" },
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "basic",
								autoImportCompletions = true,
								stubPath = vim.env.HOME .. "/typings",
								diagnosticSeverityOverrides = {
									reportUnusedImport = "information",
									reportUnusedFunction = "information",
									reportUnusedVariable = "information",
									reportGeneralTypeIssues = "none",
									reportOptionalMemberAccess = "none",
									reportOptionalSubscript = "none",
									reportPrivateImportUsage = "none",
								},
							},
						},
					},
				},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"pyright",
				"isort",
				"black",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				python = { "isort", "black" },
			},
		},
	},
}
