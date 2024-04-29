return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    keys = {
      { "<leader>umb", "<cmd>MarkdownPreview<cr>", desc = "Markdwon Preview Browser" },
    },
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    ft = "markdown",
    keys = {
      { "<leader>ump", "<cmd>Glow<cr>", desc = "Markdwon Preview" },
    },
  },
  {
    "ixru/nvim-markdown",
    enabled = false,
    ft = "markdown",
    init = function()
      vim.cmd([[
      let g:vim_markdown_conceal = 2
      ]])
    end,
  },
  {
    "prurigro/vim-markdown-concealed",
    enabled = false,
    ft = "markdown",
  },
  {
    "yaocccc/nvim-hl-mdcodeblock.lua",
    after = "nvim-treesitter",
    ft = "markdown",
    main = "hl-mdcodeblock",
    opts = {},
  },
}
