if not vim.g.vscode then
	return {}
end

local enabled = {
	"lazy",
	"flash",
	"mini.pairs",
	"mini.surround",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
}

for _, plugin in ipairs(enabled) do
	require(plugin)
end

return {}
