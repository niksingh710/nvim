return {
  "itchyny/calendar.vim",
  cmd = { "Calendar" },
  keys = {
    { "<leader>uC", "<cmd>Calendar<CR>", desc = "Calender" },
  },
  config = function()
    -- e.g config {{{
    -- let g:calendar_google_api_key = '<api key'
    -- let g:calendar_google_client_id = 'client id'
    -- let g:calendar_google_client_secret = 'client-secret'
    -- }}}

    if utils.check.file_exists(os.getenv("HOME") .. "/.cache/calendar.vim/credentials.vim") then
      vim.cmd([[
        let g:calendar_google_calendar = 1
        let g:calendar_google_task = 1
        source ~/.cache/calendar.vim/credentials.vim
        ]])
    end
  end,
}
