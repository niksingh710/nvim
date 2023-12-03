local M = {}
local lang = require("plugins.configs.lang")

M.config = function()
	vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
	require("lint").linters_by_ft = lang.linters or {}
end

return M
