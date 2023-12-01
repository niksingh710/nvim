return {
	"mfussenegger/nvim-dap",
  event = "VeryLazy",
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = require("plugins.configs.lang").ensure_dap or {},
			},
		},
		{
			"rcarriga/nvim-dap-ui",
      init = function ()
        utils.load.mappings "dap_ui"
      end,
			config = require("plugins.configs.dap").dap_ui,
		},
	},
}
