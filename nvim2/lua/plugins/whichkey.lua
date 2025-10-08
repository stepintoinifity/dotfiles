if vim.g.vscode then
	return {}
end

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		defaults = {},
		-- spec = {
		-- 	{
		-- 		mode = { "n", "v" },
		-- 		{ "<leader><tab>", group = "tabs" },
		-- 		{ "<leader>c", group = "code" },
		-- 		{ "<leader>f", group = "file/find" },
		-- 		{ "<leader>l", group = "[l]sp [l]spsaga" },
		-- 		{ "<leader>L", group = "[L]eetcode" },
		-- 		{ "<leader>g", group = "git" },
		-- 		{ "<leader>gh", group = "hunks" },
		-- 		{ "<leader>p", group = "parameters" },
		-- 		{ "<leader>q", group = "quit/session" },
		-- 		{ "<leader>i", group = "[i]nlay hint" },
		-- 		{ "<leader>r", group = "[R]ename/start" },
		-- 		{ "<leader>s", group = "split window" },
		-- 		{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
		-- 		{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
		-- 		{ "[", group = "prev" },
		-- 		{ "]", group = "next" },
		-- 		{ "g", group = "goto" },
		-- 		{ "z", group = "fold" },
		-- 		{
		-- 			"<leader>b",
		-- 			group = "buffer",
		-- 			expand = function()
		-- 				return require("which-key.extras").expand.buf()
		-- 			end,
		-- 		},
		-- 		-- better descriptions
		-- 		{ "gx", desc = "Open with system app" },
		-- 	},
		-- },
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
	},
}
