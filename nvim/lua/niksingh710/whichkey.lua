local wk = srequire("which-key")
if not wk then
	return
end

wk.setup({
	window = {
		border = "rounded",
		position = "bottom",
		margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 1, max = 25 }, -- min and max height of the columns
		width = { min = 10, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
})
