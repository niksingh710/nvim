local M = {}

M.colorizer = {
  "json",
  "css",
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
    "prettierd",
    "shfmt",
    "shellcheck",
  },
  handlers = {},
}

M.cmp = {
  sources = {
    { name = "crates" },
  },
}

M.server = {
  list = {
    "lua_ls",
    "rust_analyzer",
    "tsserver",
    "eslint",
    "html",
    "cssls",
    "bashls",
  },
  configs = function(args)
    local capabilities = args.capabilities
    local on_attach = args.on_attach
    local lspconfig = args.lspconfig
    local lsputil = args.lsp_util
    local conf = {

      -- Next, you can provide targeted overrides for specific servers.
      ["rust_analyzer"] = function()
        local rok, rust_tools = pcall(require, "rust-tools")
        if rok then
          rust_tools.setup({
            server = {
              on_attach = on_attach,
              capabilities = capabilities,
              root_dir = lsputil.root_pattern("Cargo.toml", "rust-project.json", ".git"),
              settings = {
                ["rust-analyzer"] = {
                  imports = {
                    granularity = {
                      group = "module",
                    },
                    prefix = "self",
                  },
                  check = {
                    command = "clippy",
                  },
                  cargo = {
                    buildScripts = {
                      enable = true,
                    },
                    allFeatures = true,
                  },
                },
              },
            },
          })
        end
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
