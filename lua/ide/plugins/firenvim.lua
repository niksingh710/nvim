vim.g.firenvim_config = {
	localSettings = {
		[".*"] = {
			takeover = "never",
			cmdline = "firenvim",
		},
	},
}
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "leetcode.com_*.txt",
	callback = function()
		if utils.check.vimcmd("Copilot") then
			vim.cmd("Copilot disable")
		end
	end,
})
