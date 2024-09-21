local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeyRust = function()
  wk.add({
    { "<localleader>,", utils.format_buffer, desc = "formatting" },
  })
end

vim.cmd([[
augroup py_grp
  autocmd!
  autocmd FileType rust  lua whichkeyRust()
augroup END
]])
