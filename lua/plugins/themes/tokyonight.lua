return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    on_highlights = function(highlights, colors)
      return {
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

        PMenu = { bg = "none" }, -- make cmp menu transparent
      }
    end, -- extend highlights
  },
  config = function(_, opts)
    require("tokyonight").setup(opts) -- calling setup is optional
  end,
}
