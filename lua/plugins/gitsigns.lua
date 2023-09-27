return {
	"lewis6991/gitsigns.nvim",
	enabled = config.gitsigns,
	opts = {
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		signs = {
			add = {
				hl = "GitSignsAdd",
				text = icons.ui.BoldLineLeft,
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineLeft,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = icons.ui.Triangle,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = icons.ui.Triangle,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineLeft,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
	},
	lazy = false,
}
