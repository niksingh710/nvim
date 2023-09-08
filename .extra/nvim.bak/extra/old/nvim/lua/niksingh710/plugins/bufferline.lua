local bstatus, bufferline = pcall(require, "bufferline")
if not bstatus then
  return
end

local opts = {
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
    left_trunc_marker = icons.ui.ArrowCircleLeft,
    right_trunc_marker = icons.ui.ArrowCircleRight,
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
    always_show_bufferline = true,
    hover = {
      enabled = true, -- requires nvim 0.8+
      delay = 200,
      reveal = { "close" },
    },
    sort_by = "id",
  },
}

bufferline.setup(opts)
local normal = {
  ["<leader>bf"] = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
  ["<leader>bc"] = { "<cmd>bd<cr>", "Delete Buffer" },
  ["<leader>bp"] = { "<cmd>BufferLinePick<cr>", "List Buffers" },
  ["<leader>bP"] = { "<cmd>BufferLineTogglePin<cr>", "List Buffers" },
  ["<leader>bd"] = { "<cmd>BufferLineSortByDirectory<cr>", "Sort Buffers by Directory" },
  ["<leader>be"] = { "<cmd>BufferLineSortByExtension<cr>", "Sort Buffers by Extension" },
  ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", "Sort Buffers by Tabs" },
}
utils.map("n", normal)
local ws, _ = pcall(require, "which-key")
if ws then
  utils.map("n", {
    ["<leader>"] = {
      ["b"] = {
        name = "Buffer",
      },
    },
  }, true)
end
