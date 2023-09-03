-- global config {{{
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
-- }}}

local theme_status, tokyodark = pcall(require, "tokyodark")
if theme_status then
	vim.cmd("colorscheme tokyodark")
end

---@diagnostic disable: undefined-field
local transparent_status, transparent = pcall(require, "transparent")
if transparent_status then
	transparent.setup({
		extra_groups = {
			"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
			"NvimTreeNormal", -- NvimTree
		},
		lualine_style = "default",
		-- lualine_style = "stealth",
	})

	if config.transparent then
		vim.cmd("TransparentEnable")
	end
end

-- Telescope Material Theming using the palette from tokyodark
if theme_status then
	local colors = require("tokyodark.palette")

	local TelescopeColor = {
		TelescopeMatching = { fg = colors.orange },
		TelescopeSelection = { fg = colors.fg, bg = colors.bg1, bold = true },
		TelescopePromptPrefix = { bg = colors.bg1 },
		TelescopePromptNormal = { bg = colors.bg1 },
		TelescopeResultsNormal = { bg = colors.bg0 },
		TelescopePreviewNormal = { bg = colors.bg0 },
		TelescopePromptBorder = { bg = colors.bg1, fg = colors.bg1 },
		TelescopeResultsBorder = { bg = colors.bg0, fg = colors.bg0 },
		TelescopePreviewBorder = { bg = colors.bg0, fg = colors.bg0 },
		TelescopePromptTitle = { bg = colors.purple, fg = colors.bg0 },
		TelescopeResultsTitle = { fg = colors.bg0 },
		TelescopePreviewTitle = { bg = colors.green, fg = colors.bg0 },
	}

	for hl, col in pairs(TelescopeColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end
