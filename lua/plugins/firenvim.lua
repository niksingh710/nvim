return {
	"glacambre/firenvim",
	enabled = config.firenvim,

	-- Lazy load firenvim
	-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
	-- cond = not vim.g.started_by_firenvim,
	build = function()
		require("lazy").load({ plugins = { "firenvim" }, wait = true })
		vim.fn["firenvim#install"](0)
	end,
	config = function()
		vim.g.firenvim_config = {
			localSettings = {
				[".*"] = {
					takeover = "never",
					cmdline = "neovim",
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
	end,
	lazy = false,
}
