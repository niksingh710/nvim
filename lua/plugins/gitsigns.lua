return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  ft = { "gitcommit", "diff" },
  init = function()
    -- load gitsigns only when a git file is opened
    -- TODO: Fix this for softly linked directories.
    vim.api.nvim_create_autocmd({ "BufRead" }, {
      group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
      callback = function()
        vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
        if vim.v.shell_error == 0 then
          vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
          vim.schedule(function()
            require("lazy").load({ plugins = { "gitsigns.nvim" } })
          end)
        end
      end,
    })
  end,
  keys = {

    --Git
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",    desc = "Next Hunk" },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",    desc = "Prev Hunk" },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",   desc = "Blame" },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",   desc = "Reset Hunk" },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",   desc = "Stage Hunk" },
    {
      "<leader>gs",
      "<cmd>lua require 'gitsigns'.stage_hunk({vim.fn.line('.'),vim.fn.line('v')})<cr>",
      mode = "v",
      desc = "Stage Hunk",
    },
    {
      "<leader>gu",
      "<cmd>lua require 'gitsigns'.undo_stage_hunk({vim.fn.line('.'),vim.fn.line('v')})<cr>",
      mode = "v",
      desc = "undo Hunk",
    },

    {
      "<leader>gr",
      "<cmd>lua require 'gitsigns'.reset_hunk({vim.fn.line('.'),vim.fn.line('v')})<cr>",
      mode = "v",
      desc = "Reset Hunk",
    },

    {
      "<leader>gu",
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      desc = "Undo Stage Hunk",
    },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
  },
  opts = {
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = icons.ui.LineLeft,
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = icons.ui.LineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = icons.ui.LineLeft,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = icons.ui.Triangle,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
  },
}
