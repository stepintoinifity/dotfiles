
return {
	"folke/persistence.nvim",
	enabled = not vim.g.vscode,
	event = "BufReadPre",
	opts = {
		dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
	},
}
