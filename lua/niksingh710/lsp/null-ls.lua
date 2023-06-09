local null_ls = srequire("null-ls")
if not null_ls then
  return
end

-- local async_formatting = function(bufnr)
--   bufnr = bufnr or vim.api.nvim_get_current_buf()
--
--   vim.lsp.buf_request(
--     bufnr,
--     "textDocument/formatting",
--     vim.lsp.util.make_formatting_params({}),
--     function(err, res, ctx)
--       if err then
--         local err_msg = type(err) == "string" and err or err.message
--         -- you can modify the log message / level (or ignore it completely)
--         vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
--         return
--       end
--
--       -- don't apply results if buffer is unloaded or has been modified
--       if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
--         return
--       end
--
--       if res then
--         local client = vim.lsp.get_client_by_id(ctx.client_id)
--         vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
--         vim.api.nvim_buf_call(bufnr, function()
--           vim.cmd("silent noautocmd update")
--         end)
--       end
--     end
--   )
-- end
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.shfmt,
    -- null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.black.with({
      extra_args = { "-l 120", "--fast", "--experimental-string-processing" },
    }),

    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.shellcheck,
    -- null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.ruff.with({ extra_args = { "--extend-ignore=E501" } }),
    -- null_ls.builtins.diagnostics.mypy.with({ command = { "python", "-m", "mypy" } }),
    -- null_ls.builtins.diagnostics.pylsp,

    null_ls.builtins.completion.spell,
  },
  -- add your sources / config options here
  debug = false,
  -- TODO: fix format on save reference https://github.com/jose-elias-alvarez/null-ls.nvim/issues/879#issuecomment-1133925084
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function()
  --       vim.lsp.buf.format({ bufnr = bufnr })
  --     end, {})
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       command = "undojoin | LspFormatting",
  --     })
  --   end
  -- end, --
  --     -- you can leave this out if your on_attach is unique to null-ls,
  --     -- but if you share it with multiple servers, you'll want to keep it
  --     vim.api.nvim_clear_autocmds({
  --       group = augroup,
  --       buffer = bufnr,
  --     })
  --
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       command = "undojoin | LspFormatting",
  --     })
  --   end
})
