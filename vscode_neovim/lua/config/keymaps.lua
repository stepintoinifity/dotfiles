vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

local mappings = {
    {"n", "<leader>w", "workbench.action.files.save"},

    {"n", "w", "cursorWordPartRight"},
    {"n", "b", "cursorWordPartLeft"},
    {"v", "w", "cursorWordPartRightSelect"},
    {"v", "b", "cursorWordPartLeftSelect"},

    {"n", "gr", "editor.action.goToReferences"},
    {"n", "gt", "editor.action.goToTypeDefinition"},
    {"n", "gi", "editor.action.goToImplementation"},
    {"n", "gs", "workbench.action.gotoSymbol"},

    {"n", "<leader>lo", "workbench.action.showAllSymbols"},
    {"n", "<leader>ff", "workbench.action.quickOpen"},
    {"n", "<leader>fw", "actions.find"},
    {"n", "<leader>fW", "workbench.action.findInFiles"},
    {"n", "<leader>rn", "editor.action.rename"},
    {"n", "<leader>rf", "editor.action.refactor"},
    {"n", "<leader>qf", "editor.action.quickFix"},
    {"n", "<leader>ts", "editor.action.triggerSuggest"},

}

local vscode = require("vscode")

for _, mapping in ipairs(mappings) do
    local mode, lhs, rhs = unpack(mapping)
    vim.keymap.set(mode, lhs,function() vscode.action(rhs) end, opts)
end
