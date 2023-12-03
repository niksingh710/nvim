M.general = {
	i = {
		["jk"] = { "<esc>", "Normal mode" },
		-- ["kj"] = "<esc>",
		["<esc>"] = { "<esc>", "Esc" }, -- Copilot unmaps esc in insert mode

		["<c-s>"] = { "<esc>:w<cr>", "Save file" },
		["<a-j>"] = { "<esc>:m .+1<cr>==gi", "Move Line Down" },
		["<a-k>"] = { "<esc>:m .-2<cr>==gi", "Move Line Up" },
	},
	n = {
		["<c-s>"] = { "<cmd>w<cr>", "Save the file" },

		["<c-h>"] = { "<c-w>h", "Focus on right split" },
		["<c-j>"] = { "<c-w>j", "Focus on below split" },
		["<c-k>"] = { "<c-w>k", "Focus on up split" },
		["<c-l>"] = { "<c-w>l", "Focus on left split" },

		["<c-a-j>"] = { "<cmd>resize -1<cr>", "Resize down" },
		["<c-a-k>"] = { "<cmd>resize +1<cr>", "Resize up" },
		["<c-a-l>"] = { "<cmd>vertical resize -1<cr>", "Resize right" },
		["<c-a-h>"] = { "<cmd>vertical resize +1<cr>", "Resize left" },

		["<c-a-=>"] = { "<C-a>", "Increase Number" },
		["<c-a-->"] = { "<C-x>", "Decrease Number" },

		["<a-j>"] = { "<cmd>m .+1<cr>==", "Move line Down" },
		["<a-k>"] = { "<cmd>m .-2<cr>==", "Move line up" },

		["<s-h>"] = {
			function()
				if utils.check.vimcmd("BufferLineCyclePrev") then
					vim.cmd("BufferLineCyclePrev")
				else
					vim.cmd("bprev")
				end
			end,
			"Buffer Previous",
		},
		["<s-l>"] = {
			function()
				if utils.check.vimcmd("BufferLineCycleNext") then
					vim.cmd("BufferLineCycleNext")
				else
					vim.cmd("bnext")
				end
			end,
			"Buffer Next",
		},

		["<leader>q"] = { "<cmd>quit!<cr>", "Quit!" },
		["<leader><cr>"] = {
			function()
				utils.set_curdir()
			end,
			"Ch dir",
		},

		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true, silent = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true, silent = true } },

		["<leader>h"] = { "<cmd>nohl<cr>", "No Highlight!" },
		["<leader>a"] = { "gg0vG$", "Select All" },

		["<leader>vv"] = { "<cmd>vsplit<cr>", "vertical split" },
		["<leader>vs"] = { "<cmd>split<cr>", "horizontal split" },

		["<leader>tj"] = { "<cmd>tabn<cr>", "Next Tab" },
		["<leader>tk"] = { "<cmd>tabp<cr>", "Previous Tab" },
		["<leader>tl"] = { "<cmd>tabn<cr>", "Next Tab" },
		["<leader>th"] = { "<cmd>tabp<cr>", "Previous Tab" },

		["<leader>tq"] = { "<cmd>tabclose<cr>", "Close Tab" },
		["<leader>tn"] = { "<cmd>tabnew<cr>", "New Tab" },

		---@diagnostic disable-next-line: undefined-global
		["<leader>ft"] = { utils.filetypeSet, "Set Filetype" },

		-- highlight are in center
		["n"] = { "nzzzv", "Move to center" },
		["N"] = { "Nzzzv", "Moving to center" },
		["x"] = { '"_x', "Register x" },
	},
	v = {
		["<c-s>"] = { "<esc>:w<cr>", "Saving File" },
		["<c-c>"] = { "<esc>", "Escape" },

		["<a-j>"] = { ":m '>+1<cr>gv-gv", "Move Selected Line Down" },
		["<a-k>"] = { ":m '<lt>-2<CR>gv-gv", "Move Selected Line Up" },

		["<"] = { "<gv", "Indent out" },
		[">"] = { ">gv", "Indent in" },

		["<space>"] = { "<Nop>", "Mapped to Nothing" },

		["x"] = { '"_x', "Registers x" },
		["p"] = { '"_dP', "Register p" },
		["P"] = { '"_dP', "Register P" },

		["<leader>y"] = { '"+y', "Register Y" },
		["<leader>d"] = { '"+d', "Register d" },
		["<leader>Y"] = { 'gg"+yG', "Register Y" },
		["<leader>D"] = { 'gg"+dG', "Register D" },
		["<leader>x"] = { '"+x', "Register x" },
		["<leader>X"] = { '"+', "Register X" },
	},
	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
	},
}

