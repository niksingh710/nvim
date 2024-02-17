return {
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    keys = {
      { "<leader>uz", "<cmd>ZenMode<CR>", desc = "ZenMode" },
    },
    opts = {
      plugins = {
        tmux = { enabled = true },
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {},
    cmd = { "Twilight" },
    keys = {
      { "<leader>ut", "<cmd>Twilight<CR>", desc = "Twilight Mode" },
    },
  },
}
