-- Lsp and lualine highlights {{{
local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })

-- }}}

-- All themes config {{{
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
-- }}}

local theme_status, _ = pcall(require, "tokyodark")
if theme_status then
  vim.cmd("colorscheme tokyodark")
end

if override.theme then
  vim.cmd("silent! colorscheme " .. override.theme)
end

---@diagnostic disable: undefined-field
local transparent_status, transparent = pcall(require, "transparent")
if not transparent_status then
  return
end
vim.cmd([[TransparentEnable]])
transparent.setup({
  extra_groups = {
    -- "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
    "NvimTreeNormal", -- NvimTree
  },
  lualine_style = "default",
  -- lualine_style = "stealth",
})
