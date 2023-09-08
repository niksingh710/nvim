return {
	{ "leoluz/nvim-dap-go", ft = "go" }, --go
	{
		{
			"olexsmir/gopher.nvim",
			ft = "go",
			config = true,
			build = function()
				vim.cmd("silent! GoInstallDeps")
			end,
			keys = {

				{ "<leader>Lgsj", "<cmd>GoTagAdd json<CR>", desc = "Add Json Tags" },
				{ "<leader>Lgsy", "<cmd>GoTagAdd yaml<CR>", desc = "Add Yaml Tags" },
			},
		},
	},
}
