return {
  "b0o/schemastore.nvim", -- Adds schemas for (`package.json`, `config.yml` ... etc)
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPost",
    config = function()
      require("mason").setup({
        ui = {
          border = border or "rounded",
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
          },
        },
        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },

        max_concurrent_installers = 10,
      })
      require("plugins.lsp.setup").run()

      local masonlsp = require("mason-lspconfig")
      handlers = require("plugins.lsp.setup").handlers() or {}
      for key, _ in pairs(handlers) do
        if type(key) == "string" then
          table.insert(lang.server.list, key)
        end
      end

      masonlsp.setup({
        ensure_installed = lang.server.list or {},
        automatic_installation = true,
        handlers = handlers,
      })
    end,
    dependencies = {
      {
        "williamboman/mason.nvim",
        keys = {
          { "<leader>im", ":Mason<cr>", desc = "Mason" },
        },
      },
      "neovim/nvim-lspconfig",
      {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        opts = {
          scroll_preview = {
            scroll_down = "<C-d>",
            scroll_up = "<C-u>",
          },
          lightbulb = {
            enable = false, -- disables both
            virtual_text = false, -- disables just the one at the end of the line
          },
          ui = {
            border = border or "rounded",
          },
          outline = {
            keys = {
              jump = "<cr>",
            },
          },
          code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 20,
            virtual_text = true,
          },
        },
        dependencies = {
          "nvim-treesitter/nvim-treesitter", -- optional
          "nvim-tree/nvim-web-devicons", -- optional
        },
      },
    },
  },
}
