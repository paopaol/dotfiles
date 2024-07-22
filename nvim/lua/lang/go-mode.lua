local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeyGoCmake = function()
  wk.add({
    { "<localleader>,", utils.format_buffer, desc = "formatting" },
  })
end

vim.cmd([[
augroup go_grp
  autocmd!
  autocmd FileType cmake,go  lua whichkeyGoCmake()
  autocmd FileType cmake,go  set tabstop=2
augroup END
]])
