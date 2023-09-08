local aok, alpha = pcall(require, "alpha")
if not aok then
	return
end

local dashboard = require("alpha.themes.dashboard")

local btns = {
	dashboard.button("e", icons.ui.NewFile .. "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("C", icons.ui.Gear .. "  Configuration", ":e $MYVIMRC <CR><esc>:lcd %:p:h<cr>"),
}

if utils.check.file_exists(os.getenv("HOME") .. "/.config/nvim/lua/ide/config.lua") then
	-- table.insert(btns, dashboard.button("c", "⚯  Quick Config", ":e ~/.config/nvim/lua/ide/config.lua <CR><esc>:lua utils.cwd_to_buf(bufnr)<cr>"))
	table.insert(
		btns,
		dashboard.button(
			"c",
			"⚯  Quick Config",
			":e ~/.config/nvim/lua/ide/config.lua <CR><esc>:lcd %:p:h<cr>"
		)
	)
end

if utils.check.file_exists(os.getenv("HOME") .. "/.config/nvim/lua/ide/plugins/list.lua") then
	table.insert(btns, dashboard.button("L", "  Plugins List", ":e ~/.config/nvim/lua/ide/plugins/list.lua <CR><esc>:lcd ~/.config/nvim/<cr>"))
end

if utils.check.file_exists(os.getenv("HOME") .. "/.config/hypr/hyprland.conf") then
	table.insert(
		btns,
		dashboard.button("H", icons.ui.Target .. "  Hyprland Config", ":e ~/.config/hypr/hyprland.conf <CR><esc>:lcd %:p:h<cr>")
	)
end

if utils.check.file_exists(os.getenv("HOME") .. "/.config/waybar/bars/top.json") then
	table.insert(
		btns,
		dashboard.button("W", icons.ui.Ellipsis  .. "  waybar Config", ":e ~/.config/waybar/bars/top.json <CR><esc>:lcd %:p:h<cr>")
	)
end


local tok, _ = pcall(require, "telescope")
if tok then
	table.insert(btns, dashboard.button("f", icons.ui.Watches .. "  Find file", ":Telescope find_files <CR>"))
	table.insert(btns, dashboard.button("g", icons.ui.FindFile .. "  Find text", ":Telescope live_grep <CR>"))
	table.insert(btns, dashboard.button("p", icons.ui.Folder .. "  Find project", ":Telescope projects <CR>"))
	table.insert(btns, dashboard.button("r", icons.ui.History .. "  Recently used files", ":Telescope oldfiles <CR>"))
end

local pok, _ = pcall(require, "persisted")
if pok then
	table.insert(btns, dashboard.button(".", "  Last Session", "<cmd>SessionLoadLast<cr>"))
	table.insert(btns, dashboard.button("d", "  Last Session of Dir", "<cmd>SessionLoad<cr>"))
	table.insert(btns, dashboard.button("l", "  Session List", "<cmd>Telescope persisted<cr>"))
end

table.insert(btns, dashboard.button("q", icons.ui.BoldClose .. "  Quit Neovim", ":qa<CR>"))

dashboard.section.buttons.val = btns
dashboard.section.footer.val = "Howdy!!"

dashboard.section.header.val = require("ide.plugins.alpha-headers")

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)

utils.map("n", { ["<leader>;"] = { "<cmd>Alpha<CR>", "Dashboard" } })

-- bufferline fix
local toggle_bufferline = vim.api.nvim_create_augroup("ToggleBufferline", { clear = true })
vim.api.nvim_create_autocmd("User", {
	callback = function()
		vim.o.showtabline = 0
	end,
	group = toggle_bufferline,
	pattern = "AlphaReady",
})
vim.api.nvim_create_autocmd("BufUnload", {
	callback = function()
		vim.o.showtabline = 2
	end,
	group = toggle_bufferline,
	pattern = "*",
})
