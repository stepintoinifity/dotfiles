if vim.g.vscode then
	return {}
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		ft = "go",
		opts = {
			servers = {
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					-- root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
					single_file_support = true,
					settings = {
						gopls = {
							analyses = {
								ST1003 = true,
								fieldalignment = false,
								fillreturns = true,
								nilness = true,
								nonewvars = true,
								shadow = true,
								undeclaredname = true,
								unreachable = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							codelenses = {
								gc_details = true, -- Show a code lens toggling the display of gc's choices.
								generate = true, -- show the `go generate` lens.
								regenerate_cgo = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							buildFlags = { "-tags", "integration" },
							completeUnimported = true,
							diagnosticsDelay = "200ms",
							matcher = "Fuzzy",
							semanticTokens = true,
							staticcheck = true,
							symbolMatcher = "fuzzy",
							usePlaceholders = true,
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
				"gopls",
				"gofumpt",
				"golines",
				"goimports",
				"goimports-reviser",
				"delve",
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				go = {
					"golines",
					-- "goimports",
					"goimports-reviser",
					-- "gofumpt",
				},
			},
			formatters = {
				["goimports-reviser"] = { prepend_args = { "-format" } },
				golines = { prepend_args = { "--max-len=200" } },
			},
		},
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		keys = {
			{ "<leader>gct", "<cmd>GoCmt<cr>", desc = "Go Function Comment" },
			{ "<leader>gat", "<cmd>GoAddTag<cr>", desc = "Go Add Tag" },
			{ "<leader>grt", "<cmd>GoRmTag<cr>", desc = "Go Rm Tag" },
			{ "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Go Fill Struct" },
			{ "<leader>gfS", "<cmd>GoFillSwitch<cr>", desc = "Go Fill Switch" },
			{ "<leader>gie", "<cmd>GoIfErr<cr>", desc = "Go If Err" },
			{ "<leader>gfp", "<cmd>GoFixPlurals<cr>", desc = "Go Fix Plurals" },
		},
	},
}
