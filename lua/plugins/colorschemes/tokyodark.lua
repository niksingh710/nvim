return {
	"tiagovla/tokyodark.nvim",
	enabled = config.tokyodark,
	opts = {
		custom_highlights = function(hl, palette)
			local groups = {
				"Normal",
				"NormalFloat",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLineNr",
				"EndOfBuffer",
			}
			hl["Normal"].bg = palette.none
			for _, group in ipairs(groups) do
				if hl[group] ~= nil then
					hl[group].bg = palette.none
				end
			end

			return {
				DapBreakpoint = { fg = "#993939" },
				DapLogPoint = { fg = "#61afef" },
				DapStopped = { fg = "#98c379" },
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
	config = function(_, opts)
		require("tokyodark").setup(opts)
		require("tokyodark").colorscheme()
	end,
}
