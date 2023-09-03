if wstatus then
	local opts = {
		prefix = "<leader>",
	}

	local mapping = {
		u = {
			name = "Utils",
		},
	}

	if utils.check.vimcmd("UrlView") then
		mapping.u.u = { "<cmd>UrlView buffer<cr>", "Search Links" }
		mapping.u.c = { "<cmd>UrlView buffer action=clipboard<cr>", "Search Links" }
	end

	whichkey.register(mapping, opts)
end
