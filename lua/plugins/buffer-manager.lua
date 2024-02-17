return {
  "j-morano/buffer_manager.nvim",
  event = { "BufReadPre", "WinEnter" },
  keys = {
    {
      "<leader>bm",
      ":lua require('buffer_manager.ui').toggle_quick_menu()<cr>",
      desc = "Toggle buffer manager",
    },
  },
}
