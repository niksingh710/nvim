local signs = {
	Error = icons.diagnostics.BoldError,
	Warn = icons.diagnostics.BoldWarning,
	Hint = icons.diagnostics.BoldHint,
	Info = icons.diagnostics.BoldInformation,
}

vim.diagnostic.config({
	virtual_text = false,
	underline = false,
	signs = true,
	severity_sort = true,
	float = {
		border = config.border or "rounded",
		source = "always",
		focusable = false,
	},
})

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local mok, mason = pcall(require, "mason")
if not mok then
	vim.notify("For some reason failed to Mason")
	return
end

mason.setup({
	ui = {
		border = config.border or "rounded",
	},
})

if wstatus then
	local mapping = {
		i = {
			name = "Info",
			m = { "<cmd>Mason<cr>", "Mason Info" },
		},
	}
	local opts = {
		prefix = "<leader>",
	}

	whichkey.register(mapping, opts)
end

require("ide.plugins.lang.treesitter")
require("ide.plugins.lang.lsp")
require("ide.plugins.lang.null-ls")
require("ide.plugins.lang.cmp")
require("ide.plugins.lang.dap")
