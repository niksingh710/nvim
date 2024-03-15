local M = {}

M.run = function()
  vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    severity_sort = true,
    float = {
      border = border or "rounded",
      source = "always",
      focusable = false,
    },
  })

  local signs = {
    Hint = icons.diagnostics.BoldHint or "",
    Info = icons.diagnostics.BoldInformation or "",
    Warn = icons.diagnostics.BoldWarning or "",
    Error = icons.diagnostics.BoldError or "",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- TODO: this gives the semantic error the
M.capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmplsp = pcall(require, "cmp_nvim_lsp")
if ok then
  M.capabilities = cmplsp.default_capabilities()
end
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  dynamicRegistration = false,
  lineFoldingOnly = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.on_attach = function(client, bufnr)
  vim.g.diagnostics_visible = true

  -- client.server_capabilities.semanticTokensProvider = nil
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  local maps = require("plugins.lsp.mappings")
  utils.mappings(maps)
end

M.handlers = function()
  local args = {
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    lspconfig = require("lspconfig"),
    lsp_util = require("lspconfig/util"),
  }
  local ext = lang.server.configs(args)

  return vim.tbl_deep_extend("force", {
    -- default implementation for servers that are not setted up but installed.
    function(server)
      args.lspconfig[server].setup({
        capabilities = args.capabilities,
        on_attach = args.on_attach,
      })
    end,
  }, lang.server.configs(args))
end

return M
