return {
	"williamboman/mason.nvim",
	enabled = config.mason,
	lazy = false,
	opts = {
		ui = {
			border = config.border or "rounded",
		},
	},
	keys = {
		{ "<leader>im", "<cmd>Mason<cr>", desc = "Mason" },
	},
}
