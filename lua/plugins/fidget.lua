return {
	"j-hui/fidget.nvim",
  enabled = config.fidget,
	lazy = false,
	branch = "legacy",
	opts = {
		text = {
			spinner = "moon",
		},
		window = {
			relative = "win", -- where to anchor, either "win" or "editor"
			blend = 20, -- &winblend for the window
			border = config.border or "rounded", -- style of border for the fidget window
		},
	},
}
