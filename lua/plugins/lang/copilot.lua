return {
	"zbirenbaum/copilot.lua",
  lazy = false,
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
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
	},
  keys = {

		{ "<leader>us", "<cmd>Copilot status<CR>", desc = "Copilot status" },
		{ "<leader>ud", "<cmd>Copilot disable<CR>", desc = "Copilot disable" },
		{ "<leader>ue", "<cmd>Copilot enable<CR>", desc = "Copilot enable" },
  },
}
