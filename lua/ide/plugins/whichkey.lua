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
		mapping.u.U = { "<cmd>UrlView buffer action=clipboard<cr>", "Copy Links" }
	end

	if utils.check.vimcmd("ZenMode") then
		mapping.u.z = { "<cmd>ZenMode<cr>", "ZenMode" }
	end


	whichkey.register(mapping, opts)
end
