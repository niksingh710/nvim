return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "WinEnter" },
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    options = {
      left_trunc_marker = icons.ui.ArrowCircleLeft,
      right_trunc_marker = icons.ui.ArrowCircleRight,
      truncate_names = true,
      offsets = {
        {
          filetype = "undotree",
          text = "Undotree",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "DiffviewFiles",
          text = "Diff View",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          highlight = "PanelHeading",
        },
        {
          filetype = "lazy",
          text = "Lazy",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
    },
  },
  keys = {

    {
      "<s-h>",
      function()
        if utils.check.vimcmd("BufferLineCyclePrev") then
          vim.cmd("BufferLineCyclePrev")
        else
          vim.cmd("bprev")
        end
      end,
      desc = "Buffer Previous",
    },
    {
      "<s-l>",
      function()
        if utils.check.vimcmd("BufferLineCycleNext") then
          vim.cmd("BufferLineCycleNext")
        else
          vim.cmd("bnext")
        end
      end,
      desc = "Buffer Next",
    },
    { "<leader>bc", "<cmd>bd<cr>", desc = "Buffer Delete" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Buffer Pick" },
    { "<leader>bP", "<cmd>BufferLineTogglePin<cr>", desc = "Buffer Pin" },
    { "<leader>bd", "<cmd>BufferLineSortByDirectory<cr>", desc = "Buffer Sort by dir" },
    { "<leader>be", "<cmd>BufferLineSortByExtension<cr>", desc = "Buffer Sort by ext" },
    { "<leader>bt", "<cmd>BufferLineSortByTabs<cr>", desc = "Buffer Sort by Tabs" },
    { "<leader>bL", "<cmd>BufferLineCloseRight<cr>", desc = "Buffer close all to right" },
    { "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Buffer close all to left" },
    { "<leader><s-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer to left" },
    { "<leader><s-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer to right" },
  },
}
