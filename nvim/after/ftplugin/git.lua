local utils = require("base.utils")
local jz = require("base.jz")

local close_buffer_and_quickfix = function()
  pcall(vim.cmd, [[cclose]])
  pcall(jz.close_current_buffer)
  pcall(vim.cmd, [[wincmd c]])
end

require("which-key").add({
  { "<localleader><C-t>", utils.command("normal O"), desc = "open with tab", buffer = true },
  { "<localleader>gv", utils.command("normal gO"), desc = "open with vertical", buffer = true },
  { "<localleader>gs", utils.command("normal o"), desc = "open with split", buffer = true },
  { "q", close_buffer_and_quickfix, desc = "quit", buffer = true },
})
