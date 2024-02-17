return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  opts = {},
  cmd = { "TodoTelescope" },
  keys = { { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search Todo" } },
}
