return {
	{ "leoluz/nvim-dap-go", ft = "go" }, --go
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = true,
		build = function()
			vim.cmd("silent! GoInstallDeps")
		end,
		init = function()
			utils.load.mappings("go")
		end,
	},
}
