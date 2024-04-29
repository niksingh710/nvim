return {
  "okuuva/auto-save.nvim",
  event = "VeryLazy",
  config = function()
    require("auto-save").setup({
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if fn.getbufvar(buf, "&buftype") ~= "" then
          return false
        end
        -- don't save for `sql` file types
        if utils.not_in(fn.getbufvar(buf, "&filetype"), { "NvimTree", "tex" }) then
          return true
        end
        return false
      end,
      execution_message = {
        enabled = false,
        message = function() -- message to print on save
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,               -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
    })
  end,
}
