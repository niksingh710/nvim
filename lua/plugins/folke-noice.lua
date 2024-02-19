return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
      progress = {
        enabled = false,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      opts = {
        split = true,
        background_colour = "#000000",
        render = "compact",
        stages = "fade_in_slide_out",
        top_down = true,
      },
      keys = {
        { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Notifications" },
        {
          "<leader>uN",
          function()
            local notify = require("notify")

            local lines = {}
            for _, notif in ipairs(notify.history()) do
              table.insert(
                lines,
                ("%s %s: %s"):format(notif.title[1], notif.title[2], table.concat(notif.message, "\n"))
              )
            end
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.cmd("vsplit")
            vim.api.nvim_win_set_buf(0, buf)
          end,
          desc = "Notifications",
        },
        {
          "<leader>un",
          function()
            return require("notify").dismiss()
          end,
          desc = "Dismiss Notifications",
        },
      },
    },
  },
}
