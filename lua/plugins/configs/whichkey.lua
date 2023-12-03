M = {}


M.config = function()
	local wk = require("which-key")
	wk.setup({
		window = {
			border = border or "rounded",
		},
		layout = {
			align = "center",
			height = {
				min = 1,
			},
		},
	})
	local opt = {
		prefix = "<leader>",
	}
	local mapping = {
		b = "Buffer",
		d = "Debug",
		f = "Files",
		g = "Git",
		i = "Info",
		l = "Lsp",
		r = "Rest",
		s = "Search",
		S = "Session",
		t = "Tab",
		v = "Split",
		u = "Utils",
		p = "Preview",
	}
	wk.register(mapping, opt)
end

return M
