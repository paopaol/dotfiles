vim.cmd("runtime! ftplugin/git.lua")

local utils = require("base.utils")
local jz = require("base.jz")

local quit_window = function()
  pcall(jz.close_current_buffer)
  pcall(vim.cmd, [[wincmd c]])
end

require("which-key").add({
  { "<tab>", utils.command("normal ="), desc = "toggle diff", buffer = true },
  { "q", quit_window, desc = "quit", buffer = true },
})
