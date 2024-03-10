return {
  "Shatur/neovim-session-manager",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- event = "VeryLazy",
  lazy = false,
  opts = {
    autoload_mode = false,
  },
  keys = {
    { "<leader>S.", "<cmd>SessionManager load_last_session<CR>", desc = "Last Session" },
    { "<leader>Sl", "<cmd>SessionManager load_session<CR>", desc = "List Session" },
    { "<leader>Sd", "<cmd>SessionManager load_current_dir_session<CR>", desc = "Curr Dir load" },
    { "<leader>Ss", "<cmd>SessionManager save_current_session<CR>", desc = "Save Session" },
    { "<leader>SD", "<cmd>SessionManager delete_session<CR>", desc = "Delete sessions" },
  },
}
