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

-- NOTE: This is a workaround for uv_close: Assertion '!uv__is_closing(handle)' failed
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart('echo ""', { detach = true })
  end,
})

-- before making any plugin dependent autocmds make sure to check if command exists or not
-- can use utils.check.vimcmd
-- vim.cmd(":autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif")
