return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "null-ls",
    opts = {},
    keys = {
      { "<leader>in", ":NullLsInfo<cr>", desc = "Mason" },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = lang.none_ls.list or {},
      automatic_installation = true,
      handlers = vim.tbl_deep_extend("force", lang.none_ls.handlers or {}, {
        function(source, methods)
          -- custom logic
          require("mason-null-ls").default_setup(source, methods) -- to maintain default behavior
        end,
      }),
    },
  },
}
