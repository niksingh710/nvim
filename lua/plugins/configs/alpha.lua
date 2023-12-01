local M = {}

local entries = {
	{ "e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>" },
	{ "c", icons.ui.Gear .. " Configuration", ":e $MYVIMRC <CR><esc>:lcd %:p:h<cr>" },
	{ "l", " Quick Lang", ":e ~/.config/nvim/lua/plugins/configs/lang.lua <CR><esc>:lcd %:p:h<cr>" },
}

if utils.check.file_exists(os.getenv("HOME") .. "/.config/hypr/hyprland.conf") then
	table.insert(entries, {
		"h",
		icons.ui.Target .. "  Hyprland Config",
		":e ~/.config/hypr/hyprland.conf <CR><esc>:lcd %:p:h<cr>",
	})
end
if utils.check.file_exists(os.getenv("HOME") .. "/.config/waybar/bars/top.json") then
	table.insert(entries, {
		"w",
		"  Waybar Config",
		":e ~/.config/waybar/bars/top.json <CR><esc>:lcd %:p:h<cr>",
	})
end
table.insert(entries, { "f", icons.ui.Watches .. "  Find file", ":Telescope find_files <CR>" })
table.insert(entries, { "g", icons.ui.FindFile .. "  Find text", ":Telescope live_grep <CR>" })
table.insert(entries, { "p", icons.ui.Folder .. "  Find project", ":Telescope projects <CR>" })
table.insert(entries, { "r", icons.ui.History .. "  Recently used files", ":Telescope oldfiles <CR>" })
table.insert(entries, { ".", "  Last Session", "<cmd>SessionLoadLast<cr>" })
table.insert(entries, { "d", "  Last Session of Dir", "<cmd>SessionLoad<cr>" })
table.insert(entries, { "s", "  Session List", "<cmd>Telescope persisted<cr>" })

table.insert(entries, { "q", icons.ui.BoldClose .. "  Quit Neovim", ":qa<CR>" })

M.config = function()
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
			print("running this..")
			vim.o.showtabline = 2
		end,
		group = toggle_bufferline,
		pattern = "*",
	})

	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	local btns = {}

	for _, entry in ipairs(entries) do
		table.insert(btns, dashboard.button(entry[1], entry[2], entry[3]))
	end

	dashboard.section.buttons.val = btns
	dashboard.section.footer.val = "Howdy!!"
	local vok, val = pcall(require, "plugins.configs.ascii-headers")
	if vok then
		dashboard.section.header.val = val
	end
	alpha.setup(dashboard.opts)
end

return M
