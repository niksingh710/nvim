vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[set runtimepath=$VIMRUNTIME]])
vim.cmd([[set packpath=/tmp/nvt-min/site]])
local package_root = "/tmp/nvt-min/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"
local function load_plugins()
  require("packer").startup({
    {
      "wbthomason/packer.nvim",
      "nvim-tree/nvim-tree.lua",
      "nvim-tree/nvim-web-devicons",
      -- ADD PLUGINS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
      "JMarkin/nvim-tree.lua-float-preview",
    },
    config = {
      package_root = package_root,
      compile_path = install_path .. "/plugin/packer_compiled.lua",
      display = { non_interactive = true },
    },
  })
end
if vim.fn.isdirectory(install_path) == 0 then
  print("Installing nvim-tree and dependencies.")
  vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })
end
load_plugins()
require("packer").sync()
vim.cmd([[autocmd User PackerComplete ++once echo "Ready!" | lua setup()]])
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- MODIFY NVIM-TREE SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE
_G.setup = function()
  local api = require("nvim-tree.api")
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

  HEIGHT_PADDING = 10
  WIDTH_PADDING = 15

  require("nvim-tree").setup({
    filters = { custom = { "^.git$" } },
    hijack_cursor = false,

    actions = {
      open_file = {
        eject = false,
        quit_on_open = true,
      },
    },

    on_attach = attach,
    view = {
      adaptive_size = false,
      side = "right",

      width = function()
        return vim.opt.columns:get() - WIDTH_PADDING * 2
      end,
      float = {
        enable = true,
        quit_on_focus_loss = false,
        open_win_config = function()
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
        end,
      },
    },
  })
  require("float-preview").setup({
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
  })
end

-- UNCOMMENT this block for diagnostics issues, substituting pattern and cmd as appropriate.
-- Requires diagnostics.enable = true in setup.
--[[
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start { cmd = { "lua-language-server" } }
  end,
})
]]
