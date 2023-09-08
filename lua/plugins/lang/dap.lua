return {
	"mfussenegger/nvim-dap",
	enabled = config.nvim_dap,
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = config.ensure.nvim_dap,
			},
		},
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup()
			end,
		},
	},
	keys = {

		{ "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Dap Toggle Breakpoint" },
		{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue Debugger" },
		{
			"<leader>duu",
			"<cmd>lua require('dapui').toggle()<cr>",
			desc = "Open Dap ui",
		},

		{
			"<leader>dus",
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			desc = "Open Debugger sidebar",
		},
	},
}
