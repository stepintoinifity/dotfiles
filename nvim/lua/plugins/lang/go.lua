return {
	{
		"williamboman/mason.nvim",
		enabled = not vim.g.vscode,
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
		enabled = not vim.g.vscode,
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
		enabled = not vim.g.vscode,
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
			{ "<leader>ga", "<cmd>GoAlt<cr>", desc = "Go Alt (test/source)" },
			{ "<leader>gA", "<cmd>GoAltV<cr>", desc = "Go Alt Vertical" },
			{ "<leader>gr", "<cmd>GoRun<cr>", desc = "Go Run" },
			{ "<leader>gt", "<cmd>GoTestFunc<cr>", desc = "Go Test Func" },
			{ "<leader>gT", "<cmd>GoTest<cr>", desc = "Go Test All" },
			{ "<leader>gF", "<cmd>GoTestFile<cr>", desc = "Go Test File" },
			{ "<leader>gP", "<cmd>GoTestPkg<cr>", desc = "Go Test Pkg" },
		},
	},
}
