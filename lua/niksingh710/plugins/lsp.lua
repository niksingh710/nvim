local lspstatus, lspconfig = pcall(require, "lspconfig")
if not lspstatus then
  vim.notify("For some reason failed to load Lsp")
  return
end

local mstatus, mason = pcall(require, "mason")
if not mstatus then
  vim.notify("For some reason failed to load Mason")
  return
end

local mlspstatus, mlspconfig = pcall(require, "mason-lspconfig")
if not mlspstatus then
  vim.notify("For some reason failed to load Mason LspConfig")
  return
end

utils.map("n", { ["<leader>lm"] = { "<cmd>Mason<cr>", "Mason" } })

local on_attach = function(client, _)
  client.server_capabilities.semanticTokesProvider = nil

  local normal = {

    ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action" },

    ["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Next Diagnostic" },
    ["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Prev Diagnostic" },

    ["<leader>lf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format file" },
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "Lsp Info" },
    ["<leader>gd"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
    ["<leader>gt"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },

    ["gd"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
    ["gt"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
  }

  local telestatus, _ = pcall(require, "telescope")
  if telestatus then
    normal["<leader>ld"] = { "<cmd>Telescope diagnostics<cr>", "Telescope Diagnostics" }
    normal["<leader>gd"] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Telescope Definition" }
    normal["<leader>gr"] = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "Goto References" }
    normal["<leader>gI"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" }
    normal["gd"] = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", "Telescope Definition" }
    normal["gr"] = { "<cmd>Telescope lsp_references theme=dropdown<cr>", "Goto References" }
    normal["gI"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" }
  end

  utils.map("n", normal)

  local wstatus, _ = pcall(require, "which-key")
  if wstatus then
    utils.map("n", { ["<leader>"] = { ["g"] = "Goto" } }, true)
    utils.map("n", { ["<leader>"] = { ["l"] = "Lsp" } }, true)
  end

  local sstatus, saga = pcall(require, "niksingh710.plugins.sagamapping")
  if sstatus then
    saga.setup()
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cstatus, cmplsp = pcall(require, "cmp_nvim_lsp")
if cstatus then
  capabilities = cmplsp.default_capabilities(capabilities)
end

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

mason.setup({
  ensure_installed = {
    "jq",
  },
  ui = {
    -- border = "rounded",
    border = "single",
  },
})

local status, lang = pcall(require, "niksingh710.languages")
local servers = lang.servers
if not status then
  servers = {}
end
-- mason-lsp {{{
for _, k in ipairs(mlspconfig.get_installed_servers()) do
  if not servers[k] then
    servers[k] = {}
  end
end
mlspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})
mlspconfig.setup_handlers({
  function(server_name)
    -- custom ruff_lsp config {{{
    if server_name == "ruff_lsp" then
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = { settings = servers[server_name] },
      })
      return nil
    end
    -- }}}
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    })
  end,
})
-- }}}
utils.map("n", {
  ["<leader>in"] = { "<cmd>NullLsInfo<cr>", "Null Ls Info" },
})

local wstatus, _ = pcall(require, "which-key")
if wstatus then
  utils.map("n", {
    ["<leader>"] = {
      ["i"] = { name = "Info" },
    },
  }, true)
end
