return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  enabled = not dashboard_or_alpha,
  opts = {
    hide = {
      tabline = false,
    },
    disable_move = true,
    -- shortcut_type = "number",
    config = {
      center = {},
      disable_move = true,
      project = { enable = false },
      shortcut = {
        {
          desc = icons.ui.History .. " Recent Files",
          group = "String",
          key = "r",
          action = "Telescope oldfiles",
        },
        {
          desc = icons.ui.Files .. " Find Files",
          group = "String",
          key = "f",
          action = "Telescope find_files",
        },
        {
          desc = icons.ui.BoxChecked .. " Configuration",
          group = "DiagnosticWarn",
          key = "c",
          action = "Telescope find_files cwd=~/.config/nvim",
        },
        {
          desc = " Last Session",
          group = "DiagnosticHint",
          key = ".",
          action = "SessionManager load_last_session",
        },
        {
          desc = " List Session",
          group = "DiagnosticHint",
          key = "l",
          action = "SessionManager load_session",
        },
        -- {
        --   desc = icons.ui.BoldClose .. " Quit",
        --   group = "DiagnosticError",
        --   key = "q",
        --   action = "qa",
        -- },
      },
    },
  },
  config = function(_, opts)
    local vok, val = pcall(require, "ascii-headers")
    if vok then
      opts.config.header = val
    end

    local function footer()
      return { "", "", "Don't Stop Until You are Proud..." }
    end

    opts.config.footer = footer()

    require("dashboard").setup(opts)
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
