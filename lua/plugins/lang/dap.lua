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
				vim.fn.sign_define(
					"DapBreakpoint",
					{ text = icons.ui.Bug, texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
				)
				vim.fn.sign_define(
					"DapBreakpointCondition",
					{ text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
				)
				vim.fn.sign_define(
					"DapBreakpointRejected",
					{ text = icons.ui.Bug, texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
				)
				vim.fn.sign_define(
					"DapLogPoint",
					{
						text = icons.diagnostics.BoldInformation,
						texthl = "DapLogPoint",
						linehl = "DapLogPoint",
						numhl = "DapLogPoint",
					}
				)
				vim.fn.sign_define(
					"DapStopped",
					{
						text = icons.ui.BoldArrowRight,
						texthl = "DapStopped",
						linehl = "DapStopped",
						numhl = "DapStopped",
					}
				)
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
