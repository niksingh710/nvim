return {
	"EdenEast/nightfox.nvim",
	opts = {
		options = {
			transparent = true,
			styles = { -- Style to be applied to different syntax groups
				conditionals = "NONE",
				constants = "NONE",
				functions = "NONE",
				numbers = "NONE",
				operators = "NONE",
				strings = "NONE",
				variables = "NONE",
				comments = "italic",
				keywords = "bold",
				types = "italic,bold",
			},
			inverse = { -- Inverse highlight for different types
				match_paren = true,
				visual = true,
				search = true,
			},
		},
	},
}
