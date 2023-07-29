local M = {}
M.setup = function()
  local sagastatus, lspsaga = pcall(require, "lspsaga")
  if not sagastatus then
    return
  end

  lspsaga.setup({
    code_action_icon = " ",
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 20,
      virtual_text = true,
    },
  })

  local normal = {
    ["<leader>oo"] = { "<cmd>Lspsaga outline<cr>", "Outline" },

    ["<leader>lw"] = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Diagnostics" },
    ["<leader>ld"] = { "<cmd>Lspsaga show_buf_diagnostics<cr>", "Line Diagnostics" },

    ["<leader>la"] = { "<cmd>Lspsaga code_action<cr>", "Outline" },
    ["<leader>gd"] = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definations" },
    ["<leader>gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
    ["<leader>gR"] = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
    ["<leader>gt"] = { "<cmd>Lspsaga goto_type_definition<CR>", "Type Definations" },
    ["<leader>gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
    ["<leader>gpd"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definations" },
    ["<leader>gpt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definations" },

    ["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "Goto Definations" },
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
    ["gR"] = { "<cmd>Lspsaga rename ++project<CR>", "Rename" },
    ["gt"] = { "<cmd>Lspsaga goto_type_definition<CR>", "Type Definations" },
    ["gl"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
    ["gpd"] = { "<cmd>Lspsaga peek_definition<CR>", "Peek Definations" },
    ["gpt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "Peek Type Definations" },

    ["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    ["[e"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic" },
    ["[E"] = {
      "<cmd>lua require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
      "Previous Error",
    },
    ["]E"] = {
      "<cmd>lua require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
      "Next Error",
    },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Hover Doc" },
  }

  utils.map("n", normal)

  local status, _ = pcall(require, "which-key")
  if status then
    utils.map("n", {
      ["<leader>"] = {
        ["g"] = {
          name = "Goto",
          ["p"] = "Peek",
        },
      },
    }, true)
  end
end
return M
