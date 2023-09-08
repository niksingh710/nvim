return {
	"ThePrimeagen/harpoon",
	enabled = config.harpoon,
  opts = {
    global_settings = {
      mark_branch = true,
    },
  },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("harpoon")
	end,
	keys = {

		{ "<leader>fm", ":lua require('harpoon.mark').add_file()<cr>", desc = "Mark file to harpoon" },
		{ "<leader>fu", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon Ui" },
		{ "<leader>ff", ":Telescope harpoon marks<cr>", desc = "Harpoon Telescope" },
	},
}
