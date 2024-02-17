return {
  "okuuva/auto-save.nvim",
  event = "VeryLazy",
  config = function()
    require("auto-save").setup({
      execution_message = {
        enabled = false,
        message = function() -- message to print on save
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18, -- dim the color of `message`
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
      },
    })
  end,
}
