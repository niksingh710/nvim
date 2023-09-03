local pok, persisted = pcall(require, "persisted")
if not pok then
	return
end
local rtimedir = os.getenv("XDG_RUNTIME_DIR")
local opts = {
	autosave = true,
	should_autosave = function()
		-- do not autosave if the alpha dashboard is the current filetype
		if vim.bo.filetype == "alpha" or vim.bo.filetype == "" or vim.bo.filetype == "NvimTree" then
			return false
		end
		return true
	end,
	ignored_dirs = {
		rtimedir .. "/firenvim",
	},
}
persisted.setup(opts)

if wstatus then
	opts = {
		prefix = "<leader>",
	}

	local mapping = {
		S = {
			name = "Sessions",
			d = { "<cmd>SessionLoad<cr>", "Restore last session for current dir" },
			q = { "<cmd>SessionDelete<cr>:quit!<cr>", "Quit without saving session" },
			l = { "<cmd>Telescope persisted<cr>", "Search Seasson" },
			["."] = { "<cmd>SessionLoadLast<cr>", "Restore last Session" },
		},
	}

	whichkey.register(mapping, opts)
end

local tok, telescope = pcall(require, "telescope")
if tok then
	telescope.load_extension("persisted")
end
