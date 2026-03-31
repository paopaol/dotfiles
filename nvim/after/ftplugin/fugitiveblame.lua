local jz = require("base.jz")

local quit_window = function()
  pcall(jz.close_current_buffer)
  pcall(vim.cmd, [[wincmd c]])
end

require("which-key").add({
  { "q", quit_window, desc = "quit", buffer = true },
})
