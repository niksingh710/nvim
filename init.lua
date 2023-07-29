vim.loader.enable()

status, override = pcall(require, "override")
if not status then
  override = {}
end

-- icons stole from lunarvim!!
require "niksingh710.core"

if override.plugins.enable then
  require "niksingh710.plugins"
end

if override.file then
  require "override.config"
end

--[[
-- Make Sure if you create lua/override/init.lua or lua/override.lua it should have this format
-- here you can disable plugins you don't feel to use or plugins all together if you want minimal config
return {
  theme = "habamax",
  name = "niksingh710",      -- default value of alpha greet message
  file = true,               -- if this variable is true then you can use load your configs from `config.lua` in override dir
  plugins = {
    enable = true,
    list = {
      -- put plugins name to disable e.g folke/which-key.nvim = which_key
      -- Remember if a plugin is required by other plugin it will stay enabled
      which_key = false, -- btw if disabled which key may loose mappign for multiple plugins
      dressing = flase,
    }
  },
}
]]--

