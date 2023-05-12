local bufferline = srequire("bufferline")
if not bufferline then
  return
end

bufferline.setup({
  on_config_done = nil,
  highlights = {
    background = {
      italic = true,
    },
    buffer_selected = {
      bold = true,
    },
  },
  options = {
    mode = "buffers",                      -- set to "tabs" to only show tabpages instead
    numbers = "none",                      -- can be "none" | "ordinal" | "buffer_id" | "both" | function
    close_command = "bd",
    right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",      -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,            -- can be a string | function, see "Mouse actions"
    indicator_icon = nil,
    indicator = { style = "icon", icon = "▎" },
    buffer_close_icon = "",
    -- buffer_close_icon = '',
    -- modified_icon = "●",
    -- close_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match("%.md") then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "undotree",
        text = "Undotree",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "flutterToolsOutline",
        text = "Flutter Outline",
        highlight = "PanelHeading",
      },
      {
        filetype = "lazy",
        text = "Lazy",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "thin",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    hover = {
      enabled = true, -- requires nvim 0.8+
      delay = 200,
      reveal = { "close" },
    },
    sort_by = "id",
  },
})

-- will only be mapped if which key is there
map("n", {
  ["<leader>"] = {
    b = {
      name = "Buffers",
      f = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
      D = { "<cmd>bd<cr>", "Delete Buffer" },
      p = { "<cmd>BufferLinePick<cr>", "List Buffers" },
      P = { "<cmd>BufferLineTogglePin<cr>", "List Buffers" },
      d = { "<cmd>BufferLineSortByDirectory<cr>", "Sort Buffers by Directory" },
      e = { "<cmd>BufferLineSortByExtension<cr>", "Sort Buffers by Extension" },
      t = { "<cmd>BufferLineSortByTabs<cr>", "Sort Buffers by Tabs" },
    },
    ["t"] = {
      name = "Tabs",
      j = { "<cmd>tabn<cr>", "Next Tab" },
      k = { "<cmd>tabp<cr>", "Previous Tab" },
      q = { "<cmd>tabclose<cr>", "Close Tab" },
      n = { "<cmd>tabnew<cr>", "New Tab" },
    },
  },
}, true)
