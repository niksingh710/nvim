return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = config.todo_comments,
	opts = {},
	lazy = false,
	keys = {
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search Todo" },
	},
}
