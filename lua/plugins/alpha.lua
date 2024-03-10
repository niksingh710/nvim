return {
  "goolord/alpha-nvim",
  enabled = dashboard_or_alpha,
  event = { "WinEnter", "BufEnter" },

  config = function()
    local entries = {
      { "c", icons.ui.Gear .. " Configuration", ":Telescope find_files cwd=~/.config/nvim<cr>" },
    }

    if utils.check.file_exists(os.getenv("HOME") .. "/.config/hypr/hyprland.conf") then
      table.insert(entries, {
        "h",
        icons.ui.Target .. "  Hyprland Config",
        ":Telescope find_files cwd=~/.config/hypr/hyprland.conf <CR>",
      })
    end

    if utils.check.file_exists(os.getenv("HOME") .. "/.config/waybar/bars/top.json") then
      table.insert(entries, {
        "w",
        "  Waybar Config",
        ":Telescope find_files cwd=~/.config/waybar/bars/top.json <CR>",
      })
    end

    table.insert(entries, { "f", icons.ui.Watches .. "  Find file", ":Telescope find_files <CR>" })
    table.insert(entries, { "p", icons.ui.Folder .. "  Find project", ":Telescope projects <CR>" })
    table.insert(entries, { "r", icons.ui.History .. "  Recently used files", ":Telescope oldfiles <CR>" })
    table.insert(entries, { ".", "  Last Session", "<cmd>SessionManager load_last_session<cr>" })
    table.insert(entries, { "d", "  Last Session of Dir", "<cmd>SessionManger load_current_dir_session<cr>" })
    table.insert(entries, { "s", "  Session List", "<cmd>SessionManager load_session<cr>" })

    table.insert(entries, { "q", icons.ui.BoldClose .. "  Quit Neovim", ":qa<CR>" })
    local toggle_bufferline = vim.api.nvim_create_augroup("ToggleBufferline", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      callback = function()
        vim.o.showtabline = 0
        vim.o.laststatus = 0
      end,
      group = toggle_bufferline,
      pattern = "AlphaReady",
    })
    vim.api.nvim_create_autocmd("BufUnload", {
      callback = function()
        vim.o.showtabline = 2
        vim.o.laststatus = 2
      end,
      group = toggle_bufferline,
      pattern = "*",
    })

    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local btns = {}

    for _, entry in ipairs(entries) do
      table.insert(btns, dashboard.button(entry[1], entry[2], entry[3]))
    end

    local function footer()
      return "Don't Stop Until You are Proud..."
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.buttons.val = btns
    local vok, val = pcall(require, "ascii-headers")
    if vok then
      dashboard.section.header.val = val
    end
    alpha.setup(dashboard.config)
  end,
}
