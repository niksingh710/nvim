return {
			"axieax/urlview.nvim",
      enabled = config.urlview,
			lazy = false,
			opts = {
				default_title = "Links:",
				default_picker = "native",
				default_prefix = "https://",
				default_action = "system",
			},
      keys = {
	  {"<leader>ul", "<cmd>UrlView buffer<cr>", desc="Search Links" },
		{"<leader>uc", "<cmd>UrlView buffer action=clipboard<cr>",desc= "Copy Links" },
      },
		}
