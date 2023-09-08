return {
			"NvChad/nvim-colorizer.lua",
			lazy = false,
      enabled = config.nvim_colorizer,
			opts = {
				filetypes = config.colorizer.filetypes or {},
				user_default_options = {
					RGB = true,
					RRGGBB = true,
					names = true,
					RRGGBBAA = true,
					AARRGGBB = true,
					rgb_fn = true,
					hsl_fn = true,
					css = true,
					css_fn = true,
					mode = "background",
					tailwind = true,
					sass = { enable = true, parsers = { "css" } },
					virtualtext = "■",
					always_update = false,
				},
			},
		}
