local M = {}

M.colorizer = {
  "json",
  "css",
  "javascriptreact",
  "javascript",
  "lua",
  "markdown",
  "md",
  "tmux",
  html = { mode = "foreground" },
  cmp_docs = { always_update = true },
}
M.none_ls = {
  list = {
    "stylua",
    -- "prettierd",
    "shfmt",
    "eslint",
    "shellcheck",
    "ruff",
    "biome",
    "eslint_d",
  },
  handlers = {
    shfmt = function(source_name, methods)
      local null_ls = require("null-ls")
      null_ls.register(null_ls.builtins.formatting.shfmt.with({
        filetypes = { "sh" },
        generator_opts = {
          command = "shfmt",
          args = { "-filename", "$FILENAME", "-i", "2" },
          to_stdin = true,
        },
      }))
    end,
    prettierd = function(source_name, methods)
      local null_ls = require("null-ls")
      null_ls.register(null_ls.builtins.formatting.prettierd.with({
        filetypes = {
          -- "javascript", -- now done by biome
          -- "javascriptreact", -- now done by biome
          -- "typescript", -- now done by biome
          -- "typescriptreact", -- now done by biome
          -- "json", -- now done by biome
          -- "jsonc", -- now done by biome
          "vue",
          "css",
          "scss",
          "less",
          "html",
          "yaml",
          "markdown",
          "markdown.mdx",
          "graphql",
          "handlebars",
        },
      }))
    end,
  },
}

M.cmp = {
  sources = {
    { name = "crates" },
  },
}

M.server = {
  list = {
    "lua_ls",
    "ruff_lsp",
    "tsserver",
    "eslint",
    "html",
    "biome",
    "cssls",
    "bashls",
    "tailwindcss",
  },
  configs = function(args)
    local capabilities = args.capabilities
    local on_attach = args.on_attach
    local lspconfig = args.lspconfig
    local lsputil = args.lsp_util

    vim.g.rustaceanvim = { -- Comes from a plugin of rust rustaceanvim
      -- This avoids setting up lsp in mason and uses system's rust-analyzer
      server = {
        on_attach = on_attach,
      },
    }

    local conf = {

      -- Next, you can provide targeted overrides for specific servers.
      ["sourcery"] = function()
        lspconfig.sourcery.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          init_options = {
            token = "user_EVkX_az4UdPgzHdn86HylE_RiOFKiesYPor53OO0xxFe9jVPBT0y06RDQ78",
            extension_version = "vim.lsp",
            editor_version = "vim",
          },
        })
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities,

          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim",
                  "border",
                  "lang",
                  "utils",
                },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                  [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
            },
          },
        })
      end,

      ["tsserver"] = function()
        lspconfig.tsserver.setup({
          on_attach = on_attach,
          capabilities = capabilities,
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
        })
      end,

      ["jsonls"] = function()
        lspconfig.jsonls.setup({
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        })
      end,

      ["yamlls"] = function()
        require("lspconfig").yamlls.setup({
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        })
      end,
    }
    return conf
  end,
}

return M
