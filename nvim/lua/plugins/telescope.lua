if vim.g.vscode then
	return {}
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
				build = "make",
			},
		},
		lazy = true,
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<Cmd>Telescope find_files<CR>", "n", desc = "Find files" },
			{ "<leader>fw", "<Cmd>Telescope live_grep<CR>", "n", desc = "Find words" },
			{
				"<leader>fW",
				"<Cmd>Telescope current_buffer_fuzzy_find<CR>",
				"n",
				desc = "Find words current buf",
			},
			{ "<leader>fr", "<Cmd>Telescope oldfiles<CR>", "n", desc = "Find history" },
			{ "<leader>fc", "<Cmd>Telescope grep_string<CR>", "n", desc = "Find word under cursor" },
			{ "<leader>fb", "<Cmd>Telescope buffers<CR>", "n", desc = "Find buffers" },
			{ "<leader>fm", "<Cmd>Telescope man_pages<CR>", "n", desc = "Find man" },
			{ "<leader>fk", "<Cmd>Telescope keymaps<CR>", "n", desc = "Find keymaps" },
			{
				"<leader>fl",
				"<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
				"n",
				desc = "Dynamically search symbols in workspace",
			},
			{ "<leader>fL", "<Cmd>Telescope lsp_document_symbols<CR>", "n", desc = "Search symbols" },
			{ "<leader>f<CR>", "<Cmd>Telescope resume<CR>", "n", desc = "Resume previous search" },
			-- { "<leader>fn", "<Cmd>Noice telescope<CR>", "n", desc = "Noice message history" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55 },
						vertical = { mirror = false },
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},

					prompt_prefix = " ",
					selection_caret = " ",

					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
						n = {
							["q"] = actions.close,
						},
					},
				},
				extensions = {
					fzf = {},
				},
			})

			telescope.load_extension("fzf")
			-- telescope.load_extension("noice")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		lazy = true,
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
