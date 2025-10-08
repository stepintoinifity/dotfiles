if vim.g.vscode then
	return {}
end

return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			-- style_preset = require("bufferline").style_preset.default, -- or bufferline.style_preset.minimal,
			themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
			-- numbers = "buffer_id",
			close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
			right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
			left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
			middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				-- style = 'icon' | 'underline' | 'none',
				style = "icon",
			},
			buffer_close_icon = "󰅖",
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = " ",
			right_trunc_marker = " ",
			--- Please note some names can/will break the
			--- bufferline so use this at your discretion knowing that it has
			--- some limitations that will *NOT* be fixed.
			max_name_length = 18,
			max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
			truncate_names = true, -- whether or not tab names should be truncated
			-- tab_size = 18,
			-- NOTE: this will be called a lot so don't do any heavy processing here
			color_icons = true, -- whether or not to add the filetype icon highlights
			show_buffer_icons = true, -- disable filetype icons for buffers
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = false,
			show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
			duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
			-- can also be a table containing 2 custom separators
			-- [focused and unfocused]. eg: { '|', '|' }
			-- separator_style = "slant" | "slope" | "thick" | "thin" | { "any", "any" },
			separator_style = "thin",
			enforce_regular_tabs = false,
			always_show_bufferline = false,
			auto_toggle_bufferline = true,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
		},
	},

	keys = {
		{
			"<leader>bc",
			function()
				vim.cmd("bdelete! %")
			end,
			desc = "Close Current Buffer",
		},
		{
			"<leader>ba",
			function()
				vim.cmd("BufferLineCloseOthers")
				vim.cmd("bdelete! %")
			end,
			desc = "Close All Buffers",
		},
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left Buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Buffers" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Others Buffers" },
		{ "<leader>bb", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
	},
}
