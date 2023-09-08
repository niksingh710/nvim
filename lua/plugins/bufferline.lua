return {
			"akinsho/bufferline.nvim",
      enabled = config.bufferline,
      lazy = false,
			version = "*",
			dependencies = "nvim-tree/nvim-web-devicons",
      opts = {
	options = {
		left_trunc_marker = icons.ui.ArrowCircleLeft,
		right_trunc_marker = icons.ui.ArrowCircleRight,
		truncate_names = true,
		offsets = {
			{
				filetype = "undotree",
				text = "Undotree",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "NvimTree",
				text = "Explorer",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "DiffviewFiles",
				text = "Diff View",
				highlight = "PanelHeading",
				padding = 1,
			},
			{
				filetype = "flutterToolsOutline",
				text = "Flutter Outline",
				highlight = "PanelHeading",
			},
			{
				filetype = "lazy",
				text = "Lazy",
				highlight = "PanelHeading",
				padding = 1,
			},
		},
	},
},
keys = {

     {"<leader>bc", "<cmd>bd<cr>",desc= "Buffer Delete" },
     {"<leader>bp", "<cmd>BufferLinePick<cr>",desc= "Buffer Pick" },
     {"<leader>bP", "<cmd>BufferLineTogglePin<cr>",desc= "Buffer Pin" },
     {"<leader>bd", "<cmd>BufferLineSortByDirectory<cr>",desc= "Buffer Sort by dir" },
     {"<leader>be", "<cmd>BufferLineSortByExtension<cr>",desc= "Buffer Sort by ext" },
     {"<leader>bt", "<cmd>BufferLineSortByTabs<cr>",desc= "Buffer Sort by Tabs" },
},
		}
