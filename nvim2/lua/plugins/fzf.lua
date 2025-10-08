return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {},
	keys = {
		-- files
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find Files in project directory",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "Find history",
		},
		-- buffer
		{
			"<leader>fb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Find buffers",
		},
		-- word
		{
			"<leader>fw",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Find words",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "Find words current buf",
		},

		{
			"<leader>fc",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "Find word under cursor",
		},
		-- lsp
		{
			"<leader>fl",
			function()
				require("fzf-lua").lsp_live_workspace_symbols()
			end,
			desc = "Find symbols in workspace",
		},
		{
			"<leader>fL",
			function()
				require("fzf-lua").lsp_document_symbols()
			end,
			desc = "Find symbols of current buf",
		},
		-- resume
		{
			"<leader>f<CR>",
			function()
				require("fzf-lua").resume()
			end,
			desc = "Find resume",
		},
	},
}
