return {
  "nyoom-engineering/oxocarbon.nvim",
  enabled = false,
  lazy = false,
  config = function(_, opts)
    vim.cmd("colorscheme oxocarbon")
    -- for transparency
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "PMenu", { bg = "none" })

    for _, kind in ipairs({
      "Interface",
      "Color",
      "TypeParameter",
      "Text",
      "Enum",
      "Keyword",
      "Constant",
      "Constructor",
      "Reference",
      "Function",
      "Struct",
      "Class",
      "Module",
      "Operator",
      "Field",
      "Property",
      "Event",
      "Unit",
      "Snippet",
      "Folder",
      "Variable",
      "File",
      "Method",
      "Value",
      "EnumMember",
    }) do
      local group = string.format("CmpItemKind%s", kind)
      local bg = vim.api.nvim_get_hl_by_name(group, true)["background"]
      bg = bg and string.format("#%06X", bg) or "NONE"

      vim.api.nvim_set_hl(0, group, { fg = bg })
    end
  end,
}
