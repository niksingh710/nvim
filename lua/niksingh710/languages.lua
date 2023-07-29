-- Reference {{{
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--[[
Remeber this prototype when getting server from the above url.
we are directly putting the server.settings in the masonlsp
if a server need it out then have to manually do that

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
--]]
--
--
--https://github.com/mhartington/formatter.nvim
--Reference above link for custom formatters
--
--https://github.com/mfussenegger/nvim-lint
--https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
--For linters
-- }}}

-- Null-ls Alternatives (nvim-lint, formatter) {{{
-- formatters.lua = {
--   "stylua",
-- }
-- formatters.python = {
--   "black",
-- }
--
-- formatters.go = {
--   "goimports",
-- }
-- -- ======= Markdown
-- linters.markdown = { 'markdownlint' }
-- linters.go = { 'golangcilint' }
-- linters.python = { 'ruff' } 
-- }}}

local M = {}

local servers = {}
local linters = {}
local formatters = {}

servers.clangd = {}

servers.gopls = {}

servers.rust_analyzer = {}

servers.tsserver = {}

servers.emmet_ls = {
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "less"
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}

servers.lua_ls = {
  Lua = {
    telemetry = { enable = false },
    workspace = {
      -- library = vim.api.nvim_get_runtime_file("", true),
      checkThirdParty = false,
      -- serversake the server aware of Neovim runtime files
      library = {
        [vim.fn.expand("$VIserversRUNTIME/lua")] = true,
        [vim.fn.expand("$VIserversRUNTIME/lua/vim/lsp")] = true,
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
        "override",
      },
    },
  },
}

-- Right now null-ls is being used
formatters.goimports= {}
formatters.golines = {}
formatters.gofumpt = {}
formatters.stylua = {}
formatters.jq = {}
formatters.shfmt = {}
formatters.prettier = {}
formatters.black = {
  extra_args = { "-l 120", "--fast", "--experimental-string-processing" },
}

linters.eslint = {}
linters.golangci_lint = {}
linters.shellcheck = {}
linters.ruff = {
  extra_args = {
    "--extended-ignore=E501"
  }
}

M.servers = servers
M.linters = linters
M.formatters = formatters

return M
