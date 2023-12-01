return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		{
			"williamboman/mason.nvim",
			init = function()
				utils.load.mappings("mason")
			end,
		},
		{
			"nvimdev/lspsaga.nvim",
			config = require("plugins.configs.lsp").saga_conf,
		},
	},
	config = require("plugins.configs.lsp").config,
}
