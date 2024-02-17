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
