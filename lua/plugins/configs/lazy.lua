M = {}

M.options = {
  ui = {
    border = border or "rounded",
    icons = icons.ui.lazy,
  },
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
  change_detection = { enabled = false },
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

return M
