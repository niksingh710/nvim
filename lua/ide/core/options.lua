local opts = {
	laststatus = 2, -- global statusline

	clipboard = "unnamedplus",
	cursorline = true,
	cmdwinheight = 1,
	cmdheight = 0,

	-- Indenting
	expandtab = true,
	shiftwidth = 2,
	smartindent = true,
	tabstop = 2,
	softtabstop = 2,

	ignorecase = true,
	smartcase = true,
	mouse = "a",

	-- Numbers
	number = true,
	numberwidth = 2,
	relativenumber = true,
	ruler = false,

	-- disable nvim intro

	signcolumn = "yes",
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 400,
	undofile = true,

	-- enable list icons
	list = true,

	-- winwidth for windows nvim
	winwidth = 10,
	winminwidth = 10,
	equalalways = false,

	-- fold nvim-ufo
	foldcolumn = "1", -- '0' is not bad
	foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
	foldlevelstart = 99,
	foldenable = true,
	foldmethod = "marker",
	-- interval for writing swap file to disk, also used by gitsigns
	updatetime = 250,
}

vim.opt.whichwrap:append("<>[]hl")
vim.opt.fillchars = { eob = " " }
vim.opt.shortmess:append("sI")
vim.g.mapleader = " "

for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.opt.wildcharm = ("\t"):byte() -- so that tab key can be remapped

vim.opt.listchars:append("space:·")
vim.opt.fillchars:append("fold:•")

vim.g.floating_window_options = {
	border = config.border or "rounded",
	winblend = 10,
}
