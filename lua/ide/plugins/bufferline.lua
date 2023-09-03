local bok, bufferline = pcall(require, "bufferline")
if not bok then
	return
end

local opts = {
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
}
bufferline.setup(opts)

if wstatus then
	opts = {
		prefix = "<leader>",
	}

	local mapping = {
		b = {
			name = "Buffers",
			c = { "<cmd>bd<cr>", "Delete Buffer" },
			p = { "<cmd>BufferLinePick<cr>", "Pick Buffer" },
			P = { "<cmd>BufferLineTogglePin<cr>", "Pin Buffer" },
			d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort Buffers by Directory" },
			e = { "<cmd>BufferLineSortByExtension<cr>", "Sort Buffers by Extension" },
			t = { "<cmd>BufferLineSortByTabs<cr>", "Sort Buffers by Tabs" },
		},
	}

	whichkey.register(mapping, opts)
end
