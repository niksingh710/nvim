---@diagnostic disable: unused-function
---@diagnostic disable: unused-local
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = "leetcode.com_*.txt",
  callback = function()
    vim.cmd("Copilot disable")
  end,
})

vim.cmd([[autocmd CursorHold * silent! lua vim.lsp.buf.clear_references()]])
