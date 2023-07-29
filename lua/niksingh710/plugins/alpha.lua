local astatus, alpha = pcall(require, "alpha")
if not astatus then
  return
end
local dashboard = require("alpha.themes.dashboard")
local name = override.name or "niksingh710"

local btns = {
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("L", "⚯  Language", ":e ~/.config/nvim/lua/niksingh710/languages.lua <CR>"),
}

local tele, _ = pcall(require, "telescope")
if tele then
  table.insert(btns, dashboard.button("f", "  Find file", ":Telescope find_files <CR>"))
  table.insert(btns, dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"))
  table.insert(btns, dashboard.button("p", "  Find project", ":Telescope projects <CR>"))
  table.insert(btns, dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"))
end
local persis, _ = pcall(require, "persisted")
if persis then
  table.insert(btns, dashboard.button(".", "  Last Session", ":SessionLoadLast<cr>"))
  table.insert(btns, dashboard.button("d", "  Last Session of Dir", ":SessionLoad<cr>"))
  table.insert(btns, dashboard.button("l", "  Session List", ":Telescope persisted<cr>"))
end
table.insert(btns, dashboard.button("Q", "  Quit Neovim", ":qa<CR>"))

dashboard.section.buttons.val = btns

dashboard.section.header.val = require("niksingh710.plugins.headers")
dashboard.section.footer.val = "Welcome " .. name .. "!!"

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

utils.map("n", { ["<leader>;"] = { "<cmd>Alpha<CR>", "Dashboard" } })

-- bufferline fix

local toggle_bufferline = vim.api.nvim_create_augroup("ToggleBufferline", { clear = true })
vim.api.nvim_create_autocmd("User", {
  callback = function()
    vim.o.showtabline = 0
  end,
  group = toggle_bufferline,
  pattern = "AlphaReady",
})
vim.api.nvim_create_autocmd("BufUnload", {
  callback = function()
    vim.o.showtabline = 2
  end,
  group = toggle_bufferline,
  pattern = "*",
})

