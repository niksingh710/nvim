return {
  "nvim-treesitter/nvim-treesitter",
  enabled = config.nvim_treesitter,
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = config.ensure.treesitter or {},
    auto_install = true,
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = true,
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

