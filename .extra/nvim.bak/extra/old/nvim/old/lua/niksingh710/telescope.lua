local telescope = srequire("telescope")
if not telescope then
  return
end

local actions = srequire("telescope.actions")
if not actions then
  return
end

telescope.setup({
  pickers = {
    current_buffer_fuzzy_find = {
      theme = "dropdown",
      winblend = 10,
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    repo = {},
    neoclip = {},
    zoxide = {
      -- the default case_mode is "smart_case"
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
  defaults = {
    mappings = {
      i = {
        ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
      n = {
        ["q"] = actions.close,
        ["<s-j>"] = actions.preview_scrolling_down,
        ["<s-k>"] = actions.preview_scrolling_up,
        ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
    file_ignore_patterns = {
      -- "./node_modules/*",
      -- "node_modules",
      -- "^node_modules/*",
      -- "node_modules/*",
      --
      -- "./git/*",
      --
      -- "./tmp/*",
      -- "tmp",
      -- "^tmp/*",
      -- "tmp/*",
    },
  },
})
telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("repo")
telescope.load_extension("persisted")
telescope.load_extension("vimwiki")
-- telescope.load_extension("neoclip")

map("n", {
  ["<leader>"] = {
    ["s"] = {
      name = "Search",
      ["d"] = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
      ["D"] = { "<cmd>Telescope zoxide list<cr>", "change dir to zoxide" },
      ["f"] = { "<cmd>Telescope find_files hidden=true<cr>", "Search Find files" },
      ["r"] = { "<cmd>Telescope oldfiles<cr>", "Search Recent files" },
      ["R"] = { "<cmd>Telescope repo repo<cr>", "Search Git repos" },
      ["k"] = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
      ["s"] = { "<cmd>Telescope builtin<cr>", "Search Telescope" },
      ["g"] = { "<cmd>Telescope live_grep<cr>", "Search Live Grep" },
      ["h"] = { "<cmd>Telescope help_tags<cr>", "Search Help Tags" },
      ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy Buffer Search" },
      ["t"] = { "<cmd>TodoTelescope theme=<cr>", "Todo Search" },
      ["b"] = { "<cmd>Telescope buffers<cr>", "Search Buffers" },
      ["c"] = { "<cmd>Telescope commands<cr>", "Search Commands" },
      ["C"] = { "<cmd>Cheatsheet<cr>", "Search Cheatsheet" },
      ["m"] = { "<cmd>Telescope marks<cr>", "Search Marks" },
      ["o"] = { "<cmd>Telescope vim_options<cr>", "Search Vim Options" },
      ["p"] = { "<cmd>Telescope projects<cr>", "Search Projects" },
      ["P"] = { "<cmd>Telescope persisted<cr>", "Search Projects" },
      ["q"] = { "<cmd>Telescope quickfix<cr>", "Search Quickfix" },
      ["l"] = { "<cmd>Telescope loclist<cr>", "Search Location List" },
      ["w"] = {
        name = "vimwikki",
        ["w"] = { "<cmd>Telescope vimwiki<cr>", "Search vimwiki files" },
        ["g"] = { "<cmd>Telescope vimwiki live_grep<cr>", "Search vimwiki files" },
      },
    },
  },
}, true)
