if vim.g.vscode then
	return {}
end

-- lsp
local lsp = {
	function()
		local msg = "No Active Lsp"
		local bufnr = vim.api.nvim_get_current_buf()
		local client = vim.lsp.get_clients({ bufnr = bufnr })
		if client and #client > 0 then
			return client[1].name
		end
		return msg
	end,
	icon = " LSP:",
}

-- Define a function to check the status and return the corresponding icon
local function get_status_icon()
	local status = require("ollama").status()

	if status == "IDLE" then
		return "OLLAMA IDLE"
	elseif status == "WORKING" then
		return "OLLAMA BUSY"
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "UIEnter",

	opts = {
		options = {
			theme = "auto",
			component_separators = "",
			-- section_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "alpha" },
			},
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{
					"mode",
					separator = { left = "", right = "" },
					right_padding = 2,
				},
			},
			lualine_b = {
				"branch",
				"diff",
				"diagnostics",
				"filename",
				get_status_icon,
			},
			lualine_c = {
				"%=", --[[ add your center compoentnts here in place of this comment ]]
			},
			lualine_x = {},
			lualine_y = { "filetype", lsp, "progress" },
			lualine_z = {
				{
					"location", --[[ separator = { right = "" }, ]]
					left_padding = 2,
				},
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		extensions = {},
	},
}
