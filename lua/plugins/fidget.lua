return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  opts = {
    progress = {
      display = {
        progress_icon = { pattern = "moon" },
      },
    },
    notification = {
      window = {
        relative = "editor", -- where to anchor, either "win" or "editor"
        winblend = 0, -- &winblend for the window
        border = "none", -- style of border for the fidget window
      }, -- options
    },
  },
}

