-- This is a set of plugins that other plugins may require or need.
return {
  { "farmergreg/vim-lastplace", lazy = false },
  { "nvim-lua/plenary.nvim" }, -- Some plugins require the functions from this plugin
  { "folke/neodev.nvim", config = true }, -- neodev setups neovim development environment give neovim development API
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
    version = "*",
    config = true,
    event = { "InsertLeave", "BufEnter" },
  },
  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  {
    "mskelton/termicons.nvim",
    enabled = false,
    requires = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = true,
  },
  {
    "anuvyklack/windows.nvim",
    event = "WinEnter",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    keys = {
      { "<c-w>=", "<cmd>WindowsEqualize<cr>", desc = "Equalize windows" },
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
  {
    "folke/drop.nvim",
    enabled = false,
    event = "VimEnter",
    config = function()
      require("drop").setup()
    end,
  },
  {
    "axieax/urlview.nvim",
    opts = {
      default_title = "Links:",
      default_prefix = "https://",
      default_action = "system",
    },
    keys = {
      { "<leader>sU", "<cmd>UrlView buffer<cr>", desc = "Search Links" },
      { "<leader>sC", "<cmd>UrlView buffer action=clipboard<cr>", desc = "Copy Links" },
    },
  },
}
