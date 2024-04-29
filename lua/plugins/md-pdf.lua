return {
  "arminveres/md-pdf.nvim",
  branch = "main", -- you can assume that main is somewhat stable until releases will be made
  -- branch = "fix/echo-loop", -- you can assume that main is somewhat stable until releases will be made
  lazy = true,
  keys = {
    {
      "<leader>umP",
      function()
        require("md-pdf").convert_md_to_pdf()
      end,
      desc = "Markdown preview PDF",
    },
  },
  opts = {
    toc = false,
  },
}
