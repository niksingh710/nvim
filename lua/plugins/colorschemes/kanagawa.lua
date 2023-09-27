return {
	"rebelot/kanagawa.nvim",
	opts = {
		compile = false, -- enable compiling the colorscheme
		undercurl = true, -- enable undercurls
		commentStyle = { italic = true },
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { bold = true },
		typeStyle = {},
		transparent = config.transparent, -- do not set background color
		dimInactive = true, -- dim inactive window `:h hl-NormalNC`
		terminalColors = true, -- define vim.g.terminal_color_{0,17}
		colors = { -- add/modify theme and palette colors
			palette = {},
			theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
		},
		overrides = function(colors) -- add/modify highlights
			local theme = colors.theme
			return {
				TelescopeTitle = { fg = theme.ui.special, bold = true },
				DapBreakpoint = { fg = "#993939" },
				DapLogPoint = { fg = "#61afef" },
				DapStopped = { fg = "#98c379" },
				TelescopeMatching = { fg = "#E99804" },
				TelescopeSelection = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1, bold = true },
				TelescopePromptPrefix = { bg = theme.ui.bg_m1 },
				TelescopePromptNormal = { bg = theme.ui.bg_m1 },
				TelescopeResultsNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePromptBorder = { bg = theme.ui.bg_m1, fg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				TelescopePromptTitle = { bg = "#227700", fg = theme.ui.bg_dim },
				TelescopeResultsTitle = { fg = theme.ui.bg_dim },
				TelescopePreviewTitle = { bg = theme.ui.green, fg = theme.ui.bg_dim },
				SLGreen = { fg = "#00ff00" },
				SLGitIcon = { fg = "#E99804" },
			}
		end,
		theme = "dragon", -- Load "wave" theme when 'background' option is not set
		background = { -- map the value of 'background' option to a theme
			dark = "dragon", -- try "dragon" !
			light = "lotus",
		},
	},
}
