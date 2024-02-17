return {
  "numToStr/Comment.nvim",
  config = true,
  event = "BufEnter",
  keys = {
    {
      "<leader>/",
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      desc = "Toggle comment",
    },

    {
      "<leader>/",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = "Toggle comment",
      mode = "v",
    },
  },
}
