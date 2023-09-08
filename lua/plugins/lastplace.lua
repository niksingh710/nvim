return {
			"ethanholz/nvim-lastplace",
			event = "BufRead",
      enabled = config.nvim_lastplace,
			lazy = false,
			opts = {
				lastplace_ignore_buftype = { "quickfix", "nofile", "help", "alpha" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			},
		}
