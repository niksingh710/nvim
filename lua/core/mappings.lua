-- Function to easily map keymaps
local mappings = utils.mappings
local maps = {
  i = {
    ["jk"] = { "<esc>", "Normal mode" },
    -- ["kj"] = "<esc>",

    ["<c-s>"] = { "<esc>:w<cr>", "Save file" },
    ["<a-j>"] = { "<esc>:m .+1<cr>==gi", "Move Line Down" },
    ["<a-k>"] = { "<esc>:m .-2<cr>==gi", "Move Line Up" },
  },
  n = {
    ["<c-s>"] = { "<cmd>w<cr>", "Save the file" },

    -- Maybe overriden by `christoomey vim-tmux-navigator`
    ["<c-h>"] = { "<c-w>h", "Focus on right split" },
    ["<c-j>"] = { "<c-w>j", "Focus on below split" },
    ["<c-k>"] = { "<c-w>k", "Focus on up split" },
    ["<c-l>"] = { "<c-w>l", "Focus on left split" },

    ["<c-a-j>"] = { "<cmd>resize -1<cr>", "Resize down" },
    ["<c-a-k>"] = { "<cmd>resize +1<cr>", "Resize up" },
    ["<c-a-l>"] = { "<cmd>vertical resize -1<cr>", "Resize right" },
    ["<c-a-h>"] = { "<cmd>vertical resize +1<cr>", "Resize left" },

    ["<c-a-=>"] = { "<C-a>", "Increase Number" },
    ["<c-a-->"] = { "<C-x>", "Decrease Number" },

    ["<a-j>"] = { "<cmd>m .+1<cr>==", "Move line Down" },
    ["<a-k>"] = { "<cmd>m .-2<cr>==", "Move line up" },

    ["<s-h>"] = { "<esc>:bprev<cr>", "Buffer Previous" },
    ["<s-l>"] = { "<esc>:bnext<cr>", "Buffer Next" },
    ["<leader>c"] = { "<esc>:bp | bd #<cr>", "Buffer Close" },

    ["<leader>q"] = { "<cmd>quitall!<cr>", "Quit!" },
    ["<leader><cr>"] = {
      function()
        local curdir = vim.fn.expand("%:p:h")
        vim.api.nvim_set_current_dir(curdir)
      end,
      "Change dir",
    },

    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true, silent = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true, silent = true } },

    ["<leader>h"] = { "<cmd>nohl<cr>", "No Highlight!" },
    ["<leader>a"] = { "gg0vG$", "Select All" },

    ["<leader>vv"] = { "<cmd>vsplit<cr>", "vertical split" },
    ["<leader>vs"] = { "<cmd>split<cr>", "horizontal split" },

    ["<leader>tj"] = { "<cmd>tabn<cr>", "Next Tab" },
    ["<leader>tk"] = { "<cmd>tabp<cr>", "Previous Tab" },
    ["<leader>tl"] = { "<cmd>tabn<cr>", "Next Tab" },
    ["<leader>th"] = { "<cmd>tabp<cr>", "Previous Tab" },

    ["<leader>tq"] = { "<cmd>tabclose<cr>", "Close Tab" },
    ["<leader>tn"] = { "<cmd>tabnew<cr>", "New Tab" },

    ["<leader>ft"] = {
      utils.setFiletype,
      "Set Filetype",
    },

    -- highlight are in center
    ["n"] = { "nzzzv", "Move to center" },
    ["N"] = { "Nzzzv", "Moving to center" },
    ["x"] = { '"_x', "Register x" }, -- will not copy if something is deleted using `x`
    -- lsp maps independent of plugin
    ["<leader>lf"] = { vim.lsp.buf.format, "Format file" },
    ["<leader>ll"] = {
      function()
        return require("plugins.lsp.setup").toggle_diagnostics_ghost_text()
      end,
      "Toggle Ghost Text",
    },
    ["<leader>lL"] = {
      function()
        return require("plugins.configs.lsp").toggle_diagnostics()
      end,
      "Toggle Diagnostics",
    },

    ["<leader>lk"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Next Diagnostic" },
    ["<leader>lj"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Prev Diagnostic" },
    ["K"] = { vim.lsp.buf.hover, "Hover Doc" },
  },
  v = {
    ["<c-s>"] = { "<esc>:w<cr>", "Saving File" },
    ["<c-c>"] = { "<esc>", "Escape" },

    ["<a-j>"] = { ":m '>+1<cr>gv-gv", "Move Selected Line Down" },
    ["<a-k>"] = { ":m '<lt>-2<CR>gv-gv", "Move Selected Line Up" },

    ["<"] = { "<gv", "Indent out" },
    [">"] = { ">gv", "Indent in" },

    ["<space>"] = { "<Nop>", "Mapped to Nothing" },

    ["x"] = { '"_x', "Registers x" },
    ["P"] = { '"_dP', "Register P" },

    ["<leader>y"] = { '"+y', "Register Y" },
    ["<leader>d"] = { '"+d', "Register d" },
    ["<leader>Y"] = { 'gg"+yG', "Register Y" },
    ["<leader>D"] = { 'gg"+dG', "Register D" },
    ["<leader>x"] = { '"+x', "Register x" },
    ["<leader>X"] = { '"+', "Register X" },

    -- lsp maps independent of plugin
    ["<leader>lf"] = { vim.lsp.buf.format, "Format file" },
  },
  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
    --
    -- lsp maps independent of plugin
    ["<leader>lf"] = { vim.lsp.buf.format, "Format file" },
  },
}
mappings(maps)
