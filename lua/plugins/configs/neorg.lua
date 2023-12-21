local M = {}

M.config = function()
	require("neorg").setup({
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.concealer"] = {}, -- Adds pretty icons to your documents
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						default = "~/Documents/neorg",
					},
				},
			},
		},
	})
end

return M
