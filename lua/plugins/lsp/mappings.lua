local M = {
	v = {
		["<leader>lf"] = {
			function()
				local cok, conform = pcall(require, "conform")
				if cok then
					return conform.format()
				else
					return vim.lsp.buf.format()
				end
			end,
			"Format file",
		},
	},
	x = {
		["<leader>lf"] = {
			function()
				local cok, conform = pcall(require, "conform")
				if cok then
					return conform.format()
				else
					return vim.lsp.buf.format()
				end
			end,
			"Format file",
		},
	},
	n = {
		["<leader>lf"] = {
			function()
				local cok, conform = pcall(require, "conform")
				if cok then
					return conform.format()
				else
					return vim.lsp.buf.format()
				end
			end,
			"Format file",
		},
		["<leader>il"] = { "<cmd>LspInfo<cr>", "LspInfo" },
		["<leader>lo"] = { "<cmd>Lspsaga outline <cr>", "Outline" },
		["<leader>ll"] = {
			function()
				return utils.toggle_diagnostics_ghost_text()
			end,
			"Toggle Ghost Text",
		},
		["<leader>lL"] = {
			function()
				return utils.toggle_diagnostics()
			end,
			"Toggle Diagnostics",
		},
		["<leader>lw"] = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Workspace Diagnostics" },
		["<leader>ld"] = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "Line Diagnostics" },
		["<leader>la"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" },

		["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Next Diagnostic" },
		["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Prev Diagnostic" },
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
		["K"] = {
			function()
				local uok, ufo = pcall(require, "ufo")
				if uok then
					local winid = ufo.peekFoldedLinesUnderCursor()
					if not winid then
						-- choose one of coc.nvim and nvim lsp
						-- vim.lsp.buf.hover()
						vim.cmd("Lspsaga hover_doc")
					end
				else
					vim.cmd("Lspsaga hover_doc")
				end
			end,
			"Hover Doc",
		},
		["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definations" },
		["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
		["gR"] = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
		["gt"] = { "<cmd>Lspsaga goto_type_definition<CR>", "Type Definations" },
		["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
		["gpd"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definations" },
		["gpt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definations" },
	},
}
return M
