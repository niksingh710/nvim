if not wstatus then
	vim.notify("failed to load whichkey", vim.log.levels.ERROR)
	return
end

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
	mapping.u.u = { vim.cmd.UndotreeToggle, "UndoTree" }
end

if utils.check.vimcmd("ZenMode") then
	mapping.u.z = { "<cmd>ZenMode<cr>", "ZenMode" }
end
if utils.check.vimcmd("ASToggle") then
	mapping.u.a = { "<cmd>ASToggle<cr>", "Auto Save Toggle" }
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

if pcall(require, "harpoon") then
	mapping.f = {
		name = "files",
		m = {
			":lua require('harpoon.mark').add_file()<cr>",
			"Mark file to harpoon",
		},
		u = {
			":lua require('harpoon.ui').toggle_quick_menu()<cr>",
			"Mark file to harpoon",
		},
		f = {
			":Telescope harpoon marks<cr>",
			"Mark file to harpoon",
		},
	}
end

whichkey.register(mapping, opts)
