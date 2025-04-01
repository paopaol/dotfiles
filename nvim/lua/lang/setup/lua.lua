local utils = require('base.utils')

local function command(cmd) return function() vim.cmd(cmd) end end

require("base.utils").make_keymap({ "lua" }, "lua-group", {
  { "<localleader>,", utils.format_buffer,  desc = "formatting", },
  { "<localleader>r", command("luafile %"), desc = "run current file", }
}, function()
  vim.bo.shiftwidth = 2
  vim.o.tabstop = 2
  vim.bo.expandtab = true
end)
