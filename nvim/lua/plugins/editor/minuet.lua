return {
	"milanglacier/minuet-ai.nvim",
	-- enabled = not vim.g.vscode,
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local config = {
			provider = "openai",
			provider_options = {
				openai = {
					model = "gpt-5-mini",
					end_point = "https://api.openai.com/v1/chat/completions",
					api_key = "OPENAI_API_KEY",
					stream = true,
					optional = {
						max_completion_tokens = 128,
						reasoning_effort = "minimal",
					},
				},
			},
			throttle = 1500,
			debounce = 350,
			virtualtext = {
				auto_trigger_ft = { "*" },
				auto_trigger_ignore_ft = { "markdown", "gitcommit", "text" },
				keymap = {
					accept = "<A-y>",
					accept_line = "<A-l>",
					accept_n_lines = "<A-n>",
					next = "<A-]>",
					prev = "<A-[>",
					dismiss = "<A-e>",
				},
				show_on_completion_menu = false,
			},
		}

		require("minuet").setup(config)

		-- If FileType already fired before minuet loaded, enable auto-trigger for current buffer.
		if
			vim.bo.filetype ~= "" and not vim.tbl_contains(config.virtualtext.auto_trigger_ignore_ft, vim.bo.filetype)
		then
			vim.b.minuet_virtual_text_auto_trigger = true
		end
	end,
}
