local tok, telescope = pcall(require, "telescope")
if not tok then
	return
end

local action = require("telescope.actions")

local opts = {

	extensions = {

		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
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
}

telescope.setup(opts)
telescope.load_extension("fzf")

if wstatus then
	opts = {
		prefix = "<leader>",
	}

	local mapping = {
		s = {
			name = "Search",
			d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
			f = { "<cmd>Telescope find_files <cr>", "Search Find files" },
			F = { "<cmd>Telescope find_files hidden=true<cr>", "Find files Hidden Also" },
			r = { "<cmd>Telescope oldfiles<cr>", "Search Recent files" },
			k = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
			s = { "<cmd>Telescope builtin<cr>", "Search Telescope" },
			g = { "<cmd>Telescope live_grep<cr>", "Search Live Grep" },
			h = { "<cmd>Telescope help_tags<cr>", "Search Help Tags" },
			b = { "<cmd>Telescope buffers<cr>", "Search Buffers" },
			c = { "<cmd>Telescope commands<cr>", "Search Commands" },
			m = { "<cmd>Telescope marks<cr>", "Search Marks" },
			o = { "<cmd>Telescope vim_options<cr>", "Search Vim Options" },
			q = { "<cmd>Telescope quickfix<cr>", "Search Quickfix" },
			l = { "<cmd>Telescope loclist<cr>", "Search Location List" },
			t = { "<cmd>TodoTelescope<cr>", "Comment" },
			["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy Buffer Search" },
		},
	}

	whichkey.register(mapping, opts)
end
