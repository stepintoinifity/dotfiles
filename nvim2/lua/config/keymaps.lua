vim.g.mapleader = " "

local nvim = 1
local vscode = 2
local both = 3

local mappings = {
	{
		from = "J",
		to = "<Nop>",
		option = { noremap = true, silent = true },
		type = both,
	},
	{
		from = "gh",
		to = "<Nop>",
		option = { noremap = true, silent = true },
		type = both,
	},
	-- Normal or Visual mode
	{
		from = "jk",
		to = "<ESC>",
		mode = "i",
		type = nvim,
	},
	{
		from = "<S-h>",
		to = "^",
		mode = { "n", "x", "o" },
		option = { desc = "Start of line" },
		type = both,
	},
	{
		from = "<S-l>",
		to = "$",
		mode = { "n", "x", "o" },
		option = { desc = "End of line" },
		type = both,
	},
	-- { from = "v", to = "<Esc>", mode = "v" },

	-- Save or quit
	{
		from = "<leader>w",
		to = function()
			vim.cmd("confirm w")
		end,
		option = { desc = "Save" },
		type = both,
	},
	{
		from = "<leader>q",
		to = "<Cmd>confirm q<Cr>",
		-- to = function()
		--     vim.cmd("confirm q")
		-- end,
		option = { desc = "Quit" },
		type = nvim,
	},

	-- Select all
	{
		from = "<C-a>",
		to = "ggVG",
		option = { desc = "Select all" },
		type = both,
	},

	-- No highlight
	{
		from = "<leader>nh",
		to = function()
			vim.cmd("nohl")
		end,
		option = { desc = "No highlight" },
		type = both,
	},

	-- Switch buffer
	{
		from = "[b",
		to = function()
			vim.cmd("bprev")
		end,
		option = { desc = "Prev buf" },
		type = nvim,
	},
	{
		from = "]b",
		to = function()
			vim.cmd("bnext")
		end,
		option = { desc = "Next buf" },
		type = nvim,
	},

	-- Split window
	{
		from = "<leader>sv",
		to = "<C-w>v",
		option = { desc = "Split vertical" },
		type = nvim,
	},
	{
		from = "<leader>sh",
		to = "<C-w>s",
		option = { desc = "Split horizon" },
		type = nvim,
	},
	{
		from = "<leader>se",
		to = "<C-w>=",
		option = { desc = "Split equation" },
		type = nvim,
	},
	{
		from = "<leader>sx",
		to = "<Cmd>close<Cr>",
		option = { desc = "Close splited window" },
		type = nvim,
	},

	-- Move focus
	{
		from = "<C-h>",
		to = "<C-w>h",
		type = nvim,
	},
	{
		from = "<C-j>",
		to = "<C-w>j",
		type = nvim,
	},
	{
		from = "<C-k>",
		to = "<C-w>k",
		type = nvim,
	},
	{
		from = "<C-l>",
		to = "<C-w>l",
		type = nvim,
	},

	-- Insert Move
	{
		from = "<C-h>",
		to = "<Left>",
		mode = "i",
		type = nvim,
	},
	{
		from = "<C-j>",
		to = "<Down>",
		mode = "i",
		type = nvim,
	},
	{
		from = "<C-k>",
		to = "<Up>",
		mode = "i",
		type = nvim,
	},
	{
		from = "<C-l>",
		to = "<Right>",
		mode = "i",
		type = nvim,
	},

	-- Move faster
	{
		from = "(",
		to = "4k",
		type = both,
	},
	{
		from = ")",
		to = "4j",
		type = both,
	},
	{
		from = "(",
		to = "4k",
		mode = "v",
		type = both,
	},
	{
		from = ")",
		to = "4j",
		mode = "v",
		type = both,
	},

	-- J, K
	{
		from = "j",
		to = [[v:count ? 'j' : "gj"]],
		option = { noremap = true, expr = true },
		type = both,
	},
	{
		from = "k",
		to = [[v:count ? 'k' : "gk"]],
		option = { noremap = true, expr = true },
		type = both,
	},

	-- Move line
	{
		from = "<A-j>",
		to = function()
			vim.cmd("m+1")
		end,
		type = nvim,
	},
	{
		from = "<A-k>",
		to = function()
			vim.cmd("m-2")
		end,
	},
	{
		from = "<A-j>",
		to = ":m '>+1<Cr>gv=gv",
		mode = "v",
		type = nvim,
	},
	{
		from = "<A-k>",
		to = ":m '<-2<Cr>gv=gv",
		mode = "v",
		type = nvim,
	},

	-- Resize window
	{
		from = "<C-Left>",
		to = "<C-w>>",
		type = nvim,
	},
	{
		from = "<C-Right>",
		to = "<C-w><",
		type = nvim,
	},
	{
		from = "<C-Up>",
		to = "<C-w>+",
		type = nvim,
	},
	{
		from = "<C-Down>",
		to = "<C-w>-",
		type = nvim,
	},

	-- Normal /n
	{
		from = "<CR>",
		to = "o<Esc>",
		type = nvim,
	},
	{
		from = "<S-CR>",
		to = "O<Esc>",
		type = nvim,
	},

	-- Lsp Info
	{
		from = "<leader>li",
		to = "<cmd>LspInfo<Cr>",
		type = nvim,
	},

	-- Lazy
	-- {
	-- 	from = "<leader>L",
	-- 	to = ":Lazy<Cr>",
	-- 	type = nvim,
	-- },

	-- LeetCode
	{
		from = "<leader>Lt",
		to = function()
			vim.cmd("Leet test")
		end,
		type = nvim,
	},
	{
		from = "<leader>Ls",
		to = function()
			vim.cmd("Leet submit")
		end,
		type = nvim,
	},
	{
		from = "<leader>Ld",
		to = function()
			vim.cmd("Leet desc")
		end,
		type = nvim,
	},

	-- just vscode
	-- code action
	{
		from = "<leader>ca",
		to = function()
			local code = require("vscode")
			code.action("editor.action.codeAction")
		end,
		mode = "n",
		type = vscode,
	},
	-- rename
	{
		from = "<leader>rn",
		to = function()
			local code = require("vscode")
			code.action("editor.action.rename")
		end,
		mode = "n",
		type = vscode,
	},
	-- split editor vertically
	{
		from = "<leader>sv",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.splitEditor")
		end,
		mode = "n",
		type = vscode,
	},
	-- split editor horizontally
	{
		from = "<leader>sh",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.splitEditorDown")
		end,
		mode = "n",
		type = vscode,
	},
	-- toggle max editor group
	{
		from = "<leader>sm",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.toggleMaximizeEditorGroup")
		end,
		mode = "n",
		type = vscode,
	},
	-- close editor group
	{
		from = "<leader>sc",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.closeEditorsInGroup")
		end,
		mode = "n",
		type = vscode,
	},
	-- close editor
	{
		from = "<leader>q",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.closeActiveEditor")
		end,
		mode = "n",
		type = vscode,
	},
	-- close other editor
	{
		from = "<leader>bo",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.closeOtherEditors")
		end,
		mode = "n",
		type = vscode,
	},
	-- close all editor
	{
		from = "<leader>ba",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.closeAllEditors")
		end,
		mode = "n",
		type = vscode,
	},
	-- next editor
	{
		from = "]b",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.nextEditor")
		end,
		mode = "n",
		type = vscode,
	},
	-- previous editor
	{
		from = "[b",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.previousEditor")
		end,
		mode = "n",
		type = vscode,
	},
	-- next diagnostic
	{
		from = "]d",
		to = function()
			local code = require("vscode")
			code.action("editor.action.marker.next")
		end,
		mode = "n",
		type = vscode,
	},
	-- previous diagnostic
	{
		from = "[d",
		to = function()
			local code = require("vscode")
			code.action("editor.action.marker.prev")
		end,
		mode = "n",
		type = vscode,
	},
	-- find file
	{
		from = "<leader>ff",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.quickOpen")
		end,
		mode = "n",
		type = vscode,
	},
	-- find buffer
	{
		from = "<leader>fb",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.showEditorsInActiveGroup")
		end,
		mode = "n",
		type = vscode,
	},
	-- find lsp symbol
	{
		from = "<leader>fl",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.showAllSymbols")
		end,
		mode = "n",
		type = vscode,
	},
	-- list outline
	{
		from = "<leader>lo",
		to = function()
			local code = require("vscode")
			code.action("workbench.action.gotoSymbol")
		end,
		mode = "n",
		type = vscode,
	},
	-- yazi
	{
		from = "<leader>y",
		to = function()
			local code = require("vscode")
			code.action("yazi-vscode.toggle")
		end,
		mode = "n",
		type = vscode,
	},
}

local option = {
	noremap = true,
	silent = true,
}

local real_type = vim.g.vscode and vscode or nvim

for _, mapping in ipairs(mappings) do
	if mapping.type == both then
		vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, mapping.option or option)
	else
		if mapping.type == real_type then
			vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, mapping.option or option)
		end
	end
end
