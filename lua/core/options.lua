local opt = vim.opt
local o = vim.o
local g = vim.g

g.mapleader = " "

-- Clipboard sync with System
opt.clipboard = "unnamedplus"
opt.cursorline = true
opt.cursorlineopt = "number"

-- disabling the startup screen
opt.shortmess:append("sI")
vim.go.statusline = '%#Normal#'

opt.pumblend = 0
opt.pumheight = 10

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2


opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.cmdheight = 0

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.termguicolors = true
opt.timeoutlen = 400

opt.undofile = true

opt.wrap = false

opt.pumblend = 0
opt.pumheight = 10

opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

opt.smartindent = true
opt.spelllang = { "en" }

opt.virtualedit = "block"
opt.winminwidth = 5

opt.fileencoding = "utf-8"

opt.list = true

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 550

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

opt.listchars:append("space:·")

vim.g.floating_window_options = {
	border = border or "rounded",
	winblend = 10,
}

-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

