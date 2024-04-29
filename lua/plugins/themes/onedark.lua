return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- custom options here
      transparent = true,
      style = "darker",
      code_style = {
        comments = "italic",
        keywords = "bold",
        functions = "bold",
        strings = "none",
        variables = "none",
      },
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
      colors = {
        bg = "#282c34",
        fg = "#abb2bf",
        yellow = "#e0af68",
        cyan = "#56b6c2",
        darkblue = "#081633",
        green = "#98c379",
        orange = "#d19a66",
        violet = "#a9a1e1",
        magenta = "#c678dd",
        blue = "#61afef",
        red = "#e86671",
      },
      highlights = {
        TelescopeMatching = { fg = '$orange' },
        TelescopeSelection = { fg = '$fg', bg = '$bg1', bold = true },
        TelescopePromptPrefix = { bg = '$bg1' },
        TelescopePromptNormal = { bg = '$bg1' },
        TelescopeResultsNormal = { bg = '$bg0' },
        TelescopePreviewNormal = { bg = '$bg0' },
        TelescopePromptBorder = { bg = '$bg1', fg = '$bg1' },
        TelescopeResultsBorder = { bg = '$bg0', fg = '$bg0' },
        TelescopePreviewBorder = { bg = '$bg0', fg = '$bg0' },
        TelescopePromptTitle = { bg = '$purple', fg = '$bg0' },
        TelescopeResultsTitle = { fg = '$bg0' },
        TelescopePreviewTitle = { bg = '$green', fg = '$bg0' },

        PMenu = { bg = "none" }, -- make cmp menu transparent
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts) -- calling setup is optional
      require("onedark").load()
    end,
  },
}
