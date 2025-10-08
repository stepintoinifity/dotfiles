if vim.g.vscode then
	return {}
end

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				neocmake = {
					cmd = { "neocmakelsp", "--stdio" },
					filetypes = { "cmake" },
					single_file_support = true, -- suggested
					init_options = {
						format = {
							enable = true,
						},
						lint = {
							enable = true,
						},
						scan_cmake_in_package = true, -- default is true
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
				"cmakelang",
				"cmakelint",
				"neocmakelsp",
			})
		end,
	},
}
