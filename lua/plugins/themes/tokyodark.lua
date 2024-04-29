return {
  {
    "tiagovla/tokyodark.nvim",
    -- enabled = false,
    priority = 1000,
    lazy = false,
    opts = {
      -- custom options here
      transparent_background = true,
      gamma = 1.00,                      -- adjust the brightness of the theme
      styles = {
        comments = { italic = true },    -- style for comments
        keywords = { italic = true },    -- style for keywords
        identifiers = { italic = true }, -- style for identifiers
        functions = {},                  -- style for functions
        variables = {},                  -- style for variables
      },
      terminal_colors = true,
      custom_highlights = function(highlights, colors)
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
          CmpItemKindField = { bg = colors.red, fg = colors.bg0 },

          PMenu = { bg = "none" }, -- make cmp menu transparent
        }
      end,                         -- extend highlights
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme tokyodark]])
    end,
  },
}
