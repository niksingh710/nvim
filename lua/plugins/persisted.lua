return {
	"olimorris/persisted.nvim",
  enabled = config.persisted,
	lazy = false,
	config = function()
		local persisted = require("persisted")
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
		require("telescope").load_extension("persisted")
	end,
	keys = {

		{ "<leader>Sd", "<cmd>SessionLoad<CR>", desc = "Dir Session" },
		{ "<leader>Sq", "<cmd>SessionDelete<CR>", desc = "Session Delete" },
		{ "<leader>S.", "<cmd>SessionLoadLast<CR>", desc = "Last Session" },
		{ "<leader>Sl", "<cmd>Telescope Persisted<CR>", desc = "Telescope sessions" },
	},
}
