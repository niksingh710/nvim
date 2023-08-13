local sd, dapui = pcall(require, "dapui")
if not sd then
	return
end

dapui.setup()

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
	{ text = icons.diagnostics.BoldInformation, texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define(
	"DapStopped",
	{ text = icons.ui.BoldArrowRight, texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
)

utils.map("n", {
	["<leader>dd"] = { "<cmd>:lua require('dap-ui').toggle()<cr>", "Toggle DAP UI" },
	["<leader>db"] = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Break Point" },
	["<leader>dc"] = { "<cmd>DapContinue<cr>", "Continue" },
	["<leader>dr"] = { "<cmd>lua require('dapui').open({reset = true})<cr>", "Reset Window style" },
})

local ws, _ = pcall(require, "which-key")
if ws then
	utils.map("n", {
		["<leader>"] = {
			d = {
				name = "debug",
				["g"] = {
					name = "go",
				},
			},
		},
	}, true)
end
