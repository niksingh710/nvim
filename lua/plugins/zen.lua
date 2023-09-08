return {
	"folke/zen-mode.nvim",
	enabled = config.zen_mode,
	lazy = false,
	opts = {
		plugins = {
			tmux = { enabled = true },
		},
	},
	keys = {
		{ "<leader>uz", "<cmd>ZenMode<CR>", desc = "ZenMode" },
	},
}
