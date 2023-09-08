return {
	"numToStr/Comment.nvim",
	enabled = config.comment,
	config = true,
	keys = {
		{ "<leader>/", "<plug>(comment_toggle_linewise_visual)", mode = "x", desc = "Comment" },
		{ "<leader>/", "<plug>(comment_toggle_linewise_current)", desc = "Comment" },
	},
	lazy = false,
}
