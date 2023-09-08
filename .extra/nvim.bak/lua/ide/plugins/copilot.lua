local cok, copilot = pcall(require, "copilot")
if not cok then
	return
end

local opts = {
	filetypes = {
		yaml = true,
		markdown = true,
		help = true,
		gitcommit = true,
		gitrebase = true,
		hgcommit = true,
		svn = true,
		cvs = true,
		["."] = true,
	},
	suggestion = {
		enable = true,
		auto_trigger = true,
		keymap = {
			accept = "<c-l>",
			next = "<c-]>",
			prev = "<c-[>",
			dismiss = "<C-e>",
		},
	},
}

copilot.setup(opts)

if wstatus then
	opts = {
		prefix = "<leader>",
	}

	local mapping = {
		u = {
			name = "Utils",
			-- c = {
				-- name = "Copilot",
				s = { "<cmd>Copilot status<cr>", "Copilot Status" },
				d = { "<cmd>Copilot disable<cr>", "Copilot Disable" },
				c = { "<cmd>Copilot enable<cr>", "Copilot Enable" },
			-- },
		},
	}

	whichkey.register(mapping, opts)
end
