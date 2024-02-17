return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  keys = {
    {
      "<leader>uc",
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
}
