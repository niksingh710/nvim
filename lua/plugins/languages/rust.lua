return {
	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"Saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("crates").setup({
				autoupdate = true,
			})
			require("crates").show()
		end,
	},
}
