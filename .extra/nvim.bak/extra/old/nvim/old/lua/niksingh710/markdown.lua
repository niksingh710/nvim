local glow = require("glow")
if not glow then
	return
end
glow.setup()
map("n", {
	["<leader>"] = {
		["m"] = {
			name = "Markdown",
			["g"] = { "<cmd>Glow<cr>", "Glow" },
			["b"] = { "<cmd>MarkdownPreview<cr>", "Browser" },
		},
	},
}, true)
