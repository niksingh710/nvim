local mappings = {
  {"<leader>sf", "<cmd>Telescope find_files<cr>",desc = "Find Files"},

     {"<leader>sd", "<cmd>Telescope diagnostics<cr>",desc= "Search Diagnostics" },
     {"<leader>sf", "<cmd>Telescope find_files <cr>",desc= "Search Find files" },
     {"<leader>sF", "<cmd>Telescope find_files hidden=true<cr>",desc= "Find files Hidden Also" },
     {"<leader>sr", "<cmd>Telescope oldfiles<cr>",desc= "Search Recent files" },
     {"<leader>sk", "<cmd>Telescope keymaps<cr>",desc= "Search Keymaps" },
     {"<leader>ss", "<cmd>Telescope builtin<cr>",desc= "Search Telescope" },
     {"<leader>sg", "<cmd>Telescope live_grep<cr>",desc= "Search Live Grep" },
     {"<leader>sh", "<cmd>Telescope help_tags<cr>",desc= "Search Help Tags" },
     {"<leader>sb", "<cmd>Telescope buffers<cr>",desc= "Search Buffers" },
     {"<leader>sc", "<cmd>Telescope commands<cr>",desc= "Search Commands" },
     {"<leader>sm", "<cmd>Telescope marks<cr>",desc= "Search in Media Mode" },
     {"<leader>so", "<cmd>Telescope vim_options<cr>",desc= "Search Vim Options" },
     {"<leader>sq", "<cmd>Telescope quickfix<cr>",desc= "Search Quickfix" },
     {"<leader>sl", "<cmd>Telescope loclist<cr>",desc= "Search Location List" },
     {"<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>",desc= "Fuzzy Buffer Search" },
}

return {
  'nvim-telescope/telescope.nvim', tag = '0.1.2',
  enabled = config.telescope,
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()

  local telescope = require("telescope")
  local action = require("telescope.actions")
  telescope.setup({

    extensions = {

      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },

    defaults = {
      mappings = {
        n = {
          q = action.close,
          x = action.select_horizontal,
          v = action.select_vertical,
        },
      },
    },
  })
  end,

  keys = mappings,
}
