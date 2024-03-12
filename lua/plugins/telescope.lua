return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = { -- These are not dependencies but extensions
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "debugloop/telescope-undo.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },

    {
      -- TODO: fix
      "willothy/harpoon",
      -- "ThePrimeagen/harpoon", -- TODO: check if pr is merged
      branch = "fix-ui",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      keys = {
        { "<leader>fm", ":lua require('harpoon'):list():append()<cr>", desc = "Mark file to harpoon" },
        {
          "<leader>fu",
          ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>",
          desc = "Harpoon Ui",
        },
        { "<leader>ff", ":Telescope harpoon marks<cr>", desc = "Harpoon Telescope" },
      },
    },
    { --TODO: Check about the worktree
      "ThePrimeagen/git-worktree.nvim",
      keys = {
        {
          "<leader>gw",
          "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
          desc = "Git worktree list",
        },
        {
          "<leader>gc",
          "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktrees()<cr>",
          desc = "Git worktree Create",
        },
      },
    },
    {
      "ahmedkhalf/project.nvim",
      main = "project_nvim",
      config = true,
    },
  },
  opts = {
    pickers = {
      find_files = {
        follow = true,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local action = require("telescope.actions")
    opts.defaults.mappings = {
      n = {
        q = action.close,
        x = action.select_horizontal,
        v = action.select_vertical,
      },
    }

    opts.extensions.undo = {
      mappings = {
        n = {
          -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
          -- you want to replicate these defaults and use the following actions. This means
          -- installing as a dependency of telescope in it's `requirements` and loading this
          -- extension from there instead of having the separate plugin definition as outlined
          -- above.
          ["y"] = require("telescope-undo.actions").yank_additions,
          ["Y"] = require("telescope-undo.actions").yank_deletions,
          ["<cr>"] = require("telescope-undo.actions").restore,
        },
      },
      side_by_side = true,
      layout_strategy = "horizontal",
    }
    require("telescope").setup(opts)

    local ext = {
      "fzf",
      "undo",
      "harpoon",
      "projects",
      -- "git_worktree",
    }

    -- load extensions
    for _, extension in ipairs(ext) do
      telescope.load_extension(extension)
    end
  end,
  keys = {
    -- Git
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },

    { "<leader>sd", "<cmd>Telescope diagnostics theme=ivy<cr>", desc = "Search Diagnostics" },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search Find files" },
    { "<leader>sF", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files Hidden Also" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Search Recent files" },
    { "<leader>sk", "<cmd>Telescope keymaps theme=dropdown<cr>", desc = "Search Keymaps" },
    { "<leader>ss", "<cmd>Telescope builtin<cr>", desc = "Search Telescope" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search Live Grep" },
    { "<leader>sH", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
    { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Search Commands" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Search in Media Mode" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Search Vim Options" },
    { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Search Quickfix" },
    { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Search Location List" },
    { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Search Projects" },
    { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Search undo" },
    { "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Buffer Search" },
  },
}
