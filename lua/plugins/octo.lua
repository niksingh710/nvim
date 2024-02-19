return {
  "pwntester/octo.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- OR 'ibhagwan/fzf-lua',
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    suppress_missing_scope = {
      projects_v2 = true,
    },
  },
}
