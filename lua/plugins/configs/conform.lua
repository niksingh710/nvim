local M = {}
local lang = require("plugins.configs.lang")

M.config = function()
	local opts = {
		format_on_save = nil,
		formatters_by_ft = lang.formatters or {},
	}

	require("conform").setup(opts)
end

return M
