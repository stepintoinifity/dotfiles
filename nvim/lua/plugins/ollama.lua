if vim.g.vscode then
	return {}
end

local response_format = "Respond EXACTLY in this format:\n```$ftype\n<your code>\n```"
local prefix = "Please answer in chinese. "
return {
	"nomnivore/ollama.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	-- All the user commands added by the plugin
	cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

	keys = {
		-- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
		{
			"<leader>oo",
			":<c-u>lua require('ollama').prompt()<cr>",
			desc = "ollama prompt",
			mode = { "n", "v" },
		},

		-- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
		{
			"<leader>oG",
			":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
			desc = "ollama Generate Code",
			mode = { "n", "v" },
		},
	},

	opts = {
		-- your configuration overrides
		model = "qwen2.5-coder:7b",
		prompts = {
			Translate = {
				prompt = "Please transfer to chinese: \n$sel",
				input_label = "Q",
			},
			Ask_About_Code = {
				prompt = prefix .. "I have a question about this: $input\n\n Here is the code:\n```$ftype\n$sel```",
				input_label = "Q",
			},

			Explain_Code = {
				prompt = prefix .. "Explain this code:\n```$ftype\n$sel\n```",
			},

			-- basically "no prompt"
			Raw = {
				prompt = "$input",
				input_label = ">",
				action = "display",
			},

			Simplify_Code = {
				prompt = prefix
					.. "Simplify the following $ftype code so that it is both easier to read and understand. "
					.. response_format
					.. "\n\n```$ftype\n$sel```",
				action = "replace",
			},

			Modify_Code = {
				prompt = prefix
					.. "Modify this $ftype code in the following way: $input\n\n"
					.. response_format
					.. "\n\n```$ftype\n$sel```",
				action = "replace",
			},

			Generate_Code = {
				prompt = prefix .. "Generate $ftype code that does the following: $input\n\n" .. response_format,
				action = "insert",
			},
		},
	},
}
