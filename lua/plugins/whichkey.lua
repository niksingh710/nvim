return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	enabled = config.which_key,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = { -- for config -> https://github.com/folke/which-key.nvim
		window = {
			border = config.border or "rounded",
		},
		layout = {
			align = "center",
			height = {
				min = 1,
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		local opt = {
			prefix = "<leader>",
		}
		local mapping = {
			u = "Utils",
			s = "Search",
			S = "Session",
			t = "Tab",
      v = "Split",
			f = "Files",
			b = "Buffer",
      g = "git",
			p = "Preview",
			L = { name = "Languages", g = { name = "Gopher", s = "Struct" } },
		}
		wk.register(mapping, opt)
	end,
}
