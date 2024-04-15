return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
      {
        "<leader>ucc",
        function()
          if vim.g.copilot_status == nil then
            vim.g.copilot_status = "running"
          end
          if vim.g.copilot_status == "running" then
            vim.g.copilot_status = "stopped"
            vim.cmd("Copilot disable")
          else
            vim.g.copilot_status = "running"
            vim.cmd("Copilot enable")
          end
        end,
        desc = "Toggle Copilot",
      },
    },
    opts = {
      filetypes = {
        yaml = false,
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      suggestion = {
        enable = true,
        auto_trigger = true,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
