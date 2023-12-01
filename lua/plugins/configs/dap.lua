local M = {}

M.dap_ui = function()
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
	vim.fn.sign_define("DapLogPoint", {
		text = icons.diagnostics.BoldInformation,
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	})
	vim.fn.sign_define("DapStopped", {
		text = icons.ui.BoldArrowRight,
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	})
	require("dapui").setup()
end

return M
