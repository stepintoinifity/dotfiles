if not vim.g.vscode then
	return
end

vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true

local opts = { noremap = true, silent = true }

local mappings = {
	{ "n", "<leader>w", "workbench.action.files.save" },
	{ "n", "<leader>q", "workbench.action.closeActiveEditor" },

	{ "n", "w", "cursorWordPartRight" },
	{ "n", "b", "cursorWordPartLeft" },
	{ "v", "w", "cursorWordPartRightSelect" },
	{ "v", "b", "cursorWordPartLeftSelect" },

	{ "n", "gr", "editor.action.goToReferences" },
	{ "n", "gt", "editor.action.goToTypeDefinition" },
	{ "n", "gi", "editor.action.goToImplementation" },

	{ "n", "[d", "editor.action.marker.prev" },
	{ "n", "]d", "editor.action.marker.next" },

	{ "n", "<leader>ca", "editor.action.codeAction" },
	{ "n", "<leader>gp", "workbench.action.showCommands" },
	{ "n", "<leader>fl", "workbench.action.showAllSymbols" },
	{ "n", "<leader>lo", "workbench.action.gotoSymbol" },
	{ "n", "<leader>ff", "workbench.action.quickOpen" },
	{ "n", "<leader>fb", "workbench.action.showEditorsInActiveGroup" },
	{ "n", "<leader>fw", "actions.find" },
	{ "n", "<leader>fW", "workbench.action.findInFiles" },
	{ "n", "<leader>rn", "editor.action.rename" },
	{ "n", "<leader>rf", "editor.action.refactor" },
	{ "n", "<leader>qf", "editor.action.quickFix" },
	{ "n", "<leader>ts", "editor.action.triggerSuggest" },

	{ "n", "<cr>", "editor.action.insertLineAfter" },
	{ "n", "<leader><cr>", "editor.action.insertLineBefore" },
}

local vscode = require("vscode")

for _, mapping in ipairs(mappings) do
	local mode, lhs, rhs = unpack(mapping)
	vim.keymap.set(mode, lhs, function()
		vscode.action(rhs)
	end, opts)
end
