local alpha = srequire("alpha")
if not alpha then
	return
end

local dashboard = srequire("alpha.themes.dashboard")
if not dashboard then
	return
end

dashboard.section.header.val = require("niksingh710.headers")

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
	dashboard.button(".", "  Last Session", "<cmd>lua require('persistence').load({ last = true })<cr>"),
	dashboard.button("d", "  Last Session of Dir", "<cmd>lua require('persistence').load()<cr>"),
}

dashboard.section.footer.val = "Welcome Nikhil!!"

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
-- TODO: fix ready ready bug
-- map("n", { ["<leader>"] = { [";"] = { "<cmd>Alpha<CR>", "Dashboard" } } }, true)
