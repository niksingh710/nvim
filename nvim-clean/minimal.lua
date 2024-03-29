-- Plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    -- enabled = false,
    cmd = { "NvimTreeToggle" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-tree.lua",
        },
        config = function()
          require("lsp-file-operations").setup()
        end,
      },
      {
        "JMarkin/nvim-tree.lua-float-preview",
        lazy = true,
        -- default
        opts = {
          window = {
            wrap = false,
            trim_height = false,
            open_win_config = function()
              HEIGHT_PADDING = 10
              WIDTH_PADDING = 15
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w_f = (screen_w - WIDTH_PADDING * 2 - 1) / 2
              local window_w = math.floor(window_w_f)
              local window_h = screen_h - HEIGHT_PADDING * 2
              local center_x = window_w_f + WIDTH_PADDING + 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

              return {
                style = "minimal",
                relative = "editor",
                border = "single",
                row = center_y,
                col = center_x,
                width = window_w,
                height = window_h,
              }
            end,
          },
          mapping = {
            -- scroll down float buffer
            down = { "<C-d>" },
            -- scroll up float buffer
            up = { "<C-e>", "<C-u>" },
            -- enable/disable float windows
            toggle = { "'" },
          },
        },
      },
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
    },

    init = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- auto cmd for last window
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd("quit")
          end
        end,
      })
      -- will fall back to last buffer if closed one buffer
      -- doesnot let nvim tree window to be the last window
      vim.api.nvim_create_autocmd("BufEnter", {
        nested = true,
        callback = function()
          local api = require("nvim-tree.api")

          -- Only 1 window with nvim-tree left: we probably closed a file buffer
          if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
            -- Required to let the close event complete. An error is thrown without this.
            vim.defer_fn(function()
              -- close nvim-tree: will go to the last hidden buffer used before closing
              api.tree.toggle({ find_file = true, focus = true })
              -- re-open nivm-tree
              api.tree.toggle({ find_file = true, focus = true })
              -- nvim-tree is still the active window. Go to the previous window.
              vim.cmd("wincmd p")
            end, 0)
          end
        end,
      })
    end,

    opts = {
      filters = { custom = { "^.git$" } },
      hijack_cursor = false,

      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        adaptive_size = true,
        side = "right",
        width = 30,
        float = {
          enable = true,
          quit_on_focus_loss = false,
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
      system_open = {
        cmd = "xdg-open",
      },
      renderer = {
        root_folder_label = ":t",
        highlight_git = true,
        highlight_opened_files = "none",

        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },

        icons = {
          git_placement = "after",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
        debounce_delay = 50,
        severity = {
          -- min = vim.diagnostic.severity.WARNING, -- I don't like warning in my file explorer
          min = vim.diagnostic.severity.ERROR,
          max = vim.diagnostic.severity.ERROR,
        },
      },
    },

    config = function(_, opts)
      local api = require("nvim-tree.api")

      local gwidth = vim.api.nvim_list_uis()[1].width
      local gheight = vim.api.nvim_list_uis()[1].height
      local width = 120
      local height = 40
      opts.view.width = width
      opts.view.float.open_win_config = {
        relative = "editor",
        width = width,
        height = height,
        row = (gheight - height) * 0.4,
        col = (gwidth - width) * 0.5 + (gwidth - width) * 0.1,
      }
      HEIGHT_PADDING = 10
      WIDTH_PADDING = 15

      opts.view.float.open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w_f = (screen_w - WIDTH_PADDING * 2) / 2
        local window_w = math.floor(window_w_f)
        local window_h = screen_h - HEIGHT_PADDING * 2
        local center_x = WIDTH_PADDING - 1
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

        return {
          border = "single",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w,
          height = window_h,
        }
      end
      opts.view.width = function()
        return vim.opt.columns:get() - WIDTH_PADDING * 2
      end
      local function attach(bufnr)
        local FloatPreview = require("float-preview")

        FloatPreview.attach_nvimtree(bufnr)
        local close_wrap = FloatPreview.close_wrap

        -- This will make sure that newly created file get's open to edit
        api.events.subscribe(api.events.Event.FileCreated, function(file)
          vim.cmd("edit " .. file.fname)
        end)

        -- functions used to map
        local function options(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        local function set(mode, data)
          for key, value in pairs(data) do
            vim.keymap.set(mode, key, value[1], value[2])
          end
        end

        local normal = {
          h = { close_wrap(api.node.navigate.parent_close), options("Close Directory") },
          l = { close_wrap(api.node.open.edit), options("Open") },
          H = { close_wrap(api.tree.collapse_all), options("Close Directory") },
          L = { close_wrap(api.tree.expand_all), options("Expand All") },
          v = { close_wrap(api.node.open.vertical), options("Open: Vertical Split") },
          s = { close_wrap(api.node.open.horizontal), options("Open: Horizontal Split") },
          C = { close_wrap(api.tree.change_root_to_node), options("CD") },
          O = { close_wrap(api.node.run.system), options("Run System") },
          y = { close_wrap(api.fs.copy.node), options("Copy") },
          c = { close_wrap(api.fs.copy.filename), options("Copy Name") },
          K = { FloatPreview.toggle, options("Copy Name") },
          ["?"] = { close_wrap(api.tree.toggle_help), options("Help") },
        }

        api.config.mappings.default_on_attach(bufnr)
        set("n", normal)

        vim.keymap.set("n", "P", function() -- Special fn to print node PATH
          local node = api.tree.get_node_under_cursor()
          print(node.absolute_path)
        end, options("Print Node Path"))
      end
      opts.on_attach = attach

      require("nvim-tree").setup(opts)

      -- Opens telescope to find a directory and focus on it
      function find_directory_and_focus()
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local function open_nvim_tree(prompt_bufnr, _)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            api.tree.open()
            api.tree.find_file(selection.cwd .. "/" .. selection.value)
          end)
          return true
        end

        local ok, telescope = pcall(require, "telescope.builtin")
        if not ok then
          print("Telescope is not installed")
          return
        end
        telescope.find_files({
          find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
          attach_mappings = open_nvim_tree,
        })
      end

      vim.keymap.set("n", "fd", find_directory_and_focus)
    end,
  },
})
