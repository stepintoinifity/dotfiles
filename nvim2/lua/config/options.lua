if vim.g.vscode then
	return {}
end

vim.g.maplocalleader = ","

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.clipboard = "unnamedplus"

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true

opt.cursorline = true

opt.termguicolors = true

opt.scrolloff = 16

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"

opt.showmode = false

opt.mouse = "a"

opt.splitbelow = true
opt.splitright = true

-- opt.colorcolumn = "100"

opt.swapfile = false

opt.backspace = "indent,eol,start"

local o = vim.o
o.cmdheight = 0
