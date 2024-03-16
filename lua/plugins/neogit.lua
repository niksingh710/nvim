return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  ft = { "gitcommit", "diff" },
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true,
  keys = {
    { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
}
