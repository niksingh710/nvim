return {
	"tiagovla/tokyodark.nvim",
	enabled = config.tokyodark,
	opts = {
		custom_highlights = function(_, palette)
			return {
				TelescopeMatching = { fg = palette.orange },
				TelescopeSelection = { fg = palette.fg, bg = palette.bg1, bold = true },
				TelescopePromptPrefix = { bg = palette.bg1 },
				TelescopePromptNormal = { bg = palette.bg1 },
				TelescopeResultsNormal = { bg = palette.bg0 },
				TelescopePreviewNormal = { bg = palette.bg0 },
				TelescopePromptBorder = { bg = palette.bg1, fg = palette.bg1 },
				TelescopeResultsBorder = { bg = palette.bg0, fg = palette.bg0 },
				TelescopePreviewBorder = { bg = palette.bg0, fg = palette.bg0 },
				TelescopePromptTitle = { bg = palette.purple, fg = palette.bg0 },
				TelescopeResultsTitle = { fg = palette.bg0 },
				TelescopePreviewTitle = { bg = palette.green, fg = palette.bg0 },
				SLGreen = { fg = palette.green },
				SLGitIcon = { fg = palette.orange },
			}
		end,
	},
}
