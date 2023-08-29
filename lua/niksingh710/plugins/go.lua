if utils.check.vimcmd("GoTagAdd") then
  utils.map("n", {
    ["<leader>Gj"] = { "<cmd>GoTagAdd<cr>", "Go Add Tags to Json" },
  })
end
local ws, _ = pcall(require, "which-key")
if ws then
  utils.map("n", {
    ["<ledaer>"] = {
      ["G"] = {
        name = "Go",
      },
    },
  }, true)
end
