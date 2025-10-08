if vim.g.vscode then
	return {}
end

local leet_arg = "lc"

return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- required by telescope
		"MunifTanjim/nui.nvim",

		-- optional
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},

	lazy = leet_arg ~= vim.fn.argv()[1],

	opts = {
		---@type string
		-- arg = "leetcode.nvim",
		arg = leet_arg,

		---@type lc.lang
		-- lang = "cpp",
		lang = "golang",
		-- lang = "java",

		cn = { -- leetcode.cn
			enabled = true, ---@type boolean
			translator = true, ---@type boolean
			translate_problems = true, ---@type boolean
		},

		---@type lc.storage
		storage = {
			home = vim.fn.stdpath("data") .. "/leetcode",
			cache = vim.fn.stdpath("cache") .. "/leetcode",
		},

		---@type boolean
		logging = true,

		injector = {
			["cpp"] = {
				before = { "#include <bits/stdc++.h>", "using namespace std;" },
				-- after = "int main() {}",
			},
			["golang"] = {
				before = "package main",
			},
		}, ---@type table<lc.lang, lc.inject>

		cache = {
			update_interval = 60 * 60 * 24 * 31, ---@type integer 31 days
		},

		console = {
			open_on_runcode = true, ---@type boolean

			dir = "row", ---@type lc.direction

			size = { ---@type lc.size
				width = "90%",
				height = "75%",
			},

			result = {
				size = "60%", ---@type lc.size
			},

			testcase = {
				virt_text = true, ---@type boolean

				size = "40%", ---@type lc.size
			},
		},

		description = {
			position = "left", ---@type lc.position

			width = "40%", ---@type lc.size

			show_stats = true, ---@type boolean
		},

		hooks = {
			---@type fun()[]
			LeetEnter = {},

			---@type fun(question: lc.ui.Question)[]
			LeetQuestionNew = {},
		},

		keys = {
			toggle = { "q", "<Esc>" }, ---@type string|string[]
			confirm = { "<CR>" }, ---@type string|string[]

			reset_testcases = "r", ---@type string
			use_testcase = "U", ---@type string
			focus_testcases = "H", ---@type string
			focus_result = "L", ---@type string
		},

		---@type boolean
		image_support = false, -- setting this to `true` will disable question description wrap
	},
}
