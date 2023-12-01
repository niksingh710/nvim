return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"debugloop/telescope-undo.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		{
			"ahmedkhalf/project.nvim",
			lazy = false,
			config = function()
				require("project_nvim").setup({})
			end,
		},
		{
			"ThePrimeagen/git-worktree.nvim",
			init = function()
				utils.load.mappings("gitworktree")
			end,
		},
		{
			"ThePrimeagen/harpoon",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			init = function()
				utils.load.mappings("harpoon")
			end,
		},
		{
			"axieax/urlview.nvim",
			opts = {
				default_title = "Links:",
				default_picker = "telescope",
				default_prefix = "https://",
				default_action = "system",
			},
		},
		{
			"olimorris/persisted.nvim",
			init = function()
				utils.load.mappings("persisted")
			end,
			config = require("plugins.configs.telescope").persisted,
		},
	},
	cmd = "Telescope",
	init = function()
		utils.load.mappings("telescope")
	end,
	config = require("plugins.configs.telescope").config,
}
