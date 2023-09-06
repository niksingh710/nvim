local mlok, mason_dap = pcall(require, "mason-nvim-dap")
if not mlok then
	vim.notify("For some reason failed to Mason Lsp Config")
	return
end

require("mason-nvim-dap").setup({
	ensure_installed = config.ensure.nvim_dap or {},
})
if wstatus then
	local mapping = {
		d = {
			name = "Debug",
			b = { "<cmd>DapToggleBreakpoint<cr>", "Add BreakPoint to the line" },
			c = { "<cmd>DapContinue<cr>", "Continue Debugger" },
			u = {
				name = "Ui",
				s = {
					function()
						local widgets = require("dap.ui.widgets")
						local sidebar = widgets.sidebar(widgets.scopes)
						sidebar.open()
					end,
					"Open Debugger Side bar",
				},
			},
		},
	}
	local opts = {
		prefix = "<leader>",
	}

	whichkey.register(mapping, opts)
end

local dok, dgo = pcall(require, "dap-go")
if dok then
	dgo.setup()
	if wstatus then
		local mapping = {
			g = {
				name = "Go",
				t = { function ()
				  require("dap-go").debug_test()
				end, "Debug go test" },
				l = {
				  function ()
				    require("dap-go").debug_last()
				  end,
          "Debug last",
				},
			},
		}
		local opts = {
			prefix = "<leader>d",
		}


		whichkey.register(mapping, opts)
	end
end
