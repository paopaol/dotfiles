vim.bo.shiftwidth = 2
vim.o.tabstop = 2
vim.bo.expandtab = true

local utils = require("base.utils")

local function command(cmd)
  return function()
    vim.cmd(cmd)
  end
end

require("which-key").add({
  { "<localleader>,", utils.format_buffer, desc = "formatting", buffer = true },
  { "<localleader>r", command("luafile %"), desc = "run current file", buffer = true },
})
