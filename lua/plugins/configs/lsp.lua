local M = {}
local lang = require("plugins.configs.lang")

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = true,
	severity_sort = true,
	float = {
		border = border or "rounded",
		source = "always",
		focusable = false,
	},
})

local signs = {
	Hint = icons.diagnostics.BoldHint or "",
	Info = icons.diagnostics.BoldInformation or "",
	Warn = icons.diagnostics.BoldWarning or "",
	Error = icons.diagnostics.BoldError or "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local cok, cmplsp = pcall(require, "cmp_nvim_lsp")

M.capabilities = vim.lsp.protocol.make_client_capabilities()
if cok then
	M.capabilities = cmplsp.default_capabilities(M.capabilities)
end

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	dynamicRegistration = false,
	lineFoldingOnly = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.on_attach = function(client, bufnr)
	vim.g.diagnostics_visible = true

	client.server_capabilities.semanticTokensProvider = nil
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	utils.load.mappings("lspconfig_saga", { buffer = bufnr })
end

M.mason_lsp_options = {
	ensure_installed = lang.ensure_lsp or {},
	automatic_installation = true,
}

M.mason_options = {
	ui = {
		border = border or "rounded",
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},
	},
	keymaps = {
		toggle_server_expand = "<CR>",
		install_server = "i",
		update_server = "u",
		check_server_version = "c",
		update_all_servers = "U",
		check_outdated_servers = "C",
		uninstall_server = "X",
		cancel_installation = "<C-c>",
	},

	max_concurrent_installers = 10,
}

M.config = function()
	local mason = require("mason")
	local mason_lsp = require("mason-lspconfig")

	mason.setup(M.mason_options)
	mason_lsp.setup(M.mason_lsp_options)

	local handlers = lang.handlers() or {}

	mason_lsp.setup_handlers(handlers)
end

M.saga_conf = function()
	local opts = {
		scroll_preview = {
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		},
		ui = {
			border = border or "rounded",
		},
		outline = {
			keys = {
				jump = "<cr>",
			},
		},
		code_action_prompt = {
			enable = true,
			sign = true,
			sign_priority = 20,
			virtual_text = true,
		},
	}
	require("lspsaga").setup(opts)
end

M.toggle_diagnostics_ghost_text = function()
	if vim.diagnostic.config().virtual_text == false then
		vim.diagnostic.config({
			virtual_text = {
				source = "always",
				prefix = "●",
			},
		})
	else
		vim.diagnostic.config({
			virtual_text = false,
		})
	end
end

M.toggle_diagnostics = function()
	if vim.g.diagnostics_visible then
		vim.g.diagnostics_visible = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_visible = true
		vim.diagnostic.enable()
	end
end

-- Auto Commands
--- autocmd to show diagnostics on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	desc = "lsp show diagnostics on CursorHold",
	callback = function()
		local hover_opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = border or "rounded",
			source = "always",
		}
		vim.diagnostic.open_float(nil, hover_opts)
	end,
})

return M
