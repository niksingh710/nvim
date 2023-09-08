local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- highlights how much content is yanked
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- make sure that lastwindow is not nvim-tree
autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

-- nvim latest bug reports error on close
-- NOTE: This is a workaround for uv_close: Assertion '!uv__is_closing(handle)' failed
autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart('echo ""', { detach = true })
  end,
})
