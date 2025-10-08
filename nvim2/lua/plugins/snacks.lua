if vim.g.vscode then
	return {}
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = {
			duration = 20, -- ms per step
			easing = "easing",
			fps = 60, -- frames per second. Global setting for all animations
		},
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				header = [[
   ██   ██ ███████ ██      ██       ██████  
   ██   ██ ██      ██      ██      ██    ██ 
   ███████ █████   ██      ██      ██    ██ 
   ██   ██ ██      ██      ██      ██    ██ 
   ██   ██ ███████ ███████ ███████  ██████  
                                            
  ██     ██  ██████  ██████  ██      ██████ 
  ██     ██ ██    ██ ██   ██ ██      ██   ██
  ██  █  ██ ██    ██ ██████  ██      ██   ██
  ██ ███ ██ ██    ██ ██   ██ ██      ██   ██
   ███ ███   ██████  ██   ██ ███████ ██████ 
            ]],
			},
		},
		indent = {
			enabled = true,
			scope = {
				enabled = true,
				hl = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			},
		},
		dim = { enabled = true },
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			---@diagnostic disable: missing-fields
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
		terminal = { enabled = false },
	},
	keys = {
		{
			"<leader>z",
			function()
				require("snacks").zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				require("snacks").zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				require("snacks").scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				require("snacks").scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				require("snacks").notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				require("snacks").bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				require("snacks").rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gB",
			function()
				require("snacks").gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gb",
			function()
				require("snacks").git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>gf",
			function()
				require("snacks").lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>gg",
			function()
				require("snacks").lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				require("snacks").lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>un",
			function()
				require("snacks").notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"]]",
			function()
				require("snacks").words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				require("snacks").words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				require("snacks").win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				local snacks = require("snacks")
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					snacks.debug.inspect(...)
				end
				_G.bt = function()
					snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				snacks.toggle.diagnostics():map("<leader>ud")
				snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				snacks.toggle.treesitter():map("<leader>uT")
				snacks.toggle.inlay_hints():map("<leader>uh")
				snacks.toggle.indent():map("<leader>ug")
				snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
