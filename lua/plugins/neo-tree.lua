return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  event = "BufWinEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    enable_normal_mode_for_inputs = true, -- Enable normal mode for input dialogs.
    popup_border_style = "rounded",
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          unstaged = icons.git.FileUnstaged,
          staged = icons.git.FileStaged,
          unmerged = icons.git.FileUnmerged,
          renamed = icons.git.FileRenamed,
          untracked = icons.git.FileUntracked,
          deleted = icons.git.FileDeleted,
          ignored = icons.git.FileIgnored,
        },
      },
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      },
      icon = {
        folder_closed = icons.ui.Folder or "",
        folder_open = icons.ui.FolderOpen or "",
        folder_empty = icons.ui.EmptyFolder or "󰜌",
      },
    },
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        -- vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
        -- Linux: open file in default application
        vim.fn.jobstart({ "xdg-open", path }, { detach = true })
      end,
    },
    window = {
      width = 30,
      mappings = {
        ["q"] = "cancel",
        ["v"] = "open_vsplit",
        ["s"] = "open_split",
        ["O"] = "system_open",
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
      },
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
  },
}
