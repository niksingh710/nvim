map("n", {
  ["<leader>"] = {
    ["/"] = { "<plug>(comment_toggle_linewise_current)", "Comment" },
    ["l"] = {
      ["k"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Goto Previous diagnosticss" },
      ["f"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
      ["j"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Goto Next diagnosticss" },
      ["i"] = { "<cmd>LspInfo<cr>", "Lsp Info" },
      ["d"] = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      ["I"] = { "<cmd>Mason<cr>", "Mason Info" },
    },
  },
}, true)

map("v", {
  ["<leader>/"] = { "<plug>(comment_toggle_linewise_visual)", "Comment" },
})

---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
  -- local lsp_format = srequire("lsp-format")
  -- if lsp_format then
  --   lsp_format.on_attach(client)
  -- end
  local mappings = {
    ["<leader>"] = {
      ["l"] = {
        name = "Lsp",
        ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },
      },
    },
    ["g"] = {
      name = "Goto",
      ["d"] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Definition" },
      ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
      ["r"] = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "Goto References" },
      ["I"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
      ["t"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
      ["l"] = {
        function()
          local float = vim.diagnostic.config().float

          if float then
            local config = type(float) == "table" and float or {}
            config.scope = "line"
            config.border = "single"
            vim.diagnostic.open_float(config)
          end
        end,
        "Show line diagnostics",
      },
    },
  }

  map("n", mappings, true)
  local smapping = require("niksingh710.lsp.sagamapping")
  map("n", smapping.wk, true)
  map("n", smapping.nor)
end

local servers = {
  clangd = {},
  gopls = {},
  rust_analyzer = {},
  tsserver = {},
  ruff_lsp = {
    args = { "--extend-ignore=E501" },
  },
  -- pylsp = {
  --   plugins = {
  --     ruff = {
  --       enabled = true,
  --       extendSelect = { "I" },
  --     },
  --   },
  -- },
  -- pyright = {
  --   python = {
  --     analysis = {
  --       typeCheckingMode = "off",
  --       autoSearchPaths = true,
  --       useLibraryCodeForTypes = true,
  --       diagnosticMode = "workspace",
  --     },
  --   },
  -- },
  emmet_ls = {
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    },
  },
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      workspace = {
        -- library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
      maxPreload = 100000,
      preloadFileSize = 10000,
      diagnostics = {
        underline = false,
        disable = {
          "lowercase-global",
        },
        globals = {
          "vim",
          "require",
          "list",
          "map",
          "srequire",
          "notify",
        },
      },
    },
  },
}

local neodev = srequire("neodev")
if not neodev then
  return
end
neodev.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = srequire("cmp_nvim_lsp")
if not cmp_nvim_lsp then
  return
end

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason = srequire("mason")
if not mason then
  return
end
mason.setup({
  ensure_installed = {
    -- "debugpy",
    -- "black",
    -- "pyright",
    -- "mypy",
    -- "ruff",
    "jq",
  },
  ui = {
    border = "rounded",
  },
})

local mason_lsp = srequire("mason-lspconfig")
if not mason_lsp then
  return
end

for _, k in ipairs(mason_lsp.get_installed_servers()) do
  if not servers[k] then
    servers[k] = {}
  end
end

mason_lsp.setup({
  ensure_installed = vim.tbl_keys(servers),
})

local lspconfig = srequire("lspconfig")
if not lspconfig then
  return
end

mason_lsp.setup_handlers({
  function(server_name)
    if server_name == "ruff_lsp" then
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = { settings = servers[server_name] },
      })
    else
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      })
    end
  end,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
if icons.diagnostics then
  signs = {
    Error = icons.diagnostics.Error,
    Warn = icons.diagnostics.Warning,
    Hint = icons.diagnostics.Hint,
    Info = icons.diagnostics.Information,
  }
end
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

