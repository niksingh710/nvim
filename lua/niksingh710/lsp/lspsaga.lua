local lspsaga = srequire("lspsaga")
if not lspsaga then
	return
end
lspsaga.setup({
	ui = {
		border = "rounded",
	},
	hover = {
		lightbulb = {
			virtual_text = false,
		},
		open_link = "gx",
		open_browser = "!firefox",
	},
})
-- vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>") -- if user want term toggle
