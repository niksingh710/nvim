-- Bootstraping lazy.nvim{{{
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
-- }}}

local opts = {
	ui = {
		border = "rounded",
	},
	install = {
		colorscheme = { "tokyonight" },
	},
}
return {
	load = function(list)
		require("lazy").setup(list, opts)
		map("n", {
			["<leader>L"] = { "<cmd>Lazy<cr>", "Lazy Plugin Manager" },
		})
	end,
}
