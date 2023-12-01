return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	dependencies = {
		"RRethy/nvim-treesitter-textsubjects",
		"nvim-treesitter/nvim-treesitter-textobjects",
		{
			"windwp/nvim-ts-autotag",
			config = true,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			config = require("plugins.configs.treesitter").blankline_config,
		},
	},
	build = ":TSUpdate",
	config = require("plugins.configs.treesitter").config,
}
