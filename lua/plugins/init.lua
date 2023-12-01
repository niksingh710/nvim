-- Plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
local opts = require("plugins.configs.lazy").options

require("lazy").setup({ import = "plugins.list" }, opts) -- importing will allow to have all the files in the dir as plugin
utils.load.mappings("lazy")
