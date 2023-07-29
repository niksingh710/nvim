local telestatus, telescope = pcall(require, "telescope")
if not telestatus then
  return
end

local acstatus, actions = pcall(require, "telescope.actions")
if not acstatus then
  return
end

local opts = {
  pickers = {
    current_buffer_fuzzy_find = {
      theme = "dropdown",
      winblend = 10,
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
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
        ["<c-a-j>"] = actions.preview_scrolling_down,
        ["<c-a-k>"] = actions.preview_scrolling_up,
        ["<c-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
    file_ignore_patterns = {
      -- "./node_modules/*",
    },
  },
}

local utele, utelescope = pcall(require, "telescope-undo.actions")
if utele then
  opts["extensions"]["undo"] = {
    use_delta = true,
    use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
    side_by_side = false,
    diff_context_lines = vim.o.scrolloff,
    entry_format = "state #$ID, $STAT, $TIME",
    time_format = "",
    mappings = {
      n = {
        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
        -- you want to replicate these defaults and use the following actions. This means
        -- installing as a dependency of telescope in it's `requirements` and loading this
        -- extension from there instead of having the separate plugin definition as outlined
        -- above.
        ["<cr>"] = utelescope.yank_additions,
        ["<s-cr>"] = utelescope.yank_deletions,
        ["<c-cr>"] = utelescope.restore,
      },
      i = {
        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
        -- you want to replicate these defaults and use the following actions. This means
        -- installing as a dependency of telescope in it's `requirements` and loading this
        -- extension from there instead of having the separate plugin definition as outlined
        -- above.
        ["<cr>"] = utelescope.yank_additions,
        ["<s-cr>"] = utelescope.yank_deletions,
        ["<c-cr>"] = utelescope.restore,
      },
    },
  }
end


telescope.setup(opts)
local ps, _ = pcall(require, "persisted")
if ps then
  telescope.load_extension("persisted")
end

local normal = {
  ["<leader>sd"] = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
  ["<leader>sf"] = { "<cmd>Telescope find_files hidden=true<cr>", "Search Find files" },
  ["<leader>sr"] = { "<cmd>Telescope oldfiles<cr>", "Search Recent files" },
  ["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "Search Keymaps" },
  ["<leader>ss"] = { "<cmd>Telescope builtin<cr>", "Search Telescope" },
  ["<leader>sg"] = { "<cmd>Telescope live_grep<cr>", "Search Live Grep" },
  ["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "Search Help Tags" },
  ["<leader>s/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy Buffer Search" },
  ["<leader>sb"] = { "<cmd>Telescope buffers<cr>", "Search Buffers" },
  ["<leader>sc"] = { "<cmd>Telescope commands<cr>", "Search Commands" },
  ["<leader>sm"] = { "<cmd>Telescope marks<cr>", "Search Marks" },
  ["<leader>so"] = { "<cmd>Telescope vim_options<cr>", "Search Vim Options" },
  ["<leader>sq"] = { "<cmd>Telescope quickfix<cr>", "Search Quickfix" },
  ["<leader>sl"] = { "<cmd>Telescope loclist<cr>", "Search Location List" },
}

utils.map("n", normal)

local wstatus, _ = pcall(require, "which-key")
if wstatus then
  utils.map("n", {
    ["<leader>s"] = {
      name = "Search",
    },
  }, true)
end
