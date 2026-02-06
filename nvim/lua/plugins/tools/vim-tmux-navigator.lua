return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	enabled = not vim.g.vscode,
	event = { "BufReadPre", "BufNewFile" },
}
