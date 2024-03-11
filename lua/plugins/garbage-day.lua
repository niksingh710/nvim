return {
  -- TODO: if fork merged fix the url
  "niksingh710/garbage-day.nvim",
  -- dir = "~/repos/garbage-day.nvim/",
  dependencies = "neovim/nvim-lspconfig",
  event = "BufEnter",
  opts = {
    aggressive_mode = true,
    -- grace_period = 3,
    ignore_ft = {
      "NvimTree",
    },
  },
}
