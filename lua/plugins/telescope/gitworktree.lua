return {
	"ThePrimeagen/git-worktree.nvim",
	enabled = config.git_worktree,
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		{
			"<leader>gw",
			"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
			desc = "Git worktree list",
		},
		{
			"<leader>gc",
			"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
			desc = "Git worktree create",
		},
	},
}
