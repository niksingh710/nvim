-- This file will expose `utils` and `config` global variables
---@diagnostic disable: lowercase-global
cok, config = pcall(require, "config")
if not cok then
	config = {}
end

icons = require("core.icons")
utils = require("core.utils")

require("core")

-- Bootstrapping lazy.nvim {{{
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

local opts = {
	ui = {
		---@diagnostic disable-next-line: undefined-global
		border = config.border or "rounded",
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
	change_detection = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { -- Will try to load the themes if available in this order
			"material",
			"tokyodark",
			"catppuccin",
			"tokyonight",
			"habmax",
		},
	},
}

require("lazy").setup("plugins", opts)
utils.map("n", { ["<leader>iL"] = { "<cmd>Lazy<cr>", "Lazy" } })
-- }}}

-- vim.cmd("colorscheme tokyodark")
vim.cmd("colorscheme material")
