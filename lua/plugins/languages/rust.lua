return {
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },
  {
    "Saecki/crates.nvim",
    ft = { "rust", "toml" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("crates").setup({
        autoupdate = true,
      })
      require("crates").show()
    end,
  },
}
