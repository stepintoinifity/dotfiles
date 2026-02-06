if vim.g.vscode then
	return
end

vim.g.mapleader = " "

local mappings = {
	{
		from = "J",
		to = "<Nop>",
		option = { noremap = true, silent = true },
	},
	{
		from = "gh",
		to = "<Nop>",
		option = { noremap = true, silent = true },
	},
	-- Normal or Visual mode
	{
		from = "jk",
		to = "<ESC>",
		mode = "i",
	},
	{
		from = "<S-h>",
		to = "^",
		mode = { "n", "x", "o" },
		option = { desc = "Start of line" },
	},
	{
		from = "<S-l>",
		to = "$",
		mode = { "n", "x", "o" },
		option = { desc = "End of line" },
	},
	-- { from = "v", to = "<Esc>", mode = "v" },

	-- Save or quit
	{
		from = "<leader>w",
		to = function()
			vim.cmd("confirm w")
		end,
		option = { desc = "Save" },
	},
	{
		from = "<leader>q",
		to = "<Cmd>confirm q<Cr>",
		-- to = function()
		--     vim.cmd("confirm q")
		-- end,
		option = { desc = "Quit" },
	},

	-- Select all
	{
		from = "<C-a>",
		to = "ggVG",
		option = { desc = "Select all" },
	},

	-- No highlight
	{
		from = "<leader>nh",
		to = function()
			vim.cmd("nohl")
		end,
		option = { desc = "No highlight" },
	},

	-- Switch buffer
	{
		from = "[b",
		to = function()
			vim.cmd("bprev")
		end,
		option = { desc = "Prev buf" },
	},
	{
		from = "]b",
		to = function()
			vim.cmd("bnext")
		end,
		option = { desc = "Next buf" },
	},

	-- Split window
	{
		from = "<leader>sv",
		to = "<C-w>v",
		option = { desc = "Split vertical" },
	},
	{
		from = "<leader>sh",
		to = "<C-w>s",
		option = { desc = "Split horizon" },
	},
	{
		from = "<leader>se",
		to = "<C-w>=",
		option = { desc = "Split equation" },
	},
	{
		from = "<leader>sx",
		to = "<Cmd>close<Cr>",
		option = { desc = "Close splited window" },
	},

	-- Move focus
	{
		from = "<C-h>",
		to = "<C-w>h",
	},
	{
		from = "<C-j>",
		to = "<C-w>j",
	},
	{
		from = "<C-k>",
		to = "<C-w>k",
	},
	{
		from = "<C-l>",
		to = "<C-w>l",
	},

	-- Insert Move
	{
		from = "<C-h>",
		to = "<Left>",
		mode = "i",
	},
	{
		from = "<C-j>",
		to = "<Down>",
		mode = "i",
	},
	{
		from = "<C-k>",
		to = "<Up>",
		mode = "i",
	},
	{
		from = "<C-l>",
		to = "<Right>",
		mode = "i",
	},

	-- Move faster
	{
		from = "(",
		to = "4k",
	},
	{
		from = ")",
		to = "4j",
	},
	{
		from = "(",
		to = "4k",
		mode = "v",
	},
	{
		from = ")",
		to = "4j",
		mode = "v",
	},

	-- J, K
	{
		from = "j",
		to = [[v:count ? 'j' : "gj"]],
		option = { noremap = true, expr = true },
	},
	{
		from = "k",
		to = [[v:count ? 'k' : "gk"]],
		option = { noremap = true, expr = true },
	},

	-- Move line
	{
		from = "<A-j>",
		to = function()
			vim.cmd("m+1")
		end,
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
	},
	{
		from = "<A-k>",
		to = ":m '<-2<Cr>gv=gv",
		mode = "v",
	},

	-- Resize window
	{
		from = "<C-Left>",
		to = "<C-w>>",
	},
	{
		from = "<C-Right>",
		to = "<C-w><",
	},
	{
		from = "<C-Up>",
		to = "<C-w>+",
	},
	{
		from = "<C-Down>",
		to = "<C-w>-",
	},

	-- Normal /n
	{
		from = "<CR>",
		to = "o<Esc>",
	},
	{
		from = "<S-CR>",
		to = "O<Esc>",
	},

	-- Lsp Info
	{
		from = "<leader>li",
		to = "<cmd>LspInfo<Cr>",
	},

	-- Lazy
	-- {
	-- 	from = "<leader>L",
	-- 	to = ":Lazy<Cr>",
	-- },

	-- LeetCode
	{
		from = "<leader>Lt",
		to = function()
			vim.cmd("Leet test")
		end,
	},
	{
		from = "<leader>Ls",
		to = function()
			vim.cmd("Leet submit")
		end,
	},
	{
		from = "<leader>Ld",
		to = function()
			vim.cmd("Leet desc")
		end,
	},
}

local option = {
	noremap = true,
	silent = true,
}

for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, mapping.option or option)
end
