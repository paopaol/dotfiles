local wk = require("which-key")
local utils = require("base.utils")

_G.whichkeyrProto = function()
  wk.add({
    { "<localleader>,", utils.format_buffer, desc = "formatting" },
  })
end

vim.cmd([[
augroup filetype_proto
autocmd!
autocmd FileType proto lua whichkeyrProto()
augroup END
]])
