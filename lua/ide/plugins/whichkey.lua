if wstatus then
	local opts = {
		prefix = "<leader>",
	}

	local mapping = {
		u = {
			name = "Utils",
		},
		L = {
			name = "Languages",
		},
	}

	if utils.check.vimcmd("UrlView") then
		mapping.u.l = {
			l = { "<cmd>UrlView buffer<cr>", "Search Links" },
			c = { "<cmd>UrlView buffer action=clipboard<cr>", "Copy Links" },
		}
    mapping.u.u ={ vim.cmd.UndotreeToggle, "UndoTree" } 
	end

	if utils.check.vimcmd("ZenMode") then
		mapping.u.z = { "<cmd>ZenMode<cr>", "ZenMode" }
	end

	if pcall(require, "gopher") then
		mapping.L = {
			g = {
				name = "Gopher",
				s = {
					name = "Struct",
					j = {
						"<cmd>GoTagAdd json<cr>",
						"Add json tag",
					},
					y = {
						"<cmd>GoTagAdd yaml<cr>",
						"Add yaml tag",
					},
				},
			},
		}
	end

	whichkey.register(mapping, opts)
end
