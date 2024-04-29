return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    window = {
      border = border or "rounded",
    },
    layout = {
      align = "center",
      height = {
        min = 1,
      },
    },
  },
  config = function(opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      f = "Files/Harpoon",
      b = "Buffers",
      g = "Git",
      i = "Info",
      l = "Lsp",
      r = "Rest/API",
      S = "Session",
      s = "Search/Telescope",
      t = "Tabs/Tex",
      u = "Utils",
      v = "Splits",
    }, {
      mode = "n",
      prefix = "<leader>",
    })
  end,
}
