local wk = require("which-key")
local utils = require("base.utils")

vim.cmd([[
autocmd FileType cmake,go  lua whichkeyrCmake()
autocmd FileType cmake,go  set tabstop=2
]])
_G.whichkeyrCmake = function()
  local buf = vim.api.nvim_get_current_buf()

  wk.register({
    ["<localleader>"] = {
      name = "major",
      [","] = { utils.format_buffer, "formatting", buffer = buf },
    },
  })
end