M.telescope = {
	n = {
		["<leader>sd"] = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
		["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "Search Find files" },
		["<leader>sF"] = { "<cmd>Telescope find_files hidden=true<cr>", "Find files Hidden Also" },
		["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Search Recent files" },
		["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
		["<leader>ss"] = { "<cmd>Telescope builtin<cr>", "Search Telescope" },
		["<leader>sg"] = { "<cmd>Telescope live_grep<cr>", "Search Live Grep" },
		["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Search Help Tags" },
		["<leader>sb"] = { "<cmd>Telescope buffers<cr>", "Search Buffers" },
		["<leader>sc"] = { "<cmd>Telescope commands<cr>", "Search Commands" },
		["<leader>sm"] = { "<cmd>Telescope marks<cr>", "Search in Media Mode" },
		["<leader>so"] = { "<cmd>Telescope vim_options<cr>", "Search Vim Options" },
		["<leader>sq"] = { "<cmd>Telescope quickfix<cr>", "Search Quickfix" },
		["<leader>sl"] = { "<cmd>Telescope loclist<cr>", "Search Location List" },
		["<leader>sp"] = { "<cmd>Telescope projects<cr>", "Search Projects" },
		["<leader>su"] = { "<cmd>Telescope undo<cr>", "Search undo" },
		["<leader>s/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy Buffer Search" },

		["<leader>sU"] = { "<cmd>UrlView buffer<cr>", "Search Links" },
		["<leader>sC"] = { "<cmd>UrlView buffer action=clipboard<cr>", "Copy Links" },
	},
}

M.notify = {
	n = {
		["<leader>sn"] = { "<cmd>Telescope notify<cr>", "Notifications" },
		["<leader>un"] = {
			function()
				return require("notify").dismiss()
			end,
			"Dismiss Notifications",
		},
	},
}

M.harpoon = {
	n = {
		["<leader>fm"] = { ":lua require('harpoon.mark').add_file()<cr>", "Mark file to harpoon" },
		["<leader>fu"] = { ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon Ui" },
		["<leader>ff"] = { ":Telescope harpoon marks<cr>", "Harpoon Telescope" },
	},
}

M.nvimtree = {
	n = {
		["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
	},
}

M.todo = {
	n = {
		["<leader>st"] = { "<cmd>TodoTelescope<cr>", "Search Todo" },
	},
}

M.gitworktree = {
	n = {
		["<leader>gw"] = {
			"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
			"Git worktree list",
		},
		["<leader>gc"] = {
			"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktrees()<cr>",
			"Git worktree Create",
		},
	},
}

M.mason = {
	n = {
		["<leader>im"] = { "<cmd>Mason<cr>", "Mason" },
	},
}

M.lazy = {
	n = {
		["<leader>iL"] = { "<cmd>Lazy<cr>", "Lazy" },
	},
}

M.lspconfig_saga = {
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
				return require("plugins.configs.lsp").toggle_diagnostics_ghost_text()
			end,
			"Toggle Ghost Text",
		},
		["<leader>lL"] = {
			function()
				return require("plugins.configs.lsp").toggle_diagnostics()
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

M.comment = {
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
	},
}

M.calendar = {
	n = {
		["<leader>uC"] = { "<cmd>Calendar<CR>", "Calender" },
	},
}

M.colorpicker = {
	n = {
		["<leader>uc"] = { "<cmd>PickColor<CR>", "Color Picker" },
	},
}

M.copilot = {
	n = {
		["<leader>C"] = {
			function()
				if vim.g.copilot_status == "running" then
					vim.g.copilot_status = "stopped"
					vim.cmd("Copilot disable")
				else
					vim.g.copilot_status = "running"
					vim.cmd("Copilot enable")
				end
			end,
			"Toggle Copilot",
		},
	},
}

M.bufferline = {
	n = {
		["<leader>bc"] = { "<cmd>bd<cr>", "Buffer Delete" },
		["<leader>bp"] = { "<cmd>BufferLinePick<cr>", "Buffer Pick" },
		["<leader>bP"] = { "<cmd>BufferLineTogglePin<cr>", "Buffer Pin" },
		["<leader>bd"] = { "<cmd>BufferLineSortByDirectory<cr>", "Buffer Sort by dir" },
		["<leader>be"] = { "<cmd>BufferLineSortByExtension<cr>", "Buffer Sort by ext" },
		["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", "Buffer Sort by Tabs" },
		["<leader>bL"] = { "<cmd>BufferLineCloseRight<cr>", "Buffer close all to right" },
		["<leader>bH"] = { "<cmd>BufferLineCloseLeft<cr>", "Buffer close all to left" },
		["<leader><s-h>"] = { "<cmd>BufferLineMovePrev<cr>", "Move buffer to left" },
		["<leader><s-l>"] = { "<cmd>BufferLineMoveNext<cr>", "Move buffer to right" },
	},
}

M.rest = {
	n = {
		["<leader>rr"] = { "<plug>RestNvim<cr>", "Rest run" },
		["<leader>rp"] = { "<plug>RestNvimPreview<cr>", "Rest run" },
		["<leader>rl"] = { "<plug>RestNvimLast<cr> ", "Rest run" },
	},
}

M.persisted = {
	n = {
		["<leader>Sd"] = { "<cmd>SessionLoad<CR>", "Dir Session" },
		["<leader>Sq"] = { "<cmd>SessionDelete<CR>", "Session Delete" },
		["<leader>S."] = { "<cmd>SessionLoadLast<CR>", "Last Session" },
		["<leader>Ss"] = { "<cmd>Telescope persisted<CR>", "Telescope sessions" },
	},
}

M.markdown_glow = {
	n = {
		["<leader>fMg"] = { "<cmd>Glow<cr>", "Markdwon Preview Glow" },
	},
}
M.markdown = {
	n = {
		["<leader>fMb"] = { "<cmd>MarkdownPreview<cr>", "Markdwon Preview Browser" },
	},
}

M.zen = {
	n = {
		["<leader>uz"] = { "<cmd>ZenMode<CR>", "ZenMode" },
	},
}

M.dap_ui = {
	n = {

		["<leader>db"] = { "<cmd>DapToggleBreakpoint<CR>", "Dap Toggle Breakpoint" },
		["<leader>dc"] = { "<cmd>DapContinue<CR>", "Continue Debugger" },
		["<leader>duu"] = { "<cmd>lua require('dapui').toggle()<cr>", "Open Dap ui" },

		["<leader>dus"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"Open Debugger sidebar",
		},
	},
}

M.alpha = {
	n = {
		["<leader>;"] = { "<cmd>Alpha<CR>", desc = "Dashboard" },
	},
}

M.ufo = {
	n = {
		["zR"] = {
			function()
				require("ufo").openAllFolds()
			end,
			"Open all folds",
		},
		["zM"] = {
			function()
				require("ufo").closeAllFolds()
			end,
			"Add Yaml Tags",
		},
		["zK"] = {
			function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					-- choose one of coc.nvim and nvim lsp
					-- vim.fn.CocActionAsync("definitionHover") -- coc.nvim
					vim.lsp.buf.hover()
				end
			end,
			"Peek Folded Lines",
		},
	},
}

------- Languages based
M.go = {
	n = {
		["<leader>Lgsj"] = { "<cmd>GoTagAdd json<CR>", "Add Json Tags" },
		["<leader>Lgsy"] = { "<cmd>GoTagAdd yaml<CR>", "Add Yaml Tags" },
	},
}

return M
