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

-- Requiring lsp Stuff {{{
local lok, lspconfig = pcall(require, "lspconfig")
if not lok then
	vim.notify("For some reason failed to load Lsp")
	return
end

local mok, mason = pcall(require, "mason")
if not mok then
	vim.notify("For some reason failed to Mason")
	return
end
local mlok, mason_config = pcall(require, "mason-lspconfig")
if not mlok then
	vim.notify("For some reason failed to Mason Lsp Config")
	return
end

local sok, lspsaga = pcall(require, "lspsaga")
if not sok then
	vim.notify("For some reason failed to LspSaga")
	return
end -- }}}

local servers = config.servers or {}
local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_init = function(client, _)
	if client.server_capabilities then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.semanticTokensProvider = false -- turn off semantic tokens
	end
end
local on_attach = function(_, bufnr)
	vim.g.diagnostics_visible = true
	local function toggle_diagnostics()
		if vim.g.diagnostics_visible then
			vim.g.diagnostics_visible = false
			vim.diagnostic.disable()
		else
			vim.g.diagnostics_visible = true
			vim.diagnostic.enable()
		end
	end

	--- autocmd to show diagnostics on CursorHold
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		desc = "✨lsp show diagnostics on CursorHold",
		callback = function()
			local hover_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
			}
			vim.diagnostic.open_float(nil, hover_opts)
		end,
	})

	vim.g.diagnostics_visible = true
	local function toggle_diagnostics_ghost_text()
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

	--- autocmd to show diagnostics on CursorHold
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		desc = "lsp show diagnostics on CursorHold",
		callback = function()
			local hover_opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = config.border or "rounded",
				source = "always",
			}
			vim.diagnostic.open_float(nil, hover_opts)
		end,
	})
	capabilities.textDocument.completion.completionItem = {
		documentationFormat = { "markdown", "plaintext" },
		snippetSupport = true,
		preselectSupport = true,
		insertReplaceSupport = true,
		labelDetailsSupport = true,
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

	if wstatus then
		local opts = {
			prefix = "<leader>",
		}

		local mapping = {
			i = {
				name = "Info",
				m = { "<cmd>Mason<cr>", "Mason" },
				l = { "<cmd>LspInfo<cr>", "LspInfo" },
			},
			l = {
				name = "Lsp",
				o = { "<cmd>Lspsaga outline<cr>", "Outline" },
				l = { toggle_diagnostics_ghost_text, "Toggle Diagnostics" },
				L = { toggle_diagnostics, "Toggle Diagnostics" },
				w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Diagnostics" },
				d = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "Line Diagnostics" },
				a = { "<cmd>Lspsaga code_action<cr>", "Outline" },

				k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Next Diagnostic" },
				j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Prev Diagnostic" },
				f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format file" },
			},
			g = {
				name = "Goto",
				d = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definations" },
				h = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
				R = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
				t = { "<cmd>Lspsaga goto_type_definition<CR>", "Type Definations" },
				l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
				p = {
					name = "Preview",
					d = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definations" },
					t = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definations" },
				},
			},
			["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
			["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic" },
			["[E"] = {
				"<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
				"Previous Error",
			},
			["]E"] = {
				"<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
				"Next Error",
			},
		}
		local normal = {
			g = {
				name = "Goto",
				d = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definations" },
				h = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
				R = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
				t = { "<cmd>Lspsaga goto_type_definition<CR>", "Type Definations" },
				l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
				p = {
					name = "Preview",
					d = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definations" },
					t = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definations" },
				},
			},
		}
		whichkey.register(mapping, opts)
		whichkey.register(normal, {})
	end
	utils.map("n", {
		K = { "<cmd>Lspsaga hover_doc<CR>", "Hover Doc" },
	})
end

lspsaga.setup({
	scroll_preview = {
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
	ui = {
		border = config.border or "rounded",
	},
	outline = {
		keys = {
			jump = "<cr>",
		},
	},
})
mason.setup({
	ui = {
		border = config.border or "rounded",
	},
})

-- This loop will make sure that if i install a server manually then it get configured with default values
for _, k in ipairs(mason_config.get_installed_servers()) do
	if not servers[k] then
		servers[k] = {}
	end
end
for _, k in ipairs(config.mason_ensure or {}) do
	if not servers[k] then
		servers[k] = {}
	end
end
mason_config.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
})

mason_config.setup_handlers({
	function(server_name)
		-- help comment
		-- custom ruff_lsp config [Example if any server not having settings key
		-- if server_name == "ruff_lsp" then
		-- 	lspconfig[server_name].setup({
		-- 		capabilities = capabilities,
		-- 		on_attach = on_attach,
		-- 		init_options = { settings = servers[server_name] },
		-- 	})
		-- 	return nil
		-- end
		lspconfig[server_name].setup({
			on_init = on_init,
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

if wstatus then
	local mapping = {
		i = {
			name = "Info",
			m = { "<cmd>Mason<cr>", "Mason" },
			l = { "<cmd>LspInfo<cr>", "LspInfo" },
		},
	}
	local opts = {
		prefix = "<leader>",
	}

	whichkey.register(mapping, opts)
end
-- {{{
-- Null-ls require {{{
local nok, null_ls = pcall(require, "null-ls")
if not nok then
	-- vim.notify("Failed to load null-ls")
	return
end

local mnok, mnull_ls = pcall(require, "mason-null-ls")
if not mnok then
	-- vim.notify("Failed to load mason-null-ls")
	return
end

local null_ensure = {}
for key, _ in pairs(config.null_ls.formatters or {}) do
	table.insert(null_ensure, key)
end
-- }}}

for key, _ in pairs(config.null_ls.linters or {}) do
	table.insert(null_ensure, key)
end

local opts = {
	ensure_installed = null_ensure,
	automatic_installation = true,
}

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {}
for k, v in pairs(config.null_ls.formatters or {}) do
	if #v > 0 then
		table.insert(sources, formatting[k].with(v))
	else
		table.insert(sources, formatting[k])
	end
end

for k, v in pairs(config.null_ls.linters or {}) do
	if #v > 0 then
		table.insert(sources, diagnostics[k].with(v))
	else
		table.insert(sources, diagnostics[k])
	end
end

null_ls.setup({
	sources = sources,
})

mnull_ls.setup(opts)

if wstatus then
	local mapping = {
		i = {
			name = "Info",
			n = { "<cmd>NullLsInfo<cr>", "Null LS Info" },
		},
	}
	opts = {
		prefix = "<leader>",
	}

	whichkey.register(mapping, opts)
end -- }}}
