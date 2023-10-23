local mappings = {
	{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },

	{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Search Diagnostics" },
	{ "<leader>sf", "<cmd>Telescope find_files <cr>", desc = "Search Find files" },
	{ "<leader>sF", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files Hidden Also" },
	{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search Recent files" },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Search Keymaps" },
	{ "<leader>ss", "<cmd>Telescope builtin<cr>", desc = "Search Telescope" },
	{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search Live Grep" },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
	{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
	{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
	{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Search in Media Mode" },
	{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Search Vim Options" },
	{ "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Search Quickfix" },
	{ "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Search Location List" },
	{ "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Search Projects" },
	{ "<leader>su", "<cmd>Telescope undo<cr>", desc = "Search undo" },
	{ "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Buffer Search" },
}

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	enabled = config.telescope,
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
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
			"ThePrimeagen/harpoon",
			enabled = config.harpoon,
      lazy = false,
			opts = {
				global_settings = {
					mark_branch = true,
				},
			},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{ "<leader>fm", ":lua require('harpoon.mark').add_file()<cr>", desc = "Mark file to harpoon" },
				{ "<leader>fu", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon Ui" },
				{ "<leader>ff", ":Telescope harpoon marks<cr>", desc = "Harpoon Telescope" },
			},
		},
	},

	config = function()
		local telescope = require("telescope")
		local action = require("telescope.actions")
		telescope.setup({

			extensions = {

				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},

				undo = {
					mappings = {
						n = {
							-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
							-- you want to replicate these defaults and use the following actions. This means
							-- installing as a dependency of telescope in it's `requirements` and loading this
							-- extension from there instead of having the separate plugin definition as outlined
							-- above.
							["y"] = require("telescope-undo.actions").yank_additions,
							["Y"] = require("telescope-undo.actions").yank_deletions,
							["<cr>"] = require("telescope-undo.actions").restore,
						},
					},
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
				},
			},

			defaults = {
				mappings = {
					n = {
						q = action.close,
						x = action.select_horizontal,
						v = action.select_vertical,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("undo")
		telescope.load_extension("harpoon")
		telescope.load_extension("projects")
	end,

	keys = mappings,
}
