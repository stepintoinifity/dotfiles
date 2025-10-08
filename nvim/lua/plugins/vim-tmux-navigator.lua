if vim.g.vscode then
	return {}
end

return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	event = { "BufReadPre", "BufNewFile" },
}
