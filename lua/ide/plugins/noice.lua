local nok, noice = pcall(require, "noice")
if not nok then
	return
end
local opts = {
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		progress = {
			enabled = false,
		},
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
	},
	cmdline = {
		format = {
			help = { pattern = "^:%s*tab he?l?p?%s+", icon = "" },
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
		command_palette = {
			views = {
				cmdline_popup = {
					position = {
						row = 60,
						col = "50%",
					},
					size = {
						min_width = 60,
						width = "auto",
						height = "auto",
					},
				},
			},
		},
	},
}
noice.setup(opts)
