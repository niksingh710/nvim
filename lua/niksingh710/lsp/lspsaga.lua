local lspsaga = srequire("lspsaga")
if not lspsaga then
  return
end
lspsaga.setup({
  ui = {
    border = "rounded",
  },
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  diagnostic = {
    on_insert = false,
    on_insert_follow = false,
    insert_winblend = 0,
    show_code_action = true,
    show_source = true,
    jump_num_shortcut = true,
    max_width = 0.7,
    max_height = 0.6,
    max_show_width = 0.9,
    max_show_height = 0.6,
    text_hl_follow = false,
    border_follow = true,
    extend_relatedInformation = false,
    keys = {
      exec_action = "o",
      quit = "q",
      expand_or_jump = "<CR>",
      quit_in_show = { "q", "<ESC>" },
    },
  },
  definition = {
    edit = "<C-c>o",
    vsplit = "<C-c>v",
    split = "<C-c>i",
    tabe = "<C-c>t",
    quit = "q",
  },
  hover = {
    open_link = "gx",
    open_browser = "!firefox",
  },
})
-- vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>") -- if user want term toggle
